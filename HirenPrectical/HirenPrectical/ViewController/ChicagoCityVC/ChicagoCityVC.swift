//
//  ChicagoCityVC.swift
//  HirenPrectical
//
//  Created by IOSDEV1 on 23/08/21.
//

import UIKit

class ChicagoCityVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var tblChicagoCity: UITableView!
    
    //MARK:- Variable
    var responseChicagoCity : [AllCityModel] = [AllCityModel]()
    var selectIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    //MARK:- SetupUI
    func setupUI() {
       for component in  responseAllCity {
        if component.city == "Chicago" {
            print(component.city as Any)
            self.responseChicagoCity.append(component)
            print(self.responseChicagoCity)
        }
    }
        tblChicagoCity.delegate = self
        tblChicagoCity.dataSource = self
        tblChicagoCity.register(AllCityCell.nib, forCellReuseIdentifier: AllCityCell.identifier)
    }

}
//MARK:- Tableview Delegate Datasource
extension ChicagoCityVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseChicagoCity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllCityCell.identifier, for: indexPath) as! AllCityCell
        let obj = responseChicagoCity[indexPath.row]
        cell.setData(obj: obj)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectIndex = indexPath.row
        let fName = responseChicagoCity[self.selectIndex].first_name!
        let lName = responseChicagoCity[self.selectIndex].last_name!
        Helper.showOKAlert(onVC: self, title: fName + " " + lName, message: "")
    }
}
