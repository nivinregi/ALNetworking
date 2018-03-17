//
//  NetworkOperation.swift
//  NetworkingExample
//
//  Created by Sonu  on 01/01/18.
//  Copyright © 2018 Azync. All rights reserved.
//

import UIKit

class NetworkOperation: Operation {
  var data: NSMutableData?
  var url: URL?
  weak var session: URLSession?
  weak var delegate : NetworkDelegate?
  var completionHandler: ((Response) -> Void)?
  var urlRequest : Request?
  
  convenience init(withRequest stringUrl:String, inSession urlSession:URLSession, sessionDelegate:NetworkDelegate, params:Params?, bodyContent: Params?, completion: @escaping ((Response) ->Void)) {
    self.init()
    data = NSMutableData.init()
    session = urlSession
    delegate = sessionDelegate
    completionHandler = completion
    urlRequest = Request.request(fromURL: stringUrl, httpType: HttpMethod.Get, acceptValues: AcceptValues.JSON, timeout: Timeout.Short,params: params, bodyContent: bodyContent)
  }
  
  override func start() {
    let task = session?.dataTask(with: urlRequest! as URLRequest)
    if let delegate = delegate, let task = task{
      delegate[task] = self
    }
    task?.resume()
  }
  
  func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
    data.enumerateBytes { (ptr, byteRange, stop) in
      self.data?.append(data)
    }
  }
  func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
    if let completionHandler = completionHandler{
      let response = Response.init(withData: self.data?.copy() as? Data, error: error)
      completionHandler(response)
    }
  }
  
  
}
