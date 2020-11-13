//
//  NewTask.swift
//  Agenda
//
//  Created by Juan Capponi on 11/13/20.
//

import SwiftUI

struct NewTask: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [])
    private var tasks: FetchedResults<Task>
    
    
    @Environment(\.presentationMode) var presentationMode

    @State var textDescription = String()
    @State var title = String()
    var body: some View {
        VStack {
            Text("Crea una nueva tarea")
                .font(.largeTitle)
            
            Spacer(minLength: 30)
            
            
            HStack(alignment: .center) {
                Text("Nombre de la tarea: ")
                    .font(.callout)
                    .bold()
                TextField("Título", text: $title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }.padding()
            
            Spacer(minLength: 20)
            
            HStack {
                Text("Detalle de la Tarea: ")
                    .font(.callout)
                    .bold()
                    .padding()
                Spacer()
            }
            TextEditor(text: $textDescription)
                .font(.callout)
                    //.lineSpacing(20)
                    //.autocapitalization(.words)
                    //.textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            
            
            Button( action:  addTask ,
            label: { Text("Guardar")
                .font(.title2)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(4)
            })
            Spacer()
                .frame(height: 30)
        }
    }
    
    
    private func addTask(){
        withAnimation {
            let newTask = Task(context: viewContext)
            newTask.title = title 
            newTask.taskDescription = textDescription
            newTask.date = Date()
            saveContext()
        }
        presentationMode.wrappedValue.dismiss()
        
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Error description..: \(error.localizedDescription)")
        }
    }
    
}




struct NewTask_Previews: PreviewProvider {
    static var previews: some View {
        NewTask()
    }
}


extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
