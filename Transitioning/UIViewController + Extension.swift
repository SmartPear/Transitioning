//
//  UIViewController + Extension.swift
//  SwiftTest
//
//  Created by 王欣 on 2019/5/25.
//  Copyright © 2019 王欣. All rights reserved.
//

import Foundation
import UIKit
private var barColorKey = "barColor"
private var titleTextAttributesKey = "titleTextAttributesKey"
private var tintColorKey = "tintColor"

@objc extension UIViewController{
    
    @objc public  var barTintColor:UIColor{
        
        get {
            if let color =  objc_getAssociatedObject(self, &barColorKey) as? UIColor{
                return color
            }
            let color = UIColor.white
            self.barTintColor = color
            return color
        }
        set{
            let color = newValue
            objc_setAssociatedObject(
                self,
                &barColorKey,
                color,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
            if let navi = self.navigationController?.navigationBar{
                navi.barView?.backgroundColor = color
            }
        }
    }
    
    @objc public var titleTextAttributes:[NSAttributedString.Key:Any]{
        
        get {
            if let value =  objc_getAssociatedObject(self, &titleTextAttributesKey) as? [NSAttributedString.Key:Any]{
                return value
            }
            let attribute = [NSAttributedString.Key.foregroundColor:UIColor.black,NSAttributedString.Key.font:UIFont.systemFont(ofSize: 18)]
            self.titleTextAttributes = attribute
            return attribute
        }
        set{
            
            objc_setAssociatedObject(
                self,
                &titleTextAttributesKey,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
            if let navi = self.navigationController?.navigationBar{
                navi.titleTextAttributes = newValue
            }
        }
    }
    
    @objc public var tintColor:UIColor{
        get {
            if let value =  objc_getAssociatedObject(self, &tintColorKey) as? UIColor{
                return value
            }
            let color = UIColor.black
            return color
        }
        set{
            objc_setAssociatedObject(
                self,
                &tintColorKey,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
            if let navi = self.navigationController?.navigationBar{
                navi.tintColor = newValue
            }
        }
    }
    
}
