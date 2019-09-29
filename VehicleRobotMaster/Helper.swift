//
//  Helper.swift
//  VehicleRobotMaster
//
//  Created by 李翌文 on 2019/9/23.
//  Copyright © 2019 Johnnyeven. All rights reserved.
//

import Foundation
import UIKit

func switchToViewController(from: UIViewController, to: UIViewController?) {
    UIView.beginAnimations("switch_scene", context: nil)
    UIView.setAnimationDuration(0.5)
    UIView.setAnimationCurve(.easeInOut)
    to?.view.frame = from.view.frame
    
    if (to != nil) {
        from.addChild(to!)
        from.view.addSubview((to?.view)!)
        to?.didMove(toParent: from)
    }
    UIView.commitAnimations()
}
