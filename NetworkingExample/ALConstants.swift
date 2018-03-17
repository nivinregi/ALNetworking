//
//  ALConstants.swift
//  NetworkingExample
//
//  Created by Sonu  on 01/01/18.
//  Copyright © 2018 Azync. All rights reserved.
//

public typealias Params = [String: String]

enum HttpMethod:String {
  case Get = "GET"
  case Post = "POST"
  case Put = "PUT"
  case Head = "HEAD"
  case Delete = "DELETE"
}

enum AcceptValues:String {
  case JSON = "application/json"
  case XML = "application/xml"
  case image = "image/*;q=0.8"
}

enum Timeout:Double {
  case Short = 60
  case Long = 120
}

enum AcceptKeys:String {
  case JSON = "JSON"
  case XML = "XML"
  case image = "IMAGE"
}
