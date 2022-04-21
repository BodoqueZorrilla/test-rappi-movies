//
//  Tools.swift
//  test-rappi-movies
//
//  Created by Sergio Zorrilla Arellano on 20/04/22.
//

import Foundation
import UIKit

open class  Tools {
    typealias CompletionHandler = () -> Void

    static func showAlert(title: String, message: String, titleForTheAction: String, in vc: UIViewController, titleForCancelAction: String, completionHandler: @escaping CompletionHandler) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: titleForTheAction, style: .default) { (action:UIAlertAction!) in
            completionHandler()
        })
        if titleForCancelAction != "" {
            alert.addAction(UIAlertAction(title: titleForCancelAction, style: .cancel) { (action:UIAlertAction!) in
            })
        }
        vc.present(alert, animated: true, completion: nil)
    }
}
