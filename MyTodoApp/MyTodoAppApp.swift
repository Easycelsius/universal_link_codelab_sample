//
//  MyTodoApp.swift
//  MyTodoApp
//
//  Created by Suhyun Sophia Lee on 2021/02/25.
//  Copyright © 2021 Suhyun. All rights reserved.
//

import SwiftUI

@main
struct MyTodoAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ToDoItemListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
