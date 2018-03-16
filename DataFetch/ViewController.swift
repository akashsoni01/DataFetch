//
//  ViewController.swift
//  DataFetch
//
//  Created by ANURAG ADARSH on 16/03/18.
//  Copyright © 2018 ANURAG ADARSH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var displayButton: UIButton!
    var weathre:WeatherReport?{
        didSet{
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = URL(string:"http://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22")
        let task = URLSession.shared.dataTask(with: url!){ (data,response,error) in
            if let urlContent = data {
                let result = try? JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                
            
                DispatchQueue.main.async {
                    self.weathre = try? WeatherReport(json: result as! [String : AnyObject])
                    
                    self.displayButton.setTitle(result?["name"] as? String, for: .normal)
                    
                    print(self.weathre?.coordinate.lat ?? "object not done")
                    
                }
            }
        }
        
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

