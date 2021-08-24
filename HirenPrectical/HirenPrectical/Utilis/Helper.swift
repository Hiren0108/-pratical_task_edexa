//
//  Helper.swift
//  HirenPrectical
//
//  Created by IOSDEV1 on 23/08/21.
//

import UIKit
import Foundation

class Helper: NSObject {
    
class func showOKAlert(onVC viewController: UIViewController,title: String,message: String){


    DispatchQueue.main.async {
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        alert.view.setNeedsLayout()
        viewController.present(alert, animated: true, completion: nil)
    }
}
}
