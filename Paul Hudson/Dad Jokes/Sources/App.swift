import UIKit
import CoreData
import SwiftUI

/// The main entrance to the application
@main struct Application: App {
    /// Jokes data provider.
    @StateObject private var services = Services()
    /// Observer of scene lifecycle.
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.managedObjectContext, self.services.persistentContainer.viewContext)
                .onChange(of: self.scenePhase) {
                    guard case .background = $0 else { return }
                    self.services.saveContext()
                }
        }
    }
}

private final class Services: ObservableObject {
    // The persistent container for the application.
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DadJokes")
        container.loadPersistentStores { (storeDescription, error) in
            guard let error = error as NSError? else { return }
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
        return container
    }()
    
    /// Saves the the jokes in the database.
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
