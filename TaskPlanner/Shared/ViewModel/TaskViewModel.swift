//
//  TaskViewModel.swift
//  TaskPlanner (iOS)
//
//  Created by Fei Yun on 2022-01-18.
//

import SwiftUI

class TaskViewModel:ObservableObject{
    
    //current week day
    @Published var currentWeek:[Date]=[]
    //current day
    @Published var currentDay:Date=Date()
    //today's task
    @Published var filteredTask:[Task]?
    //added new task view
    @Published var addNewTask:Bool=false
    //edit task
    @Published var editTask:Task?
    
    
    init(){
        fetchCurrentWeek()
    }
    
    
    func fetchCurrentWeek(){
        let today=Date()
        let calendar=Calendar.current
        let week=calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay=week?.start else{
            return
        }
        
        (0..<7).forEach{ day in
            if let weekday=calendar.date(byAdding: .day, value: day, to: firstWeekDay){
                currentWeek.append(weekday)
            }
        
        }
    }
 
    //extracting date
    func extractDate(date:Date,format: String)->String{
        let formatter=DateFormatter()
        formatter.dateFormat=format
        return formatter.string(from:date)
    }
    
    //check is today or not
    func isToday(date:Date)->Bool{
        let calendar=Calendar.current
        return calendar.isDate(currentDay, inSameDayAs: date)
    }
    
    //check is current hour is take hour or not
    func isCurrentHour(date:Date)->Bool{
        let calendar=Calendar.current
        let hour=calendar.component(.hour, from: date)
        let currentHour=calendar.component(.hour, from: Date())
        let isToday=calendar.isDateInToday(date)
        
        return (hour==currentHour&&isToday)
    }
}
