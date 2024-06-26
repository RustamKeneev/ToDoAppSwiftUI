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
    @EnvironmentObject var iconSettings: IconNames
    
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)]) var todos: FetchedResults<Todo>
    
    @State private var showAddTodoView: Bool = false
    @State private var animatingButton: Bool = false
    @State private var showingSettingsView: Bool = false

    //: THEME
    @ObservedObject var theme = ThemeSettings()
    var themes: [Theme] = themeData
    
    //MARK: - BODY
    var body: some View {
        NavigationView{
            ZStack {
                List{
                    ForEach(self.todos, id: \.self){ item in
                        HStack{
                            Circle()
                                .frame(width: 12, height: 12, alignment: .center)
                                .foregroundColor(self.colorize(priority: item.priority ?? "Normal"))
                            Text(item.name ?? "Unknown")
                                .fontWeight(.semibold)
                            Spacer()
                            Text(item.priority ?? "Unknown")
                                .font(.footnote)
                                .foregroundColor(Color(UIColor.systemGray2))
                                .padding(4)
                                .frame(minWidth: 62)
                                .overlay(
                                    Capsule()
                                        .stroke(Color(UIColor.systemGray2), lineWidth: 0.75)
                                )
                        }//: HSTACK
                        .padding(.vertical, 10)
                    }//: FOREACH
                    .onDelete(perform: deleteToDo)
                }//: LIST
                .navigationBarTitle("ToDo", displayMode: .inline)
                .navigationBarItems(
                    leading: EditButton().accentColor(themes[self.theme.themeSettings].themeColor),
                    trailing: Button(action: {
                    //SHOW ADD TODO VIEW
                    self.showingSettingsView.toggle()
                }){
                    Image(systemName: "paintbrush")
                        .imageScale(.large)
                })//: BUTTON SETTING
                .accentColor(themes[self.theme.themeSettings].themeColor)
                .sheet(isPresented: $showingSettingsView){
                    SettingsView()
                        .environmentObject(self.iconSettings)
            }
                //MARK: - NO TODO ITEMS
                if todos.count == 0 {
                    EmptyListView()
                }
            }//: ZSTACK
            .sheet(isPresented: $showAddTodoView){
                AddTodoView()
                    .environment(\.managedObjectContext, self.managedObjectContext)
                    
        }
            .overlay(
                ZStack {
                    Group{
                        Circle()
                            .fill(themes[self.theme.themeSettings].themeColor)
                            .opacity(self.animatingButton ? 0.2 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 68, height: 68, alignment: .center)
                        Circle()
                            .fill(themes[self.theme.themeSettings].themeColor)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .opacity(self.animatingButton ? 0.15 : 0)
                            .frame(width: 88, height: 88, alignment: .center)

                    }
                    .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true))
                    Spacer()
                    Button(action: {
                        self.showAddTodoView.toggle()
                    }){
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .background(Circle().fill(Color("ColorBase")))
                            .frame(width: 48, height: 48, alignment: .center)
                    }//: Button
                    .accentColor(themes[self.theme.themeSettings].themeColor)
                }//: ZSTACK
                    .padding(.bottom, 16)
                    .padding(.trailing, 16)
                ,alignment: .bottomTrailing
            )
            .onAppear {
                self.animatingButton.toggle()
            }
        }//: NAVIGATION
        .navigationViewStyle(StackNavigationViewStyle())
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
    
    private func colorize(priority: String) -> Color {
        switch priority {
        case "Hight":
            return .pink
        case "Normal":
            return .green
        case "Low":
            return .blue
        default:
            return .gray
        }
    }
}

//MARK: - PREVIEW
#Preview {
    ContentView()
}
