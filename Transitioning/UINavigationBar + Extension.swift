//
//  UINavigationBar + Extension.swift
//  SwiftTest
//
//  Created by 王欣 on 2019/5/25.
//  Copyright © 2019 王欣. All rights reserved.
//

import Foundation
import UIKit

private var barViewKey = "barView"

extension UINavigationBar{
    
    @objc var barView:UIView?{
        
        get {
            if let view =  objc_getAssociatedObject(self, &barViewKey) as? UIView{
                return view
            }
            if let view = setupBarView(){
                self.barView = view
                return view
            }
            return nil
        }
        set{
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &barViewKey,
                    newValue as UIView?,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }
    
    @objc private func setupBarView() -> UIView?{
        let view = UIView.init()
        view.backgroundColor = UIColor.white
        let subs = self.subviews
        if let firstView = subs.first{
            for v in firstView.subviews{
                v.isHidden = true
            }
            firstView.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            let top = NSLayoutConstraint.init(item: view, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: firstView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
            let bottom =  NSLayoutConstraint.init(item: view, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: firstView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
            let right = NSLayoutConstraint.init(item: view, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: firstView, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: 0)
            let left =  NSLayoutConstraint.init(item: view, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: firstView, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 0)
            firstView.addConstraints([top,right,left,bottom])
            firstView.layoutIfNeeded()
            return view
        }
        return nil
    }
}


