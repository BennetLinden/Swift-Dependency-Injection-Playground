

import UIKit

public class HomeViewController: UIViewController {
    
    let presenter: HomePresenter
    let settingsViewControllerFactory: SettingsViewControllerFactory

    public init(presenter: HomePresenter,
                settingsViewControllerFactory: SettingsViewControllerFactory) {
        self.presenter = presenter
        self.settingsViewControllerFactory = settingsViewControllerFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
