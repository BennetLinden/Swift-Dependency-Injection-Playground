/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # Dependency Injection Flavours
 
 In general there are three flavours of Dependency Injection. Let's go over them quickly:
 
 ## Initializer Injection
 
 Initializer injection means that an object is given the dependencies it needs when being initialized. This guarantees that our objects have everything they need in order to do their work right away.
 
 **Benefits:**
 * It is clear which dependencies an object has when initializing it
 * Dependencies can be made immutable by declaring them as let
 * Adding new dependencies will trigger compile time errors
 
 See the following example of a **FileLoader** class that has an initializer-based dependency on a **FileManager**:
 */

import Foundation

class FileLoader {
    
    let fileManager: FileManager
    
    init(fileManager: FileManager) {
        self.fileManager = fileManager
    }
}

/*:
 ## Property Injection
 Sometimes it's not possible to add your own initializer with dependencies, or you don't have the dependencies ready yet. In that case you can resort to property injection. Instead of injecting an object's dependencies in its initializer, they can simply be assigned afterwards.
 
 **Benefits:**
 * Instantiate an object without dependencies
 * No need to implement a custom initializer
 * Change dependencies during life-cycle of object, for example to set a new delegate
 
 See the following example of a **NetworkService** with a weak delegate property, which gets assigned after the **NetworkService** has been initialized:
 */

protocol NetworkDelegate: AnyObject { }

class Worker: NetworkDelegate { }

class NetworkService {
    
    weak var delegate: NetworkDelegate?
}

let networkService = NetworkService()
networkService.delegate = Worker()

/*:
 ## Parameter Injection
 Often a specific dependency is only needed once. So instead of defining a global property, and having to change an object's initializer or expose properties as mutable, the depencency can be injected through parameter injection.
 
 **Benefits:**
 * No need to implement a custom initializer
 * No need to define a global (mutable) property
 * Simple way to inject a dependency in a legacy class without the need to refactor
 
 See the following example of a **DataService** object with a function to perform some task with data on a **DispatchQueue**. Instead of defining the queue as a property inside the **DataService**, it (together with data) is passed as a parameter dependency in the function:
 */

class DataService {
    
    func performTask(with data: Data, on queue: DispatchQueue) {
        queue.async {
            // Perform some task with data
        }
    }
}

/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
