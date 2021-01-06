//
//  CustomAlerts.swift
//  Articles
//
//  Created by Оксана Котілевська on 15.11.2020.
//

import UIKit

class CustomAlert: NSObject {
    
    static func showAlertWith(message: String, reason: AlertReason, presenterVC: UIViewController) {
        let alert = UIAlertController(title: reason.getTitle(), message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        presenterVC.present(alert, animated: true)
    }
    
}

enum AlertReason {
    case error, success
    
    func getTitle() -> String {
        switch self{
        case .success: return "Success"
        case .error: return "Error"
        }
    }
}
