//
//  ViewControllerFactory.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/07.
//

import UIKit

class ViewControllerFactory: NSObject {
    
    static func viewController(for typeOfVC: TypeOfViewController) -> UIViewController {
        let metaData = typeOfVC.storyboardRepresentation()
        let sb = UIStoryboard(name: metaData.storyboardName, bundle: metaData.bundle)
        let vc = sb.instantiateViewController(withIdentifier: metaData.storyboardId)
        return vc
    }
}
