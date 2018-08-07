/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # Providing Dependencies
 
 The goal is to be able to create a `SettingsViewController` without knowing about its dependencies.
 
 ## Dependency Provider
 In order to do so, we'll introduce the `DependencyProvider`, a protocol that describes all the dependencies it can provide and create.
 
 The `DependencyProvider` protocol is great for testing because you can replace the real implementations of dependencies, such as networking, with mocked implementations.
 */

import Foundation
import UIKit

protocol DependencyProvider {
    
    func makeSettingsViewController() -> UIViewController
    func makeSettingsPresenter() -> SettingsPresenter
}

/*:
 This `DependencyProvider` has two factory methods: one for creating the SettingsViewController and one for creating the SettingsPresenter. Both methods don't take any argument, as to be able to create the SettingsViewController with a SettingsPresenter, without knowing about the SettingsPresenter.
 
 ## Dependency Container
 The next step is actually implementing the `DependencyProvider` protocol in a `DependencyContainer`:
 */

class DependencyContainer: DependencyProvider {
    
    func makeSettingsViewController() -> UIViewController {
        return SettingsViewController(presenter: makeSettingsPresenter())
    }
    
    func makeSettingsPresenter() -> SettingsPresenter {
        return SettingsPresenter()
    }
}

/*:
 The `DependencyContainer` implements both factory methods defined in the `DependencyProvider` protocol. Internally it's using the `makeSettingsPresenter` factory method to create the `SettingsPresenter` dependency for initializing the `SettingsViewController`.

 To create a `SettingsViewController` instance, simply call the factory method on the `DependencyContainer`:
 */

let dependencyContainer = DependencyContainer()
let settingsViewController = dependencyContainer.makeSettingsViewController()

/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
