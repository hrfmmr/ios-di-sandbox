import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("debug:\(String(describing: type(of: self)))::\(#function)")
    }
}
