//
//  NetworkDelegate.swift
//  NetworkingExample
//
//  Created by Sonu  on 01/01/18.
//  Copyright © 2018 Azync. All rights reserved.
//

import UIKit

class NetworkDelegate: NSObject {
  private var requests: [Int: NetworkOperation] = [:]
  private let lock = NSLock()
  weak var sessionHandler : ALNetworkHandler?
  open subscript(task: URLSessionTask) -> NetworkOperation? {
    get {
      lock.lock() ; defer { lock.unlock() }
      return requests[task.taskIdentifier]
    }
    set {
      lock.lock() ; defer { lock.unlock() }
      requests[task.taskIdentifier] = newValue
    }
  }
  
  override init() {
    super.init()
  }
  
  
  
}


extension NetworkDelegate: URLSessionDelegate {
  
}

extension NetworkDelegate: URLSessionTaskDelegate {
  func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
    if let operation = self[task] {
      operation.urlSession(session, task: task, didCompleteWithError: error)
    }
  }
}

extension NetworkDelegate: URLSessionDataDelegate {
  
  func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
    if let operation = self[dataTask] {
      operation.urlSession(session, dataTask: dataTask, didReceive: data)
    }
  }
}
