//
//  BaseNavController.swift
//  SwiftTest
//
//  Created by 王欣 on 2019/5/22.
//  Copyright © 2019 王欣. All rights reserved.
//

import UIKit
import Transitioning

class BaseNavController: UINavigationController {
    let pushAnimation = PushAnimation();
    override func viewDidLoad() {
        super.viewDidLoad()
        pushAnimation.bindView(navigation: self)
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
