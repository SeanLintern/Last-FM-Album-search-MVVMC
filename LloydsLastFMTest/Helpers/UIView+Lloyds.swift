import UIKit

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

extension UICollectionView {
    func registerNibs(nibs: [UICollectionViewCell.Type]) {
        for nib in nibs {
            self.register(UINib(nibName: String(describing: nib), bundle: nil), forCellWithReuseIdentifier: String(describing: nib))
        }
    }
    
    func dequeueCell<T>(atIndexPath indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as! T
    }
    
    func registerClasses(classes: [UICollectionViewCell.Type]) {
        for aClass in classes {
            self.register(aClass, forCellWithReuseIdentifier: String(describing: aClass.self))
        }
    }
}

extension UITableView {
    func registerNibs(nibs: [UITableViewCell.Type]) {
        for nib in nibs {
            self.register(UINib(nibName: String(describing: nib), bundle: nil), forCellReuseIdentifier: String(describing: nib))
        }
    }
    
    func dequeueCell<T>(atIndexPath indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
    }
    
    func registerClasses(classes: [UITableViewCell.Type]) {
        for aClass in classes {
            self.register(aClass, forCellReuseIdentifier: String(describing: aClass.self))
        }
    }
}
