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
    
    private var persons: FetchedResults<Person>
    
    @State private var name = ""
    @State private var email = ""
    @State private var id = ""
    @State private var age = ""
    @State private var isActive = false
    @State private var salary = ""
    
    @State private var selectedPerson: Person? = nil
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Enter Primitive Types")) {
                        TextField("Enter Name", text: $name)
                        TextField("Enter email", text: $email)
                        
                        TextField("Enter ID (UUID)", text: $id)
                        
                        TextField("Age (Int)", text: $age)
                            .keyboardType(.numberPad)
                        
                        TextField("Salary (Double)", text: $salary)
                            .keyboardType(.decimalPad)
                        
                        Toggle(isOn: $isActive) {
                            Text("Active (Bool)")
                        }
                    }
                    Button(selectedPerson == nil ? "Save Record" : "Update Record") {
                        
                        if validateFields() {
                            if selectedPerson == nil {
                                saveData()
                            } else {
                                updateData()
                            }
                        }else {
                            showAlert = true
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .buttonStyle(.borderedProminent)
                    .alert("Error", isPresented: $showAlert) {
                        
                    }
                }
                
                List {
                    ForEach(persons) { person in
                        VStack {
                            Text(person.name ?? "")
                                .font(.headline)
                            Text("Email: \(person.email ?? "")")
                                .font(.subheadline)
                            Text("ID: \(person.id ?? UUID())")
                            Text("Age: \(person.age)")
                            Text("Salary: \(person.salary)")
                            Text("Active: \(person.isActive.description)")
                        }
                        .onTapGesture {
                            loadPerson(person)
                        }
                    }
                    .onDelete(perform: deletePerson)
                }
            }
        }
        .navigationTitle("Core Data - Primitive Types")
    }
    
    private func validateFields() -> Bool {
        if name.trimmingCharacters(in: .whitespaces).isEmpty {
            alertMessage = "Please enter a valid name."
            showAlert = true
            return false
        }
        
        if email.trimmingCharacters(in: .whitespaces).isEmpty {
            alertMessage = "Please enter a valid email."
            showAlert = true
            return false
        }
        
        if age.trimmingCharacters(in: .whitespaces).isEmpty {
            alertMessage = "Please enter age."
            showAlert = true
            return false
        }
        
        if salary.trimmingCharacters(in: .whitespaces).isEmpty {
            alertMessage = "Please enter salary."
            showAlert = true
            return false
        }
        
        return true
    }
    
    
    func resetForm() {
        name = ""
        email = ""
        age = ""
        salary = ""
        isActive = false
    }
    
    func saveData() {
        let person = Person(context: viewContext)
        person.name = name
        person.email = email
        person.id = UUID(uuidString: id) ?? UUID()
        person.age = Int16(age) ?? 0
        person.salary = Double(salary) ?? 0.0
        person.isActive = Bool(isActive)
        do {
            try viewContext.save()
            resetForm()
        }catch {
            fatalError("Saving failed with error \(error)")
        }
    }
    
    private func updateData() {
        guard let person = selectedPerson else { return }
        
        person.name = name
        person.email = email
        person.id = UUID(uuidString: id) ?? UUID()
        person.age = Int16(age) ?? 0
        person.salary = Double(salary) ?? 0.0
        person.isActive = isActive
        
        try? viewContext.save()
        resetForm()
    }
    
    private func deletePerson(offsets: IndexSet) {
        offsets.forEach { index in
            let person = persons[index]
            viewContext.delete(person)
        }
        try? viewContext.save()
    }
    
    private func loadPerson(_ person: Person) {
        selectedPerson = person
        name = person.name ?? ""
        id = person.id?.uuidString ?? ""
        email = person.email ?? ""
        age = "\(person.age)"
        salary = "\(person.salary)"
        isActive = person.isActive
    }
}




#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
