//
//  ViewController.swift
//  HTTPMocking
//
//  Created by The App Experts on 26/03/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
   
    @IBOutlet weak var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let parameters = PagingParameters(page: 0, number: 10)

        var request = HTTPRequest()
//        request.body = JSONBody(parameters)
        request.body = FormBody(["greeting": "Hello, ", "target": "🌎"])
        print("REQUEST.", request)
        print("BODY.", request.body)
        print("DONE")
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
    }
    
}

struct PagingParameters: Encodable {
    let page: Int
    let number: Int
}
