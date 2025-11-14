//
//  ContentView.swift
//  CoreData-Primitives
//
//  Created by MOBILE HUTT on 14/11/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Person.created, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Person>
    
    @State private var name = ""
    @State private var email = ""
    @State private var age = ""
    @State private var isActive = false
    @State private var salary = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Enter Primitive Types")) {
                        TextField("Enter Name", text: $name)
                        TextField("Enter email", text: $email)
                        
                        TextField("Age (Int)", text: $age)
                            .keyboardType(.numberPad)
                        
                        TextField("Salary (Double)", text: $salary)
                            .keyboardType(.decimalPad)
                        
                        Toggle(isOn: $isActive) {
                            Text("Active (Bool)")
                        }
                    }
                    Button("Save Record") {
                        
                    }
                    .frame(maxWidth: .infinity)
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .navigationTitle("Core Data - Primitive Types")
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
