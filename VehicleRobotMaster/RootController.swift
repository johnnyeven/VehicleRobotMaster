//
//  RootController.swift
//  VehicleRobotMaster
//
//  Created by 李翌文 on 2019/9/17.
//  Copyright © 2019 Johnnyeven. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class RootController: UIViewController {
    
    @IBOutlet weak var progressConnection: UIProgressView!
    @IBOutlet weak var labelConnection: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelConnection.text = "获取授权信息..."
        progressConnection.setProgress(0, animated: true)
        
        let authRequest = AuthorizationRequest(key: "456")
        let stat = TeleportClient.getInstance()?.authorization(req: authRequest, closure: { data -> Void in
            do {
                let resp = try JSONDecoder().decode(AuthorizationResponse.self, from: data)
                
                self.progressConnection.setProgress(1, animated: true)
                self.labelConnection.text = "授权成功"
                token = resp.token
                log.info(resp.token)
                
                let nodeViewController = (self.storyboard?.instantiateViewController(withIdentifier: "nodeViewController") as! NodeViewController)
                switchToViewController(from: self, to: nodeViewController)
            } catch _ {

            }
        })
        if stat != nil {
            log.error(stat!.cause)
        } else {
            progressConnection.setProgress(0.5, animated: true)
        }
    }

}
