//
//  ContentView.swift
//  MyTodoApp
//
//  Created by Suhyun Sophia Lee on 2020/08/12.
//  Copyright © 2020 Suhyun. All rights reserved.
//

import SwiftUI

struct ToDoItemListView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: ToDo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ToDo.id, ascending: false)]) var todolist: FetchedResults<ToDo>
    @State private var showAddTodoView: Bool = false
    
    var body: some View {
        NavigationView{
            List{
                ForEach(self.todolist, id: \.self) { todo in
                    Text(todo.content ?? "Unknown")
                }.onDelete(perform: deleteTodo(at:))
            }
            .navigationBarTitle("My Todo", displayMode: .inline)
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                Button(action: {
                    print(self.$showAddTodoView)
                    self.showAddTodoView.toggle()
                }){
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $showAddTodoView){
                    AddToDoItemView().environment(\.managedObjectContext, self.managedObjectContext)
                }
            )
        }
    }
    private func deleteTodo(at offsets: IndexSet) {
        for index in offsets {
            let todo = todolist[index]
            managedObjectContext.delete(todo)
            
            do{
                try managedObjectContext.save()
            }catch{
                
            }
        }
    }
}


struct ToDoItemListView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return ToDoItemListView().environment(\.managedObjectContext, context)
    }
}
