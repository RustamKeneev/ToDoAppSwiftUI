//
//  ContentView.swift
//  ToDoAppSwiftUI
//
//  Created by Rustam Keneev on 23/3/24.
//

import SwiftUI

struct ContentView: View {
    //MARK: - PROPERTIES
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)]) var todos: FetchedResults<Todo>
    
    @State private var showAddTodoView: Bool = false

    //MARK: - BODY
    var body: some View {
        NavigationView{
            List{
                ForEach(self.todos, id: \.self){ item in
                    HStack{
                        Text(item.name ?? "Unknown")
                        Spacer()
                        Text(item.priority ?? "Unknown")
                    }
                }//: FOREACH
                .onDelete(perform: deleteToDo)
            }//: LIST
            .navigationBarTitle("ToDo", displayMode: .inline)
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button(action: {
                //SHOW ADD TODO VIEW
                self.showAddTodoView.toggle()
            }){
                Image(systemName: "plus")
            })//: BUTTON ADD
            .sheet(isPresented: $showAddTodoView){
                AddTodoView()
                    .environment(\.managedObjectContext, self.managedObjectContext)
            }
        }//: NAVIGATION
    }
    
    //MARK: - FUNCTIONS
    func deleteToDo(at offsets: IndexSet){
        for index in offsets {
            let todo = todos[index]
            managedObjectContext.delete(todo)
            do{
                try managedObjectContext.save()
            }catch{
                print(error)
            }
        }
    }
}

//MARK: - PREVIEW
#Preview {
    ContentView()
}
