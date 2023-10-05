//
//  Network.swift
//  Seknova-Practice
//
//  Created by imac-3373 on 2023/10/5.
//

import Network

class NetworkMonitor {

    let monitor = NWPathMonitor()

    var isConnectedToInternet: Bool = false // 添加一个属性来表示设备是否连接到互联网

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                // 设备已连接到互联网
                self?.isConnectedToInternet = true
                print("设备已连接到互联网9999")
            } else {
                // 设备未连接到互联网
                self?.isConnectedToInternet = false
                print("设备未连接到互联网")
            }
        }

        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
}


