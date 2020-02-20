//
//  ViewController.swift
//  Hack Hers Weather APP
//
//  Created by Salman Fakhri on 2/19/20.
//  Copyright © 2020 Salman Fakhri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var zipcodeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "weatherSegue" {
            let weatherViewController = segue.destination as! WeatherViewController
            
            weatherViewController.zipcode = zipcodeTextField.text
        }
    }


}

