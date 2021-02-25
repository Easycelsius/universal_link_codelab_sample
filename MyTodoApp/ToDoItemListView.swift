//
//  ContentView.swift
//  MyTodoApp
//
//  Created by Suhyun Sophia Lee on 2020/08/12.
//  Copyright © 2020 Suhyun. All rights reserved.
//

import SwiftUI
import CoreData

struct ToDoItemListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: ToDo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ToDo.id, ascending: false)]) var todolist: FetchedResults<ToDo>
    
    @State private var showAddTodoView: Bool = false
    
    var body: some View {
        NavigationView{
            List{
                ForEach(self.todolist, id: \.self) { todo in
                    Text(todo.content)
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        viewContext.delete(todolist[index])
                    }
                    do {
                        try viewContext.save()
                    }catch{
                        print(error.localizedDescription)
                    }
                }
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
                    AddToDoItemView().environment(\.managedObjectContext, self.viewContext)
                }
            )
        }
    }
}

struct ToDoItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoItemListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
