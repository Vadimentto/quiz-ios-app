import UIKit

extension UIView{
    func pinEdgesToSuperView(_ distance: CGFloat = 0){
        guard let superview = superview else {return}
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: distance),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: distance),
            self.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: distance),
            self.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: distance)
        ])
        
    }
    
    func pinEdgesToSuperView(top: CGFloat = 0, bottom: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0) {
        guard let superView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superView.topAnchor, constant: top),
            self.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: left),
            self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -bottom),
            self.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -right)
        ])
    }
}

