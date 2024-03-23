//
//  AddTodoView.swift
//  ToDoAppSwiftUI
//
//  Created by Rustam Keneev on 23/3/24.
//

import SwiftUI

struct AddTodoView: View {
    //MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    
    let priorities = ["High", "Normal", "Low"]

    //MARK: - BODY
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    //MARK: - TODO NAME
                    TextField("Todo", text: $name)
                    
                    //MARK: - TODO PRIORITY
                    Picker("Priority", selection: $priority){
                        ForEach(priorities, id: \.self){
                            Text($0)
                        }//: LOOP
                    }//: PICKER
                    .pickerStyle(SegmentedPickerStyle())
                    
                    //MARK: - SAVE BUTTON
                    Button(action: {
                        print("Save a new todo item")
                    }){
                        Text("Save")
                    }// BUTTON SAVE
                }//: FORM
                Spacer()
            }//:VSTACK
            .navigationBarTitle("New ToDo", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }){
                Image(systemName: "xmark")
            })
        }//: NAVIGATION
    }
}

//MARK: - PREVIEW
#Preview {
    AddTodoView()
}
