//
//  NetworkMonitor.swift
//  kulu
//
//  Created by Deepak Goyal on 09/06/26.
//

import Network

final class NetworkMonitor {

    static let shared = NetworkMonitor()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")

    private(set) var isConnected = false

    func startMonitoring(){
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
    }
}
