//
//  Response.swift
//  NetworkingExample
//
//  Created by Sonu  on 01/01/18.
//  Copyright © 2018 Azync. All rights reserved.
//

import UIKit

class Response: NSObject {
  var dataReceived: Data?
  var error: Error?
  
  init(withData data:Data?, error:Error?){
      super.init()
      self.dataReceived = data
      self.error = error
  }
  
}
