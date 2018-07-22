//
//  ContentView.swift
//  PageViewTest
//
//  Created by Pranavan on 7/21/18.
//  Copyright © 2018 Pranavan. All rights reserved.
//

import UIKit

class ContentView: UIViewController {

    @IBOutlet weak var imageName: UIImageView!
    var imageString = String()
    var itemIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageName.image = UIImage(named: "\(imageString)")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
