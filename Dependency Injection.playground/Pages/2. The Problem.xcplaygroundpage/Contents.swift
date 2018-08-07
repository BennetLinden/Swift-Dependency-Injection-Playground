/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # The Problem

 A common problem in many software architectures is that they don't specify where all the different parts and components are created.
 
 To demonstrate this, let's take a look at a simple View and Presenter example:
 */

import Foundation
import UIKit

// The View is a protocol to abstract the ViewController
protocol View: AnyObject { }

// The Presenter holds a weak reference to the view to prevent retain cycles
class SettingsPresenter {
    weak var view: View?
}

// The ViewController is the View, and has a dependency on the Presenter with a strong reference
class SettingsViewController: ViewController, View {
    
    let presenter: SettingsPresenter
    
    init(presenter: SettingsPresenter) {
        self.presenter = presenter
        super.init()
    }
}

/*:
 ## Initializing
 Now that we've defined our View and Presenter classes, let's initialize them:
 */

// Initialize the Presenter
let presenter = SettingsPresenter()

// Initialize the ViewController with the Presenter
let viewController = SettingsViewController(presenter: presenter)

// Assign the ViewController to the Presenter's view property
presenter.view = viewController

/*:
 Initializing the View and the Presenter is pretty straightforward. But where is this supposed to happen?
 
 Imagine a HomeViewController that can navigate to the SettingsViewController. We could do something like this:
 */

class HomeViewController: ViewController {
    
    func openSettings() {
        let presenter = SettingsPresenter()
        let viewController = SettingsViewController(presenter: presenter)
        presenter.view = viewController
        present(viewController, animated: true)
    }
}

/*:
 In this case, the HomeViewController is responsible for creating the SettingsViewController, the SettingsPresenter, and connecting the two. But what happens when either the SettingsPresenter or the SettingsViewController has more dependencies? The HomeViewController should not be responsible for managing all their dependencies.
 */

/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
