//
//  SignOutCode.swift
//  601wardrobe
//  Modified by Ashley on 12/5/17
//  Created by Tommy Zheng on 10/29/17.
//  Copyright © 2017 Tommy Zheng. All rights reserved.
//

import UIKit
import Firebase
import KeychainSwift
import FirebaseAuth
import FirebaseDatabase


class SignOutCode: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var cityNameTF: UITextField!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityTempLabel: UILabel!
    @IBOutlet weak var cityTempLabel2: UILabel!
    
    
    private let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    private let openWeatherMapAPIKey = "f22eb93db195b138f3e28fd4325b43b1"
    
    
    @IBAction func refreshClicked(_ sender: Any) {
        let newstring = cityNameTF.text!.replacingOccurrences(of: " ", with: "%20")
        getWeatherData(urlString: "http://api.openweathermap.org/data/2.5/weather?q=" + newstring + ",US&APPID=f22eb93db195b138f3e28fd4325b43b1")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherData(urlString: "http://api.openweathermap.org/data/2.5/weather?q=Boston,US&APPID=f22eb93db195b138f3e28fd4325b43b1")
    }
    
    // Sign Out button Function
    @IBAction func SignOut (_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        //Remove keycahin
        DataService().keyChain.delete("uid")
        dismiss(animated: true, completion: nil)
    }
    
    // Get Weather Data from OPenWeather API
    func getWeatherData(urlString: String) {
        let url = NSURL(string: urlString)
        let task = URLSession.shared.dataTask(with: url! as URL) {(data, response, error) in
            DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.async {
                    self.setLabels(weatherData: data! as NSData)
                }
            }
        }
        task.resume()
    }
    

    var jsonData: AnyObject?
    var temp2: Double?
    var temp3: Double?
    func setLabels(weatherData: NSData) {
        do {
            self.jsonData = try JSONSerialization.jsonObject(with: weatherData as Data, options: []) as! NSDictionary
        } catch {
            print("Error!")
        }
        if let name = jsonData!["name"] as? String {
            cityNameLabel.text = "\(name)"
        }
        if let main = jsonData!["main"] as? NSDictionary {
            if let temp = main["temp"] as? Double {
                self.temp2 = ((temp*9)/5)-459.67
                self.temp3 = temp-273.15
                cityTempLabel.text = String(format: "%.1f", temp2!) + String("  °F")
                cityTempLabel2.text = String(format: "%.1f", temp3!) + String("  °C")
            }
        }
    }
    
    @IBAction func suggestPressed(_ sender: Any) {
        var temp_to_send: Double
        temp_to_send = temp3!
        let myVC = storyboard?.instantiateViewController(withIdentifier: "suggestionVC") as!
            suggestionVC
        myVC.temp_sent = temp_to_send
        navigationController?.pushViewController(myVC, animated: true)
    }
    
}
