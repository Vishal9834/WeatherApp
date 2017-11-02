//
//  WeatherListController.swift
//  WeatherTets
//
//  .
//  .
//

import Foundation
import UIKit

class WeatherListController : UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var weatherData:Array<WeatherModel>?
    var selectedCityIndex = 0


    
    var cityName = ["Sydney" , "Melbourne" , "Brisbane"]
    

    override func viewDidLoad() {
        
        inItView()
        initVM()


    }
    
    lazy var viewModel:WeatherListViewModel = {
        return WeatherListViewModel(apiService : APIService(),cityList:[4163971 , 2147714 , 2174003] )
    }()

    
    
    func inItView(){
        
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    
    func initVM(){
        
        print(viewModel)
        viewModel.initFetch {
            (weatherArray) in
            
           self.weatherData = weatherArray
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}





extension WeatherListController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCellIdentifier", for: indexPath) as? WeatherListTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        
        
        let cellVM = weatherData?[indexPath.row]
        
        if let temp = cellVM?.temp{
        
        cell.tempLabel.text = "\(temp)"
        cell.cityLabel.text = cityName[indexPath.row]
        }
//
//        cell.nameLabel.text = cellVM.titleText
//        cell.descriptionLabel.text = cellVM.descText
//        cell.mainImageView?.sd_setImage(with: URL( string: cellVM.imageUrl ), completed: nil)
//        cell.dateLabel.text = cellVM.dateText
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedCityIndex = indexPath.row
        self.performSegue(withIdentifier: "TableDetail", sender: nil)

        
    }
    
}

extension WeatherListController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? WetherDeatilsTableController{
            
            if let data = weatherData?[selectedCityIndex]{
            vc.cityName = cityName[selectedCityIndex]
            vc.cityData = data
            }
            
        }
        }
    }


class WeatherListTableViewCell: UITableViewCell {
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
   }


