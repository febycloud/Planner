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
        let calender=Calendar.current
        let week=calender.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay=week?.start else{
            return
        }
        
        (0..<7).forEach{ day in
            if let weekday=calender.date(byAdding: .day, value: day, to: firstWeekDay){
                currentWeek.append(weekday)
            }
        
        }
    }
 
    
    
    
    
}
