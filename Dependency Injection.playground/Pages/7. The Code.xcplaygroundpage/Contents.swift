/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # The Code
 */

import Foundation
import UIKit

protocol SettingsViewControllerFactory {
    func makeSettingsViewController() -> UIViewController
}

protocol DependencyProvider: SettingsViewControllerFactory {
    
    var dataRepository: DataRepository { get }
    
    func makeHomeViewController() -> UIViewController
    func makeHomePresenter() -> HomePresenter
    
    func makeSettingsViewController() -> UIViewController
    func makeSettingsPresenter() -> SettingsPresenter
}

class DependencyContainer: DependencyProvider {
    
    let dataRepository: DataRepository = DataRepository()
    
    func makeHomeViewController() -> UIViewController {
        return HomeViewController(presenter: makeHomePresenter(),
                                  settingsViewControllerFactory: self)
    }
    
    func makeHomePresenter() -> HomePresenter {
        return HomePresenter(dataRepository: dataRepository)
    }
    
    func makeSettingsViewController() -> UIViewController {
        return SettingsViewController(presenter: makeSettingsPresenter())
    }
    
    func makeSettingsPresenter() -> SettingsPresenter {
        return SettingsPresenter()
    }
}

class HomePresenter {
    
    weak var view: View?
    
    let dataRepository: DataRepository
    
    init(dataRepository: DataRepository) {
        self.dataRepository = dataRepository
    }
}

class HomeViewController: ViewController, View {
    
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

class SettingsPresenter {
    weak var view: View?
}

class SettingsViewController: ViewController, View {
    
    let presenter: SettingsPresenter
    
    init(presenter: SettingsPresenter) {
        self.presenter = presenter
        super.init()
    }
}

/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
