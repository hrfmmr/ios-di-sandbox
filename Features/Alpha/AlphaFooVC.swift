import UIKit
import Core

public final class AlphaFooVC: UIViewController {
    public struct Dependency {
        let repository: FooRepository
    }
    
    private let dependency: Dependency
    
    public init(dependency: Dependency) {
        self.dependency = dependency
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = String(describing: type(of: self))
    }
}
