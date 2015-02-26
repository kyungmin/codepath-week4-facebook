//
//  DetailImageViewController.swift
//  Facebook
//
//  Created by Kyungmin Kim on 2/26/15.
//  Copyright (c) 2015 Kyungmin Kim. All rights reserved.
//

import UIKit

class DetailImageViewController: UIViewController {

    @IBOutlet weak var detailImageView: UIImageView!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        detailImageView.image = image
    }

    @IBAction func didPressDoneButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
