//
//  WetherDeatilsTableController.swift
//  WeatherTets
//
//  Created by iT Gurus Software on 02/11/17.
//  .
//

import UIKit

class WetherDeatilsTableController: UITableViewController {
    
    
    
    @IBOutlet weak var cityNameLabel: UILabel!
    var cityData:WeatherModel = WeatherModel()
    
    var cityName:String?

    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var temp_min: UILabel!
    @IBOutlet weak var temp_max: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTempData()
     
    }
    
    
    func setTempData(){
        
         tempLabel.text = "\(cityData.temp)"
         pressureLabel.text = "\(cityData.pressure)"
         humidityLabel.text = "\(cityData.humidity)"
         temp_min.text = "\(cityData.temp_min)"
         temp_max.text = "\(cityData.temp_max)"
        
        self.navigationItem.title = cityName
        
       }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animate(withDuration: 1.0, animations: {
            cell.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1)
        },completion: { finished in
            UIView.animate(withDuration: 0.5, animations: {
                cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
            })
        })
    }
    
   
}
