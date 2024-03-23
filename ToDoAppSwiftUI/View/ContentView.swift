//
//  ContentView.swift
//  ToDoAppSwiftUI
//
//  Created by Rustam Keneev on 23/3/24.
//

import SwiftUI

struct ContentView: View {
    //MARK: - PROPERTIES
    @State private var showAddTodoView: Bool = false

    //MARK: - BODY
    var body: some View {
        NavigationView{
            List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                Text("Text")
            }//: LIST
            .navigationBarTitle("ToDo", displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: {
                //SHOW ADD TODO VIEW
                self.showAddTodoView.toggle()
            }){
                Image(systemName: "plus")
            })//: BUTTON ADD
            .sheet(isPresented: $showAddTodoView){
                AddTodoView()
            }
        }//: NAVIGATION
    }
}

//MARK: - PREVIEW
#Preview {
    ContentView()
}
