/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # The Problem

 A common problem in many software architectures is that they don't specify where all the different parts and components are created.
 
 To demonstrate this, let's take a look at a simple View and Presenter example:
 */

import Foundation
import UIKit

// A View protocol to abstract away the UIViewController
protocol View: AnyObject { }

// A Presenter class with a weak view property
class Presenter {
    weak var view: View?
}


class ViewController: UIViewController, View {
    
    let presenter: Presenter
    
    init(presenter: Presenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
    }
}


/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
