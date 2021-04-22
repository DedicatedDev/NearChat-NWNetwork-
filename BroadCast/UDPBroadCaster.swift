//
//  UDPBroadCaster.swift
//  BroadCast
//
//  Created by FreeBird on 3/31/21.
//


import Foundation
import Network
//protocol BroadcastResponseHandler {
//  func handleResponse(_ client: UDPBroadcaster, data: Data)
//}
//class DiscoveredLocalDevices: BroadcastResponseHandler {
//  private let internalQueue = DispatchQueue(label: "com.discoveredDevices.queue", qos: .default, attributes: .concurrent)
//  private var _devices = Set<Device>()
//  public var devices: Set<Device> {
//    get {
//      return internalQueue.sync {
//        _devices
//      }
//    }
//    set(newState) {
//      internalQueue.async {
//        self._devices = newState
//      }
//    }
//  }
//  func handleResponse(_ client: UDPBroadcaster, data: Data) {
//    if data.count == 61 {
//      if let device = Device(udpBroadcastResponse: data) {
//        var previousDevices = devices
//        previousDevices.insert(device)
//        devices = previousDevices
//      }
//    }
//  }
//}
//class UDPBroadcaster {
//  private let udpBroadcastPort: NWEndpoint.Port = 65431
//  private let outHost: NWEndpoint.Host = "255.255.255.255"
//  private var outConnection: NWConnection?
//  private var listener: NWListener?
//  var delegate: BroadcastResponseHandler?
//  var connections = [NWConnection]()
//  var backgroundQueueUdpListener = DispatchQueue(label: "udp-lis.bg.queue", attributes: [])
//  var backgroundQueueUdpConnection = DispatchQueue(label: "udp-con.bg.queue", attributes: [])
//  init() {
//    let params = NWParameters.udp
//    params.allowLocalEndpointReuse = true
////    params.allowFastOpen = true
//    outConnection = NWConnection(host: outHost, port: udpBroadcastPort, using: params)
//    listener = try? NWListener(using: params, on: udpBroadcastPort)
//  }
//  //    MARK: - Broadcast
//  func startBroadcast() {
//    outConnection?.stateUpdateHandler = { newState in
//      switch newState {
//        case .ready:
//          print("OutConnectionState: Ready\n")
//          self.sendBroadcastMessage()
//        case .setup:
//          print("OutConnectionState: Setup\n")
//        case .cancelled:
//          print("OutConnectionState: Cancelled\n")
//        case .preparing:
//          print("OutConnectionState: Preparing\n")
//        default:
//          print("ERROR! OutConnectionState not defined!\n")
//      }
//    }
//    outConnection?.start(queue: backgroundQueueUdpConnection)
//  }
//  private func sendBroadcastMessage() {
//    outConnection?.send(content: cbwBroadcastMessage(), completion: NWConnection.SendCompletion.contentProcessed(({ NWError in
//      if NWError == nil {
//        print("Broadcast message was sent\n")
//      } else {
//        print("ERROR! Error when broadcast message (Type: Data) sending. NWError: \n \(NWError!)")
//      }
//    })))
//  }
//  private let cbwBroadcastMessage = { () -> Data in
//    var data = Data(capacity: 13)
//    if let header = "ControlByWeb".data(using: String.Encoding.ascii) {
//      data.append(header)
//      data.append(0)
//    }
//    return data
//  }
//  //    MARK: - Listener
//  func startListener() {
//    listener?.service = NWListener.Service(type: "_cbwMobilePlus._udp")
//    listener?.stateUpdateHandler = { newState in
//      switch newState {
//        case .ready:
//          print("ListenerState: Ready\n")
//          return
//        case .waiting(let error):
//          print(error)
//        case .setup:
//          print("ListenerState: Setup\n")
//        case .cancelled:
//          print("ListenerState: Cancelled\n")
//        case .failed(let error):
//          print(error)
//        default:
//          print("ERROR! ListenerState not defined!\n")
//      }
//    }
//    listener?.newConnectionHandler = { newConnection in
//      newConnection.stateUpdateHandler = { newState in
//        switch newState {
//          case .ready:
//            print("ListenerConnectionState: Ready\n")
//            self.receiveBroadcastResponse(on: newConnection)
//            return
//          case .setup:
//            print("ListenerConnectionState: Setup\n")
//          case .cancelled:
//            print("ListenerConnectionState: Cancelled\n")
//          case .preparing:
//            print("ListenerConnectionState: Preparing\n")
//          default:
//            print("ERROR! ListenerConnectionState not defined!\n")
//        }
//      }
//      newConnection.start(queue: self.backgroundQueueUdpListener)
//    }
//    listener?.start(queue: backgroundQueueUdpListener)
//  }
//  private func receiveBroadcastResponse(on connection: NWConnection) {
//    connection.receiveMessage { data, _, _, _ in
//      guard let data = data else {
//        print("Error: Received nil Data\n")
//        return
//      }
//      guard self.delegate != nil else {
//        print("Error: UDPClient response handler is nil\n")
//        return
//      }
//      self.delegate?.handleResponse(self, data: data)
//    }
//  }
//}
