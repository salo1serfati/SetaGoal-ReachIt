//
//  TableViewController.swift
//  Set a Goal - Reach It
//
//  Created by Salomon serfati on 6/20/16.
//  Copyright © 2016 Salomon Serfati. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func newGoalButtonTapped(sender: UIButton) {
        let nGvc = NewGoalViewController(nibName: "NewGoalViewController", bundle: nil)
        self.navigationController?.pushViewController(nGvc, animated: true)
    }
    

}
