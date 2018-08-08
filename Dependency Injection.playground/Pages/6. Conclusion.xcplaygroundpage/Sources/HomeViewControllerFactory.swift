import Foundation
import UIKit

public protocol HomeViewControllerFactory {
    func makeHomeViewController() -> UIViewController
}
