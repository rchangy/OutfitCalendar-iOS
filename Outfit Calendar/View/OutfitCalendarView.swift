//
//  OutfitCalendarView.swift
//  Outfit Calendar
//
//  Created by Han-Chih Chang on 2025/4/7.
//

import SwiftUI

struct OutfitCalendarView: View {
    @ObservedObject var calendarViewModel = CalendarViewModel(userId: 0)
    
    var wearingHistoryRepository = WearingHistoryRepository.shared
    
    var body: some View {
        NavigationStack {
            CalendarView(interval: DateInterval(start: .distantPast, end: .now), calendarViewModel: calendarViewModel)
                .navigationDestination(for: DateComponents.self) { date in
                    Text("\(Calendar.current.date(from: date) ?? Date.now)")
                }
        }
    }
}

struct CalendarView: UIViewRepresentable {
    let interval: DateInterval
    @ObservedObject var calendarViewModel: CalendarViewModel
    
    func makeUIView(context: Context) -> UICalendarView {
        let view = UICalendarView()
        view.delegate = context.coordinator
        view.calendar = Calendar(identifier: .gregorian)
        view.availableDateRange = interval
        return view
    }
    
    func updateUIView(_ uiView: UICalendarView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self, calendarViewModel: _calendarViewModel)
    }
    
    class Coordinator: NSObject, UICalendarViewDelegate {
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
    }
}
