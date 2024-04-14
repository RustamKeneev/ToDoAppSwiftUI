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
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""

    let priorities = ["High", "Normal", "Low"]
    
    //THEME
    @ObservedObject var theme = ThemeSettings()
    var themes: [Theme] = themeData

    //MARK: - BODY
    var body: some View {
        NavigationView{
            VStack{
                VStack(alignment: .leading, spacing: 20){
                    //MARK: - TODO NAME
                    TextField("Todo", text: $name)
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(10)
                        .font(.system(size: 24, weight: .bold, design: .default))
                    
                    //MARK: - TODO PRIORITY
                    Picker("Priority", selection: $priority){
                        ForEach(priorities, id: \.self){
                            Text($0)
                        }//: LOOP
                    }//: PICKER
                    .pickerStyle(SegmentedPickerStyle())
                    
                    //MARK: - SAVE BUTTON
                    Button(action: {
                        if self.name != "" {
                            let todo = Todo(context: self.managedObjectContext)
                            todo.name = self.name
                            todo.priority = self.priority
                            do{
                                try self.managedObjectContext.save()
                                print("New Todo: \(todo.name ?? ""), Priority \(todo.priority ?? "")")
                            }catch{
                                print(error)
                            }
                        }else{
                            self.errorShowing = true
                            self.errorTitle = "Invalid Name"
                            self.errorMessage = "Make sure to enter something for\n the todo item"
                            return
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    }){
                        Text("Save")
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .padding()
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity)
                            .background(themes[self.theme.themeSettings].themeColor)
                            .cornerRadius(10)
                            .foregroundColor(Color.white)
                    }// BUTTON SAVE
                }//: VSTACK
                .padding(.horizontal)
                .padding(.vertical, 30)
                Spacer()
            }//:VSTACK
            .navigationBarTitle("New ToDo", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }){
                Image(systemName: "xmark")
            })
            .alert(isPresented: $errorShowing){
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }//: NAVIGATION
        .accentColor(themes[self.theme.themeSettings].themeColor)
        .navigationViewStyle(StackNavigationViewStyle())

    }
}

//MARK: - PREVIEW
#Preview {
    AddTodoView()
}
