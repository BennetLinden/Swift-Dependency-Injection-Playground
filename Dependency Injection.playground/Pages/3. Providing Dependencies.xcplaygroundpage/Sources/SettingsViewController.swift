

import UIKit

public class SettingsViewController: UIViewController {
    
    let presenter: SettingsPresenter
    
    public init(presenter: SettingsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
