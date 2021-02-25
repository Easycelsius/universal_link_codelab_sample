//
//  AddToDoItemView.swift
//  MyTodoApp
//
//  Created by Suhyun Sophia Lee on 2021/02/15.
//  Copyright © 2021 Suhyun. All rights reserved.
//

import SwiftUI

struct AddToDoItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var viewContext
    
    @State private var content: String = ""
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
    var body: some View {
        NavigationView{
            VStack{
                VStack(alignment: .leading, spacing: 20){
                    TextField("Todo", text: $content)
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(9)
                    Button(action: {
                        if self.content != ""{
                            let todo = ToDo(context: self.viewContext)
                            todo.content = self.content
                            do {
                                try self.viewContext.save()
                            }catch{
                                print(error)
                            }
                        }
                        else{
                            self.errorShowing = true
                            self.errorTitle = "no content"
                            self.errorMessage = "enter todo"
                            return
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    }){
                        Text("Save")
                            .fontWeight(.bold)
                            .frame(minWidth:0, maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(9)
                            .foregroundColor(Color.white)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical,30)
                Spacer()
            }
            .navigationBarTitle("Add Todo", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action:{
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Image(systemName: "xmark")
            })
        }.alert(isPresented: $errorShowing){
            Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("Return")))
        }
        
    }
}

struct AddToDoItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddToDoItemView()
    }
}
