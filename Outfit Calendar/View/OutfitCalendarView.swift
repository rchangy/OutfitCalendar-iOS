//
//  OutfitCalendarView.swift
//  Outfit Calendar
//
//  Created by Han-Chih Chang on 2025/4/7.
//

import SwiftUI

struct OutfitCalendarView: View {
    @ObservedObject var calendarViewModel = CalendarViewModel(userId: 0)
    
    @State private var dateSelected: DateComponents?
    @State private var path = [DateComponents]()
    
    var wearingHistoryRepository = WearingHistoryRepository.shared
    
    var body: some View {
        NavigationStack(path: $path) {
            CalendarView(interval: DateInterval(start: .distantPast, end: .now), calendarViewModel: calendarViewModel,
                         dateSelected: $dateSelected, path: $path)
                .navigationDestination(for: DateComponents.self) { date in
                    Text("\(Calendar.current.date(from: date) ?? Date.now)")
                }
        }
    }
}

struct CalendarView: UIViewRepresentable {
    let interval: DateInterval
    @ObservedObject var calendarViewModel: CalendarViewModel
    
    @Binding var dateSelected: DateComponents?
    @Binding var path: [DateComponents]
    
    func makeUIView(context: Context) -> UICalendarView {
        let view = UICalendarView()
        view.delegate = context.coordinator
        view.calendar = Calendar(identifier: .gregorian)
        view.availableDateRange = interval
        let dateSelection = UICalendarSelectionSingleDate(delegate: context.coordinator)
        view.selectionBehavior = dateSelection
        return view
    }
    
    func updateUIView(_ uiView: UICalendarView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self, calendarViewModel: _calendarViewModel)
    }
    
    class Coordinator: NSObject, UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
        var parent: CalendarView
        @ObservedObject var calendarViewModel: CalendarViewModel
        
        init(parent: CalendarView, calendarViewModel: ObservedObject<CalendarViewModel>) {
            self.parent = parent
            self._calendarViewModel = calendarViewModel
        }
        
        @MainActor
        func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
            let ootds = calendarViewModel.wearingHistory
                .filter {
                    $0.date.startOfDay == dateComponents.date?.startOfDay
                }
            if ootds.isEmpty { return nil }
            return .customView {
                let icon = UILabel()
                icon.text = "x"
                return icon
            }
        }
        
        func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
            parent.dateSelected = dateComponents
            guard let dateComponents else { return }
            
            let ootds = calendarViewModel.wearingHistory
                .filter {
                    $0.date.startOfDay == dateComponents.date?.startOfDay
                }
            if !ootds.isEmpty {
                parent.path.append(dateComponents)
            }
        }
        
        func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool {
            return true
        }
    }
}
