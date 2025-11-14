//
//  CoreData_PrimitivesApp.swift
//  CoreData-Primitives
//
//  Created by MOBILE HUTT on 14/11/25.
//

import SwiftUI

@main
struct CoreData_PrimitivesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
