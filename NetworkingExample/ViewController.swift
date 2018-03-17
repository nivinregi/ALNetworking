//
//  ViewController.swift
//  NetworkingExample
//
//  Created by Sonu  on 01/01/18.
//  Copyright © 2018 Azync. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    ALNetworkHandler.getResponse(forRequest: "http://img-mm.manoramaonline.com/content/dam/mm/ml/news/latest-news/images/2017/Dec/1/Rain-havoc-TVM.jpg.image.488.253.jpeg", params: nil, bodyContent: nil) { (response) in
            if let dataReceived = response.dataReceived{
              DispatchQueue.main.async {
                var image = UIImage.init(data: dataReceived)
                self.view.addSubview(UIImageView.init(image: image))
                let json = try? JSONSerialization.jsonObject(with: dataReceived, options: [])
                print(json ?? "NO VALUE")
              }
        }
    }
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

