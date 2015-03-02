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
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    
    var interactiveTransition: UIPercentDrivenInteractiveTransition!
    var detailImage: UIImage!
    var originalDetailImageCenter: CGPoint!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        detailImageView.contentMode = .ScaleAspectFit
        detailImageView.image = detailImage
    }

    @IBAction func didPressDoneButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func didPinchToZoom(sender: UIPinchGestureRecognizer) {
        var scale = sender.scale
        
        if (scale < 1) {
            scale = 1
        }
        
        detailImageView.transform = CGAffineTransformMakeScale(scale, scale)
    }
    
    @IBAction func didPanDetailImage(sender: UIPanGestureRecognizer) {
        var velocity = sender.velocityInView(view)
        var translation = sender.translationInView(view)
        
        if (sender.state == UIGestureRecognizerState.Began) {
            originalDetailImageCenter = detailImageView.center
        } else if (sender.state == UIGestureRecognizerState.Changed) {
            if translation.y >= 0 {
                blackView.alpha = 1 - (translation.y / 568)
                doneButton.alpha = 1 - (translation.y / 568)
            } else {
                blackView.alpha = 1 - (-translation.y / 568)
                doneButton.alpha = 1 - (-translation.y / 568)
            }

            detailImageView.center = CGPoint(x: self.originalDetailImageCenter.x, y: self.originalDetailImageCenter.y + translation.y)
        } else if (sender.state == UIGestureRecognizerState.Ended) {
            dismissViewControllerAnimated(true, completion: nil)
            if velocity.y > 0 && translation.y > 0 {
                detailImageView.center.y += detailImageView.frame.height
            } else if velocity.y < 0 && translation.y < 0 {
                detailImageView.center.y -= detailImageView.frame.height
            }
        }
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
