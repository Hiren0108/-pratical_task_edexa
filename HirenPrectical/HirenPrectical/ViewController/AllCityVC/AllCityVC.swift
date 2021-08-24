//
//  AllCityVC.swift
//  HirenPrectical
//
//  Created by IOSDEV1 on 23/08/21.
//

import UIKit
import ObjectMapper
import Alamofire


class AllCityVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var tblAllCity: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK:- Variable
    var searching = false
    var filterdata:[AllCityModel] = []
    var selectIndex:Int = 0
   
    
    //MARK:- View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    //MARK:- SetupUI
    func setupUI() {
        searchBar.delegate = self
        tblAllCity.delegate = self
        tblAllCity.dataSource = self
        tblAllCity.register(AllCityCell.nib, forCellReuseIdentifier: AllCityCell.identifier)
        apiCalling()
    }

}
//MARK:- Tableview Delegate Datasource
extension AllCityVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searching {
             return filterdata.count
        }else{
            return responseAllCity.count
        }
       // return responseAllCity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllCityCell.identifier, for: indexPath) as! AllCityCell
        let obj = responseAllCity[indexPath.row]
       // let searchObj = filterdata[indexPath.row]

//        if searching {
//            cell.setData(obj: searchObj)
//        }else{
//            cell.setData(obj: obj)
//        }
        cell.setData(obj: obj)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectIndex = indexPath.row
        let fName = responseAllCity[self.selectIndex].first_name!
        let lName = responseAllCity[self.selectIndex].last_name!
        Helper.showOKAlert(onVC: self, title: fName + " " + lName, message: "")
    }

}
//MARK:- API Calling
extension AllCityVC {
    
    func apiCalling() {
        
                if NetworkReachabilityManager()!.isReachable {
                    let url = URL(string: "https://api.npoint.io/c4683decc7df639018f6")
        
                    AF.request(url!, method: .get, parameters: [:]).responseJSON { (response) in
                        switch response.result {
        
                        case .success(let value):
                            if let responseArray = value as? [Any] {
                                if response.response?.statusCode == 200 {
                                    #if DEBUG
                                    print("Success with JSON: \(responseArray)")
                                    #endif
                                    if let dataResponse = Mapper<AllCityModel>().mapArray(JSONObject: value) {
                                        responseAllCity = dataResponse
                                        self.tblAllCity.reloadData()
                                    }
                                } else {
                                    print("Something went wrong")
                                }
                            }
        
                        case .failure(let error):
                            print("Error: \(error)")
                        }
                    }
        
                } else {
                    Helper.showOKAlert(onVC: self, title: "Alert", message: "No Internet")
                }
    }
}
//MARK:- Searchbar
extension AllCityVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.filterdata = responseAllCity.filter { $0.city?.contains(searchText)
        self.searching = true
        tblAllCity.reloadData()
        return true
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searching = false
        searchBar.text = ""
        tblAllCity.reloadData()
    }
}
