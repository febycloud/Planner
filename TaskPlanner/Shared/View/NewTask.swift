//
//  NewTask.swift
//  TaskPlanner (iOS)
//
//  Created by Fei Yun on 2022-01-19.
//

import SwiftUI

struct NewTask: View {
    @Environment(\.dismiss) var dismiss
    //Task value
    @State var taskTitle: String=""
    @State var taskDescription:String=""
    @State var taskDate:Date=Date()
    
    //Core data Context
    @Environment(\.managedObjectContext) var context
    @EnvironmentObject var taskModel:TaskViewModel
    
    var body: some View {
        NavigationView{
            List{
                
                Section{
                    TextField("This is title",text:$taskTitle)
                }header: {
                    Text("Task Title")
                }
                
                Section{
                    TextField("This is description",text:$taskDescription)
                }header: {
                    Text("Task Description")
                }
                
                //disable date for edit mode
                if taskModel.editTask==nil{
                    Section{
                        DatePicker("",selection: $taskDate)
                            .datePickerStyle(.graphical)
                            .labelsHidden()
                    }header: {
                        Text("Task Date")
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Add New")
            .navigationBarTitleDisplayMode(.inline)
            .interactiveDismissDisabled()
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Save"){
                        if let task=taskModel.editTask{
                            task.taskTitle=taskTitle
                            task.taskDescription=taskDescription
                        }
                        else{
                            let task=Task(context: context)
                            task.taskTitle=taskTitle
                            task.taskDescription=taskDescription
                            task.taskDate=taskDate
                        }
                        //saving
                        try?context.save()
                        dismiss()
                    }
                }
            }
            .onAppear{
                if let task=taskModel.editTask{
                    taskTitle=task.taskTitle ?? ""
                    taskDescription=task.taskDescription ?? ""
                }
            }
            
        }
    }
}

struct NewTask_Previews: PreviewProvider {
    static var previews: some View {
        NewTask()
    }
}
