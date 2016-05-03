/* RCCircularImageView.swift
 * A simple library for creating
 * circular images for avatars
 *
 *
 */

import UIKit
@IBDesignable


class RCCircularImageView: UIView {
    
    var backgroundLayer: CAShapeLayer!
    var imageLayer: CALayer!
    
    @IBInspectable var image: UIImage?
    
    @IBInspectable var backgroundLayerColor: UIColor = UIColor.whiteColor()
    @IBInspectable var lineWidth: CGFloat = 1.0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setBackgroundLayer()
        setBackgroundImageLayer()
        setImage()
    }
    
    // Set background layer, providing a border
    private func setBackgroundLayer() {
        if backgroundLayer == nil {
            backgroundLayer = CAShapeLayer()
            layer.addSublayer(backgroundLayer)
            let rect = CGRectInset(bounds, lineWidth / 2.0, lineWidth / 2.0)
            let path = UIBezierPath(ovalInRect: rect)
            backgroundLayer.path = path.CGPath
            backgroundLayer.lineWidth = lineWidth
            backgroundLayer.fillColor = backgroundLayerColor.CGColor
        }
        backgroundLayer.frame = layer.bounds
    }
    
    // Set / create the background image layer
    private func setBackgroundImageLayer() {
        if imageLayer == nil {
            let mask = CAShapeLayer()
            let dx = lineWidth + 3.0
            let path = UIBezierPath(ovalInRect: CGRectInset(self.bounds, dx, dx))
            mask.fillColor = UIColor.blackColor().CGColor
            mask.path = path.CGPath
            mask.frame = self.bounds
            layer.addSublayer(mask)
            imageLayer = CAShapeLayer()
            imageLayer.frame = self.bounds
            imageLayer.mask = mask
            imageLayer.contentsGravity = kCAGravityResizeAspectFill
            layer.addSublayer(imageLayer)
        }
        
    }
    
    // Set the image for the image view when created
    private func setImage() {
        if imageLayer != nil {
            if let anImage = image {
                imageLayer.contents = anImage.CGImage
            }
        }
    }
}
