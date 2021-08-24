//
//  LosAngelesCityVC.swift
//  HirenPrectical
//
//  Created by IOSDEV1 on 23/08/21.
//

import UIKit

class LosAngelesCityVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var tblLosAngelesCity: UITableView!
    
    //MARK:- Variable
    var responseLosAngelesCity : [AllCityModel] = [AllCityModel]()
    var selectIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    //MARK:- SetupUI
    func setupUI() {
        for component in  responseAllCity {
            if component.city == "Los Angeles" {
                print(component.city!)
                self.responseLosAngelesCity.append(component)
                print(self.responseLosAngelesCity)
            }
        }
        tblLosAngelesCity.delegate = self
        tblLosAngelesCity.dataSource = self
        tblLosAngelesCity.register(AllCityCell.nib, forCellReuseIdentifier: AllCityCell.identifier)
        
        
    }
}
//MARK:- Tableview Delegate Datasource
extension LosAngelesCityVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return responseLosAngelesCity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllCityCell.identifier, for: indexPath) as! AllCityCell
        let obj = responseLosAngelesCity[indexPath.row]
        cell.setData(obj: obj)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectIndex = indexPath.row
        let fName = responseLosAngelesCity[self.selectIndex].first_name!
        let lName = responseLosAngelesCity[self.selectIndex].last_name!
        Helper.showOKAlert(onVC: self, title: fName + " " + lName, message: "")
    }
}
