//
//  GraphViewController.swift
//  calc
//
//  Created by Ryan Bennett on 3/12/16.
//  Copyright © 2016 bennry01. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController, GraphViewDataSource {

    private var brain = CalculatorBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        graphView.origin = graphView.centerOfView
        
        super.viewDidAppear(animated)
    }
    
    func getPoints(sender: GraphView) -> [CGPoint] {
        var points = [CGPoint]()
        var min_x = graphView.range_min_x
        while min_x <= graphView.range_max_x {
            if let y = brain.y(Double(min_x)) {
                let xValue = (min_x * graphView.scale) + graphView.origin.x
                let yValue = graphView.origin.y - (CGFloat(y) * graphView.scale)
                points.append(CGPoint(x: xValue, y: yValue))
            }
            min_x += graphView.increment
        }
        //print("++Calculated Points")
        return points
    }
    
    @IBOutlet weak var graphView: GraphView! {
        didSet {
            // Set up source
            
            graphView.dataSource = self
            
            // Set up gestures
            
            graphView.addGestureRecognizer(UIPinchGestureRecognizer(target: graphView, action: "gesture_Zoom:"))
            
            graphView.addGestureRecognizer(UIPanGestureRecognizer(target: graphView, action: "gesture_Move:"))
            
            //graphView.addGestureRecognizer(UITapGestureRecognizer(target: graphView, action: "gesture_DoubleTap:"))
            
            let doubleTap = UITapGestureRecognizer(target: graphView, action: "gesture_DoubleTap:")
            doubleTap.numberOfTapsRequired = 2
            graphView.addGestureRecognizer(doubleTap)
            
            // Set eqation label
            equationLabelValue = brain.description
            
        }
    
    }
    @IBOutlet weak var activeEquationDisplay: UILabel!
    
    var equationLabelValue: String {
        get {
            return activeEquationDisplay.text!
        }
        set {
            activeEquationDisplay.text = "f(x) = \(newValue) "
        }
    }
    
    
    var program: AnyObject {
        get {
            return brain.program
        }
        set {
            brain.program = newValue
        }
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
