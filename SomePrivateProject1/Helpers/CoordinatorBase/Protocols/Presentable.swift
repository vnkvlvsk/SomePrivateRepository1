import Foundation
import UIKit

protocol Presentable: AnyObject {
    func toPresent() -> UIViewController?
}
