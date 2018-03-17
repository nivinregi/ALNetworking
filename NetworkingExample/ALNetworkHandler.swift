//
//  ALNetworkHandler.swift
//  NetworkingExample
//
//  Created by Sonu  on 01/01/18.
//  Copyright © 2018 Azync. All rights reserved.
//

import UIKit

class ALNetworkHandler: NSObject, URLSessionDelegate {
    static let taskQueue = OperationQueue.init()
    static let shared = ALNetworkHandler()
    var session: URLSession?
    var delegate : NetworkDelegate?
  
  override init() {
    super.init()
    delegate = NetworkDelegate()
    delegate?.sessionHandler = self
    let sessionConfig = URLSessionConfiguration.default
    session = URLSession.init(configuration: sessionConfig, delegate: delegate, delegateQueue: nil)
  }
  
  class func getResponse(forRequest request: String, params:Params?, bodyContent:Params?, withCompletion completion: @escaping(_ response: Response) -> Void){
    let networkRequest = NetworkOperation.init(withRequest: request, inSession: ALNetworkHandler.shared.session!, sessionDelegate: ALNetworkHandler.shared.delegate!, params: params, bodyContent: bodyContent, completion: completion)
    
    taskQueue.addOperation(networkRequest)
  }
}
