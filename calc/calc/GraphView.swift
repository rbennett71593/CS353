//
//  GraphView.swift
//  calc
//
//  Created by Ryan Bennett on 3/12/16.
//  Copyright © 2016 bennry01. All rights reserved.
//

import UIKit

protocol GraphViewDataSource: class {
    func getPoints(sender: GraphView) -> [CGPoint]
}

@IBDesignable
class GraphView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var lineWidth: CGFloat = 3 { didSet { setNeedsDisplay() } }
    
    var color: UIColor = UIColor.blackColor() { didSet { setNeedsDisplay() } }
    
    
    
    @IBInspectable var scale: CGFloat = 50.0{
        didSet {
            updateScale()
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var centerOfView: CGPoint {
        return convertPoint(center, fromView: superview)
    }
    
    var origin: CGPoint = CGPoint(x: 0, y: 0) {
        didSet {
            updateScale()
            setNeedsDisplay()
        }
    }
    
    //range on x axis for which to request data points
    var range_min_x: CGFloat = -100.0
    var range_max_x:  CGFloat = 100.0
    //increment value for x points on axis
    var increment: CGFloat = 1.0
    
    func updateScale(){
        range_min_x = -origin.x / scale
        range_max_x =  range_min_x + (bounds.size.width / scale)
        increment = (1.0/scale)
        
    }
    
    // viewBounds passed to AxesDrawer
    private var viewBounds: CGRect {
        return CGRect(
            origin: CGPoint(x: 0, y: 0),
            size: bounds.size
        )
    }
    
    weak var dataSource: GraphViewDataSource?
    
    override func drawRect(rect: CGRect) {
        let axesDrawer = AxesDrawer(color: color, contentScaleFactor: contentScaleFactor)
        
        axesDrawer.drawAxesInRect(
            viewBounds,
            origin: origin,
            pointsPerUnit: scale
        )
        
        let path = UIBezierPath()
        
        path.lineWidth = lineWidth
        color.set()
        if var pointsToGraph = dataSource?.getPoints(self) {
            if(pointsToGraph.count > 1){
                // set up pen at first point
                let startingPoint = pointsToGraph.removeAtIndex(0);
                path.moveToPoint(startingPoint)
                
                for nextPoint in pointsToGraph {
                    // draw from current point to next point
                    path.addLineToPoint(nextPoint)
                    //print("point")
                }
                print("Draw")
                
            }
        }
        path.stroke()
        
        
    }
    
    func gesture_Zoom(gesture: UIPinchGestureRecognizer) {

        switch gesture.state {
            case .Ended: fallthrough
            case .Changed:
                scale *= gesture.scale
                gesture.scale = 1
            default: break
        }
    }
    
    func gesture_Move(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
            case .Ended: fallthrough
            case .Changed:
                let distance = gesture.translationInView(self)
                origin.x += distance.x
                origin.y += distance.y
                gesture.setTranslation(CGPointZero, inView: self)
            default: break
        }
        
    }
    
    func gesture_DoubleTap(gesture: UITapGestureRecognizer){
        switch gesture.state {
            case .Ended:
                origin = gesture.locationInView(self)
            default: break
        }
    }

}
