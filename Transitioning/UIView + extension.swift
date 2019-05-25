//
//  UIView + extension.swift
//  SwiftTest
//
//  Created by 王欣 on 2019/5/22.
//  Copyright © 2019 王欣. All rights reserved.
//

import Foundation
import UIKit
import ObjectiveC.runtime


extension UIView{
    
   
    func originX(_ value:CGFloat){
        //        let frame = self.frame
        self.frame = CGRect.init(x: value, y: frame.origin.y, width: frame.size.width, height: frame.size.height)
    }
    
}
