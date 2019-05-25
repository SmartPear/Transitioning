//
//  ViewController.swift
//  SwiftTest
//
//  Created by 王欣 on 2019/5/15.
//  Copyright © 2019 王欣. All rights reserved.
//

import UIKit
import SnapKit
import Transitioning

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var tempView:UIView?
    var templab :UITextView?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.red]
        self.navigationItem.title = "追也"
        self.tintColor = UIColor.red
        self.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
     
    }

    
    lazy var tableView: UITableView = {
        let tab = UITableView.init()
        tab.delegate = self
        tab.dataSource = self
        tab.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tab
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = "\(indexPath.row)"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let second = SecondViewController()
        navigationController?.pushViewController(second, animated:  true)
        
        
    }
}

