//
//  NewYorkCityVC.swift
//  HirenPrectical
//
//  Created by IOSDEV1 on 23/08/21.
//

import UIKit

class NewYorkCityVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var tblNewYorkCityVC: UITableView!
    
    //MARK:- Variable
    var responseNewYorkCity : [AllCityModel] = [AllCityModel]()
    var selectIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    //MARK:- SetupUI
    func setupUI() {
        for component in  responseAllCity {
            if component.city == "NewYork" {
                print(component.city!)
                self.responseNewYorkCity.append(component)
                print(self.responseNewYorkCity)
            }
        }
        tblNewYorkCityVC.delegate = self
        tblNewYorkCityVC.dataSource = self
        tblNewYorkCityVC.register(AllCityCell.nib, forCellReuseIdentifier: AllCityCell.identifier)
        
        
    }

}
//MARK:- Tableview Delegate Datasource
extension NewYorkCityVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseNewYorkCity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllCityCell.identifier, for: indexPath) as! AllCityCell
        let obj = responseNewYorkCity[indexPath.row]
        cell.setData(obj: obj)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectIndex = indexPath.row
        let fName = responseNewYorkCity[self.selectIndex].first_name!
        let lName = responseNewYorkCity[self.selectIndex].last_name!
        Helper.showOKAlert(onVC: self, title: fName + " " + lName, message: "")
    }

}
