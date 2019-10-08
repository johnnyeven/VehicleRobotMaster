//
//  RootController.swift
//  VehicleRobotMaster
//
//  Created by 李翌文 on 2019/9/17.
//  Copyright © 2019 Johnnyeven. All rights reserved.
//

import UIKit
import Socket
import CocoaAsyncSocket

@available(iOS 13.0, *)
class RootController: UIViewController, GCDAsyncUdpSocketDelegate {
    
    @IBOutlet weak var progressConnection: UIProgressView!
    @IBOutlet weak var labelConnection: UILabel!
    
    var udpSocket: GCDAsyncUdpSocket!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelConnection.text = "查找局域网内的终端..."
        progressConnection.setProgress(0, animated: true)
        udpSocket = GCDAsyncUdpSocket(delegate: self, delegateQueue: DispatchQueue.main)
        do {
            try udpSocket.bind(toPort: 9091)
            try udpSocket.beginReceiving()
        } catch {
            print("bind error")
        }
    }
    
    func udpSocket(_ sock: GCDAsyncUdpSocket, didReceive data: Data, fromAddress address: Data, withFilterContext fileterContext: Any?) {
        var hostname = [CChar].init(repeating: 0, count: Int(NI_MAXHOST))
        do{
            try address.withUnsafeBytes({ (pointer:UnsafePointer<sockaddr>) -> Void in
                guard getnameinfo(pointer, socklen_t(data.count), &hostname, socklen_t(hostname.count), nil, 0, NI_NUMERICHOST) == 0 else{
                    throw NSError(domain: "domain", code: 0, userInfo: ["error":"unable to get ip address"])
                }
            })
        }catch(let error){
            print(error.localizedDescription)
        }
        
        var newAddress = String.init(cString: hostname)
        let addArry = newAddress.components(separatedBy: ":")
        if addArry.count > 1 {
            newAddress = addArry[addArry.count-1]
        }
        print("IP:\(newAddress):9091")
        
        TeleportClient.ip = newAddress
        udpSocket.close()
        
        labelConnection.text = "等待授权..."
        progressConnection.setProgress(0.5, animated: true)
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
            progressConnection.setProgress(0.7, animated: true)
        }
    }

}
