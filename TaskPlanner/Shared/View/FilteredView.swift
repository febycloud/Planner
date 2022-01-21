//
//  FilteredView.swift
//  TaskPlanner (iOS)
//
//  Created by Fei Yun on 2022-01-19.
//

import SwiftUI
import CoreData

struct FilteredView<Content:View,T>: View where T:NSManagedObject{
    //Request core data
    @FetchRequest var request:FetchedResults<T>
    let content:(T)->Content
    
    //Building custom Foreach which will give Coredata object to build view
    init(dateToFilter:Date,@ViewBuilder content: @escaping(T)->Content){
        let calendar=Calendar.current
        let today=calendar.startOfDay(for: dateToFilter)
        let tommorow=calendar.date(byAdding: .day, value: 1, to: today)!
        //filter key
        let filterKey="taskDate"
        
        let predicate=NSPredicate(format: "\(filterKey)>= %@ AND \(filterKey) <%@", argumentArray: [today,tommorow])
        
        _request=FetchRequest(entity:T.entity(),sortDescriptors: [.init(keyPath: \Task.taskDate,ascending: false)],
                              predicate: predicate)
        self.content=content
    }
    
    
    
    var body: some View {
        Group{
            if request.isEmpty{
                Text("No tasks fund!")
                    .font(.system(size:16))
                    .fontWeight(.light)
                    .offset(y:100)
            }
            else{
                ForEach(request,id:\.objectID){object in
                    self.content(object)
                }
            }
        }
    }
}
