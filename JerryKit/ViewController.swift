//
//  ViewController.swift
//  JerryKit
//
//  Created by Jayyi on 2020/10/3.
//  Copyright © 2020 Jerry987123. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("normal print")
        dprint("special dprint")
        dprint("special dprint", "test 2")
        if JyInternet().checkInternetFunction(){
            
        }
    }
}

