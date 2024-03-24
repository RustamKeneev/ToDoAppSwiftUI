//
//  ToDoAppSwiftUIApp.swift
//  ToDoAppSwiftUI
//
//  Created by Rustam Keneev on 23/3/24.
//

import SwiftUI
import CoreData

@main
struct ToDoAppSwiftUIApp: App {
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Todo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistentContainer.viewContext)
        }
    }
}
