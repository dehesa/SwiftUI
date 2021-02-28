import Foundation
import CoreData

/// Joke instance in database.
@objc(Joke) public class Joke: NSManagedObject {
    @NSManaged public var setup: String
    @NSManaged public var punchline: String
    @NSManaged public var rating: String
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Joke> {
        NSFetchRequest<Joke>(entityName: "Joke")
    }
}
