//
//  NewRoomViewController.swift
//  0214Practice_Compile
//
//  Created by CAUADC on 2017. 2. 14..
//  Copyright © 2017년 CAUADC. All rights reserved.
//

import UIKit

let DidUserDoneInput = Notification.Name(rawValue: "DidInput")

class insertRoomSize: UIViewController {
    
    @IBOutlet weak var roomWidth: UITextField!
    @IBOutlet weak var roomHeight: UITextField!
    @IBAction func roomSizeConfirmed(_ sender: UIButton) {
        NotificationCenter.default.post(name: DidUserDoneInput, object: nil, userInfo: ["widthR":CGFloat(Float(self.roomWidth.text!)!),"heightR":CGFloat(Float(self.roomHeight.text!)!)])
    }
    
    
    

    
}


class NewRoomViewController: UIViewController {
    
    @IBOutlet var base: UIView!
    
    //---------------------------- Room ------------------------------//
    
    func didReceiveUserRoomInputNotification(noti: Notification) {
        if let info = noti.userInfo, let widthR = info["widthR"] as? CGFloat, let heightR = info["heightR"] as? CGFloat {
            self.addNewRoom(width: widthR, height: heightR)
        }
    }

    
    func addNewRoom(width: CGFloat, height: CGFloat) {
        let widthR: CGFloat = width
        let heightR: CGFloat = height
        let roomAdded: UIView = UIView(frame: CGRect(x: self.base.center.x - (width / 2.0), y: self.base.center.y - (height / 2.0), width: widthR, height: heightR))
        roomAdded.backgroundColor = UIColor.white
        roomAdded.layer.borderWidth = 5.5
        roomAdded.layer.borderColor = UIColor.darkGray.cgColor
        view.addSubview(roomAdded)
    }
    
    
    //---------------------------- Furniture ------------------------------//
    
    var lastFrame: CGRect!
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    func viewShouldMove(subview: UIView, movingTo location: CGPoint) -> Bool {
        
        let currentFrame = subview.frame
        
        if location.x - (subview.frame.size.width) / 2.0 <= 0 ||
            location.x + (subview.frame.size.width) / 2.0 >= base.frame.size.width {
            subview.frame = currentFrame
            return false
        }
        
        if location.y - (subview.frame.size.height) / 2.0 <= 0 ||
            location.y + (subview.frame.size.height) / 2.0 >= base.frame.size.height {
            subview.frame = currentFrame
            return false
        }
        
        let halfWidth = currentFrame.size.width / 2.0
        let halfHeight = currentFrame.size.height / 2.0
        
        let nextFrame = CGRect(origin: CGPoint(x: location.x - halfWidth, y: location.y - halfHeight), size: subview.frame.size)
        
        for subviewInBase in self.base.subviews {
            if subview == subviewInBase {
                continue
            }
            if subviewInBase.frame.intersects(nextFrame) == true {
                return false
            }
        }
        return true
    }
    
    func didReceiveUserFurnitureInputNotification(noti: Notification) {
        if let info = noti.userInfo, let widthF = info["widthF"] as? CGFloat, let depthF = info["depthF"] as? CGFloat {
            self.addNewFurniture(width: widthF, height: depthF)
        }
    }
    
    func addNewFurniture(width: CGFloat, height: CGFloat) {
        let widthF: CGFloat = width
        let depthF: CGFloat = height
        let furnitureAdded: UIView = UIView(frame: CGRect(x: self.base.center.x - (width / 2.0), y: self.base.center.y - (height / 2.0), width: widthF
            , height: depthF))
        furnitureAdded.backgroundColor = UIColor.brown
        self.base.bringSubview(toFront: furnitureAdded)
        view.addSubview(furnitureAdded)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
         NotificationCenter.default.addObserver(self, selector: #selector(didReceiveUserRoomInputNotification(noti:)), name: DidUserDoneInput, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveUserFurnitureInputNotification(noti:)), name: DidUserDoneInput, object: nil)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first?.location(in: self.base) else {
            print("터치 인식 불가")
            return
        }
        
        for subview in self.base.subviews {
            if subview.frame.contains(touch) == true {
//                self.base.bringSubview(toFront: UIView)
                break
            }
        }
        
//        if touch == nil {
//            return
//        }
        
//        let location = touches.first?.location(in: self.base)
//        if let position = location, let currentMoving = touch {
//            if viewShouldMove(subview: currentMoving, movingTo: position) {
//                self.t
//            }
//        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let location = touches.first?.location(in: self.base)
        
//        if let position = location, let putHere = self.
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

    @IBAction func saveRoom(_ sender: Any) {
        self.dismiss(animated: true) {
        }
    }
    
}

class NewFurniture: UIViewController {
    
    @IBOutlet weak var furnitureName: UITextField!
    @IBOutlet weak var furnitureWidth: UITextField!
    @IBOutlet weak var furnitureDepth: UITextField!
    @IBOutlet weak var furnitureHeight: UITextField!
    @IBOutlet weak var furnitureColor: UITextField!
    @IBOutlet weak var furnitureLevel: UILabel!
    
    @IBAction func decreaseLevel(_ sender: UIButton) {
        
    }
    @IBAction func increaseLevel(_ sender: UIButton) {
        
    }
    @IBAction func addFurnitureToTheRoom(_ sender: UIButton) {
        NotificationCenter.default.post(name: DidUserDoneInput, object: nil, userInfo: ["widthF":CGFloat(Float(self.furnitureWidth.text!)!),"depthF":CGFloat(Float(self.furnitureDepth.text!)!)])
        self.dismiss(animated: true) {
        }
    }
    
}


















