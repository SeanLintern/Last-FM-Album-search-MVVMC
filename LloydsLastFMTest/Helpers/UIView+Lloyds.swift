import UIKit

extension UITableView {
    func dequeueCell<T>(atIndexPath indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
    }
    
    func registerClasses(classes: [UITableViewCell.Type]) {
        for aClass in classes {
            self.register(aClass, forCellReuseIdentifier: String(describing: aClass.self))
        }
    }
}
