//
//  FeedViewController.swift
//  Facebook
//
//  Created by Kyungmin Kim on 2/26/15.
//  Copyright (c) 2015 Kyungmin Kim. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning, UIGestureRecognizerDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedImageView: UIImageView!
    var selectedImageView: UIImageView!
    var movingImageView: UIImageView!
    var blackView: UIView!
    var duration: NSTimeInterval!
    var isPresenting: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.contentSize = feedImageView.frame.size
        duration = 0.6
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        if (isPresenting) {
            blackView = UIView(frame: fromViewController.view.frame)
            blackView.backgroundColor = UIColor.blackColor()
            blackView.alpha = 0
            
            toViewController.view.alpha = 0
            toViewController.view.transform = CGAffineTransformMakeScale(0, 0)

            movingImageView = UIImageView(frame: selectedImageView.frame)
            movingImageView.image = selectedImageView.image
            
            // adjust moving image height
            movingImageView.center.y += scrollView.frame.origin.y
            // set approprite fill mode based on its ratio
            if (selectedImageView.image?.size.width > selectedImageView.image?.size.height) {
                movingImageView.contentMode = .ScaleAspectFit
            } else {
                movingImageView.contentMode = .ScaleAspectFill
            }

            movingImageView.clipsToBounds = selectedImageView.clipsToBounds
            movingImageView.userInteractionEnabled = true
            
            containerView.addSubview(blackView)
            containerView.addSubview(movingImageView)
            containerView.addSubview(toViewController.view)

            var detailImageViewController = toViewController as DetailImageViewController
            var detailImageView = detailImageViewController.detailImageView

            UIView.animateWithDuration(duration, animations: { () -> Void in
                self.movingImageView.frame = detailImageView.frame
                self.blackView.alpha = 0.9
                toViewController.view.transform = CGAffineTransformMakeScale(1, 1)
                
                }) { (finished: Bool) -> Void in
                    toViewController.view.alpha = 1
                    self.movingImageView.removeFromSuperview()
                    self.blackView.removeFromSuperview()
                    transitionContext.completeTransition(true)
            }
        } else {
            fromViewController.view.alpha = 0
            
            movingImageView.transform = CGAffineTransformMakeScale(0.7, 0.7)
            UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 3, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                
                self.movingImageView.frame = self.selectedImageView.frame
                self.movingImageView.contentMode = .ScaleAspectFill
                self.movingImageView.center.y += self.scrollView.frame.origin.y
                self.blackView.alpha = 0
                
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    fromViewController.view.removeFromSuperview()
            }
        }
    }
    
    @IBAction func didTapImage(sender: AnyObject) {
        selectedImageView = sender.view as UIImageView
        performSegueWithIdentifier("detailSegue", sender: self)
    }
    
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = false
        return self
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        return duration
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var toViewController = segue.destinationViewController as DetailImageViewController
        toViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        toViewController.transitioningDelegate = self
        toViewController.detailImage = self.selectedImageView.image
    }
}
