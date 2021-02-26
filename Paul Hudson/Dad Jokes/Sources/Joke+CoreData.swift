import Foundation
import CoreData

@objc(Joke) public class Joke: NSManagedObject {}

extension Joke {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Joke> {
        NSFetchRequest<Joke>(entityName: "Joke")
    }

    @NSManaged public var setup: String
    @NSManaged public var punchline: String
    @NSManaged public var rating: String
}
