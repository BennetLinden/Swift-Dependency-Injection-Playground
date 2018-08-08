/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # View Controller Factory
 
 Now that we have a **DependencyContainer** to manage dependencies, we can use it to create a SettingsViewController. But as the **DependencyContainer** gets bigger, it can do a lot more than just creating a **SettingsViewController**. Exposing all of its factory methods and dependencies is not preferred, so it's a good idea to mask them.
 
 We can do this by using a **SettingsViewControllerFactory** protocol with a single factory method for creating the **SettingsViewController**:
 */
import Foundation
import UIKit

protocol SettingsViewControllerFactory {
    func makeSettingsViewController() -> UIViewController
}
/*:
 ## View Controller Factory Dependency
 By adding the **SettingsViewControllerFactory** as a dependency to the **HomeViewController**, we can let it create a **SettingsViewController** without any knowledge about its dependencies:
 */
class HomeViewController: ViewController {
    
    let presenter: HomePresenter
    let settingsViewControllerFactory: SettingsViewControllerFactory
    
    init(presenter: HomePresenter,
         settingsViewControllerFactory: SettingsViewControllerFactory) {
        self.presenter = presenter
        self.settingsViewControllerFactory = settingsViewControllerFactory
        super.init()
    }
    
    func openSettings() {
        let settingsViewController = settingsViewControllerFactory.makeSettingsViewController()
        present(settingsViewController, animated: true)
    }
}
/*:
 ## Dependency Provider as View Controller Factory
 Now that we've added a dependency to the **HomeViewController**, let's update our **DependencyProvider** with factory methods for both the **HomeViewController** and the **SettingsViewController**.
 
 We're also letting the **DependencyProvider** adopt the **SettingsViewControllerFactory** protocol:
 */
protocol DependencyProvider: SettingsViewControllerFactory {
    
    func makeHomeViewController() -> UIViewController
    func makeHomePresenter() -> HomePresenter
    
    func makeSettingsViewController() -> UIViewController
    func makeSettingsPresenter() -> SettingsPresenter
}
/*:
 And add an implemention for the factory methods in the **DependencyContainer**:
 */
class DependencyContainer: DependencyProvider {
    
    func makeHomeViewController() -> UIViewController {
        return HomeViewController(presenter: makeHomePresenter(),
                                  settingsViewControllerFactory: self)
    }
    
    func makeHomePresenter() -> HomePresenter {
        return HomePresenter()
    }
    
    func makeSettingsViewController() -> UIViewController {
        return SettingsViewController(presenter: makeSettingsPresenter())
    }
    
    func makeSettingsPresenter() -> SettingsPresenter {
        return SettingsPresenter()
    }
}
/*:
 The **DependencyContainer**, through the **DependencyProvider** protocol, also adopts to the **SettingsViewControllerFactory** protocol. Because of this, it can pass **self** as a **SettingsViewControllerFactory** when initializing the **HomeViewController**, and not expose its other methods.
 */

/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
