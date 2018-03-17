//
//  Request.swift
//  NetworkingExample
//
//  Created by Sonu  on 01/01/18.
//  Copyright © 2018 Azync. All rights reserved.
//

import UIKit

class Request: NSMutableURLRequest {
  
  var httpType : HttpMethod
  var acceptValues : AcceptValues
  var timeout: Timeout
  var bodyContent: Params? = nil
  
  init(fromURL url:URL, httpType:HttpMethod, acceptValues: AcceptValues, timeout:Timeout){
    self.httpType = httpType
    self.acceptValues = acceptValues
    self.timeout = timeout
    
    super.init(url: url, cachePolicy: NSURLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval:timeout.rawValue)
  }
  
  init(fromURL urlString:String, httpType:HttpMethod, acceptValues: AcceptValues, timeout:Timeout, params:Params?, bodyContent: Params?){
    self.httpType = httpType
    self.acceptValues = acceptValues
    self.timeout = timeout
    self.bodyContent = bodyContent
    
    super.init(url: URL.init(string: urlString)!, cachePolicy: NSURLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval:timeout.rawValue)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  class func request(fromURL url:String?, httpType:HttpMethod, acceptValues: AcceptValues, timeout:Timeout, params:Params? = nil, bodyContent: Params?)->Request{
    let request = Request.init(fromURL: url!, httpType: httpType, acceptValues: acceptValues, timeout: timeout, params: params, bodyContent: bodyContent)
    request.prepareHeadrFields()
    request.url = request.createURLWithComponents(params: params)
    return request
  }
  
  func prepareHeadrFields(){
    self.httpMethod = self.httpType.rawValue
    self.setValue(self.acceptValues.rawValue, forHTTPHeaderField: "Accept")
    if self.httpType == HttpMethod.Post{
      self.setValue("application/json", forHTTPHeaderField: "Content-Type")
    }
    if let bodyContent = bodyContent{
      do{
        let jsonData = try JSONSerialization.data(withJSONObject: bodyContent, options: .prettyPrinted)
        self.httpBody = jsonData
      }catch{
        
      }
    }
    self.timeoutInterval = self.timeout.rawValue
  }
  
  
  func createURLWithComponents(params: Params?) -> URL? {
    // add params
    if var urlComponent = URLComponents.init(url: url!, resolvingAgainstBaseURL: false),var params = params{
      var queryItems = [URLQueryItem]()
      for key in params.keys.sorted(by: <) {
        queryItems.append(URLQueryItem.init(name: key, value: params[key]))
      }
      urlComponent.queryItems = queryItems
      return urlComponent.url
    }
    return url
  }
  
  
}
