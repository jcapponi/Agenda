//
//  ContentView.swift
//  Agenda
//
//  Created by Juan Capponi on 11/12/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [])
    var tasks: FetchedResults<Task>
    
    @State var showNewTaskView =  false
    @State var showTaskDetailView = false
    
    var body: some View {
        NavigationView {
            ZStack {
            List {
                ForEach(tasks) { task in
                    VStack(alignment: .leading){
                    
                        Text(task.title ?? "Tarea sin título")
                            .font(.headline)
                        Text(task.taskDescription ?? "No hay descrpipción")
                            .font(.caption)
                        Text("\(task.date!, formatter: Self.taskDateFormat)")
                            .font(.caption)
                    }
                }.onDelete(perform: deleteTask)
                    }
                VStack {
                    Spacer()
                    Button(action: { showNewTaskView.toggle() }, label: {
                            Image(systemName: "plus")
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.green)
                                .clipShape(Circle())
                        })
                    Spacer()
                        .frame(height: 30)
                    }
                }
                .navigationTitle("Lista de Tareas")
                .sheet(isPresented: $showNewTaskView) { NewTask()
                }
            }
    }

    private func updateTask(_ task: FetchedResults<Task>.Element) {
        withAnimation {
            task.title = "Actualizado"
            saveContext()
        }
    }
    
    private func deleteTask(at indexSet: IndexSet) {
        withAnimation {
            indexSet.map { tasks[$0] }.forEach(viewContext.delete)
            saveContext()
        }
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Error description..: \(error.localizedDescription)")
        }
    }
    
    
    static let taskDateFormat: DateFormatter = {
            let formatter = DateFormatter()
        formatter.dateStyle = .short
            return formatter
        }()
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



