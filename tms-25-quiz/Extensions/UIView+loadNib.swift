//
//  UIView+loadNib.swift
//  tms-25-zeroview-xib
//
//  Created by Vadym Potapov on 18.11.2022.
//

import UIKit

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

extension UIView {
    
    static func loadFromNib() -> Self {
        
        let selfClass: AnyClass = self as AnyClass
        var className = NSStringFromClass(selfClass)
        let bundle = Bundle(for: selfClass)
        
        if bundle.path(forResource: className, ofType: "nib") == nil {
            className = (className as NSString).pathExtension
            if bundle.path(forResource: className, ofType: "nib") == nil {
                fatalError("No xib file for view \(type(of: self))")
            }
        }
        
        return view(bundle, className: className)
    }
    
    private static func view<T: UIView>(_ bundle: Bundle, className: String) -> T {
        guard let nibContents = bundle.loadNibNamed(className, owner: nil, options: nil)
            else { fatalError("No xib file for view \(className)") }

        guard let view = nibContents.first(where: { ($0 as AnyObject).isKind(of: self) }) as? T
            else { fatalError("Xib doesn't have a view of such class \(self)") }
        return view
    }
}
