//
//  VIPERConfig.swift
//  test-rappi-movies
//
//  Created by Sergio Zorrilla Arellano on 11/04/22.
//

import Foundation
import UIKit

/**
    This is the VIPER configuration file
*/

open class ARCHComponent {}

public protocol View: AnyObject {
}

open class Interactor: ARCHComponent {
    public var _presenter: Presenter?
    public override init() { super.init() }
}

open class Presenter: ARCHComponent {
    public weak var _view: View?
    public override init() { super.init() }
}

open class Router: ARCHComponent {
    public weak var _view: UIViewController?
    public override init() { super.init() }
}


extension UIViewController: View {
    
    private struct Holder {
        static var _myComputedProperty = [String:ARCHComponent]()
    }
    
    fileprivate static var computedProperty = [String: ARCHComponent]()
    
    var _interactor: Interactor {
        get {
            return Holder._myComputedProperty["\(self.debugDescription)Interactor"] as! Interactor
        }
        
        set(newValue) {
            Holder._myComputedProperty["\(self.debugDescription)Interactor"] = newValue
        }
    }
    
    var _router: Router {
        get {
            return Holder._myComputedProperty["\(self.debugDescription)Router"] as! Router
        }
        
        set(newValue) {
            Holder._myComputedProperty["\(self.debugDescription)Router"] = newValue
        }
    }
    
    func setup(
        interactor: Interactor? = nil,
        presenter: Presenter? = nil,
        router: Router? = nil) {
        if let i = interactor {
            self._interactor = i
            self._interactor._presenter = presenter!
            presenter!._view = self
        }
        
        if let r = router {
            self._router = r
            router!._view = self
        }
    }
}
