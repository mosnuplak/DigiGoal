//
//  SocketIOManager.swift
//  digigoal
//
//  Created by nattachai.nuplak on 19/1/2567 BE.
//

import Foundation
import SocketIO
import Combine

public class SocketIOManager {
    enum Event: String {
        case newNotification = "new-notification"
    }
    
    static let shared = SocketIOManager()
    @Published var newNotification: Int = 0
    
    private var manager: SocketManager?
    private let defaultConfiguration: SocketIOClientConfiguration = [
        .log(true),
        .compress
    ]
    
    private func prepare() {
        manager?.disconnect()
        manager = nil
    }
    
    private func observeClientEvents() {
        observe(
            clientEvent: .connect,
            callback: { data, ack in
                guard let nsp = data[0] as? String else { return }
                // Some logic using the nsp
                print(nsp)
            })
        
        observe(
            clientEvent: .disconnect,
            callback: { data, ack in
                // Some cleanup logic
            })
        
        observe(
            clientEvent: .error,
            callback: { data, ack in
                // Some logging
            })
        
        observe(
            clientEvent: .ping,
            callback: { data, ack in
                // Maybe keep track of latency?
            })
        
        observe(
            clientEvent: .pong,
            callback: { data, ack in
                // Maybe keep track of latency?
            })
        
        observe(
            clientEvent: .reconnect,
            callback: { data, ack in
                // Some reconnect event logic
            })
        
        observe(
            clientEvent: .reconnectAttempt,
            callback: { data, ack in
                // Some reconnect attempt logging
            })
        
        observe(
            clientEvent: .statusChange,
            callback: { data, ack in
                // Some status changing logging
            })
        
        observe(
            clientEvent: .websocketUpgrade,
            callback: { data, ack in
                let headers = (data as [Any])[0]
                // Some header logic
                print(headers)
            })
    }
    
    private func observeEvents() {
        observe(
            event: .newNotification,
            callback: { [weak self] data, ack in
                guard let status = data[0] as? Bool else { return }
                self?.newNotification += 1
                print(status)
            })
    }
    
    func connect(
        url: String,
        configuration: SocketIOClientConfiguration? = nil
    ) {
        prepare()
        guard let url = URL(string: url) else { return }
        manager = .init(
            socketURL: url,
            config: configuration ?? defaultConfiguration)
        observeClientEvents()
        observeEvents()
        manager?.defaultSocket.connect()
    }
    
    // MARK: - Helper
    @discardableResult
    private func observe(
        clientEvent event: SocketClientEvent,
        callback: @escaping NormalCallback
    ) -> UUID? {
        manager?.defaultSocket.on(
            clientEvent: event,
            callback: { data, ack in
                print("[HERE]: \(event.rawValue)")
                callback(data, ack)
            })
    }
    
    @discardableResult
    private func observe(
        event: Event,
        callback: @escaping NormalCallback
    ) -> UUID? {
        manager?.defaultSocket.on(
            event.rawValue,
            callback: { data, ack in
                print("[HERE]: \(event.rawValue)")
                callback(data, ack)
                ack.with("Received \(event.rawValue)")
            })
    }
}
