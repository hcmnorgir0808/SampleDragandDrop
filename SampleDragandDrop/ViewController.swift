//
//  ViewController.swift
//  SampleDragandDrop
//
//  Created by 岩本康孝 on 2021/07/06.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var blueView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(drag(gesture:)))
        blueView.addGestureRecognizer(panGesture)
    }
    
    @objc func drag(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .ended:
            let point: CGPoint
            
            if blueView.center.x <= self.view.center.x {
                let blueViewCenterX = blueView.bounds.width / 2
                point = CGPoint(x: blueViewCenterX, y: blueView.center.y)
            } else {
                let blueViewCenterX = self.view.frame.maxX - blueView.bounds.width / 2
                point = CGPoint(x: blueViewCenterX, y: blueView.center.y)
            }
            UIView.animate(withDuration: 0.2) {
                self.blueView.center = point
            }
            
        case .changed:
            // 移動量を取得
            let point = gesture.translation(in: blueView)
            
            // 今のx, y座標のcenterに移動量のx, yを加算 or 減算
            let pointMinX = max(self.view.frame.minX, blueView.frame.minX + point.x)
            let pointMaxX = min(self.view.frame.maxX, blueView.frame.maxX + point.x)
            
            let pointX = (pointMinX + pointMaxX) / 2
            
            let pointMinY = max(self.view.frame.minY, blueView.frame.minY + point.y)
            let pointMaxY = min(self.view.frame.maxY, blueView.frame.maxY + point.y)
            
            let pointY = (pointMinY + pointMaxY) / 2
            let movedPoint = CGPoint(x: pointX, y: pointY)
            
            blueView.center = movedPoint
            
            gesture.setTranslation(.zero, in: blueView)
        default: break
        }
    }
}

