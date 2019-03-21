//
//  WebSocketService.swift
//  mattermost
//
//  Created by Vadim Salmin on 13/03/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation
import Starscream

class WebSocketService: BaseService, WebSocketDelegate, WebSocketAdvancedDelegate {
  override var prefix: String { get { return "websocket" } }
  
  private var socket: WebSocket?

  func connect() {
//    var request = URLRequest(url: URL(string: "wss://mattermost.osinit.com/api/v4/websocket")!)
//    request.addValue("MMAUTHTOKEN=4wizsj4973b6mfir816yfp6ejr", forHTTPHeaderField: "Cookie")
//    request.addValue("MMUSERID=hphohak54jr6tdifbd3dzykn8y", forHTTPHeaderField: "Cookie")
//    request.addValue("mattermost.osinit.com", forHTTPHeaderField: "Host")
//    socket = WebSocket(request: request)
//    socket?.delegate = self
//    socket?.advancedDelegate = self
//    socket?.onConnect = {
//      self.socket?.write(string: "{\"seq\": 1,\"action\": \"authentication_challenge\",\"data\":{\"token\":\"41mc55zpxtgetd5f516k4xe84w\"}}")
//    }
//    socket?.connect()
  }
  
  func websocketDidConnect(socket: WebSocketClient) {
    print("connect")
  }
  
  func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
    print("receive data")
  }
  
  func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
    print(text)
  }
  
  func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
    print("disconnected")
  }
  
  func websocketDidConnect(socket: WebSocket) {
    print(#function)
  }
  func websocketDidDisconnect(socket: WebSocket, error: Error?) {
    print(#function, error)
  }
  func websocketDidReceiveMessage(socket: WebSocket, text: String, response: WebSocket.WSResponse) {
    print(#function)
  }
  func websocketDidReceiveData(socket: WebSocket, data: Data, response: WebSocket.WSResponse) {
    print(#function, response)
  }
  func websocketHttpUpgrade(socket: WebSocket, request: String) {
    print(#function, request)
  }
  func websocketHttpUpgrade(socket: WebSocket, response: String) {
    print(#function, response)
  }
}
