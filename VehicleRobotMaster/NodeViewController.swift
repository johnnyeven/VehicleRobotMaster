//
//  NodeViewController.swift
//  VehicleRobotMaster
//
//  Created by 李翌文 on 2019/9/20.
//  Copyright © 2019 Johnnyeven. All rights reserved.
//

import UIKit
import QuickTableViewController

@available(iOS 13.0, *)
class NodeViewController: QuickTableViewController {

    @IBOutlet weak var tableNodes: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let getNodesReq = GetNodesRequest(token: token)
        let stat = TeleportClient.getInstance()?.getNodes(req: getNodesReq) { data in
            do {
                let resp = try JSONDecoder().decode(GetNodesResponse.self, from: data)
                var rows = [Row & RowStyle]()
                for item in resp.nodes {
                    rows.append(NavigationRow(text: item.key, detailText: .subtitle(item.nodeType), icon: .named("gear"), action: self.didRobotTouch()))
                }
                self.tableContents = [
                    Section(title: "Robots", rows: rows)
                ]
            } catch _ {

            }
        }
        if stat != nil {
            log.error(stat!.cause)
        }

    }
    
    private func didRobotTouch() -> (Row) -> Void {
        let cameraViewController = (self.storyboard?.instantiateViewController(withIdentifier: "cameraViewController") as! CameraViewController)
        return { row in
            controlTarget = row.text
            switchToViewController(from: self, to: cameraViewController)
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
