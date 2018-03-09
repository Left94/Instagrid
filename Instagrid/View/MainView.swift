//
//  MainView.swift
//  Instagrid
//
//  Created by vincent  on 01/03/2018.
//  Copyright © 2018 Loret Vincent. All rights reserved.
//

import UIKit

enum Format {
    case layout1, layout2, layout3
}

class MainView: UIView {

    @IBOutlet var view1 : UIView!
    @IBOutlet var view2 : UIView!
    @IBOutlet var view3 : UIView!
    @IBOutlet var view4 : UIView!
    @IBOutlet var view5 : UIView!
    @IBOutlet var view6 : UIView!

    @IBOutlet var layout1Selected : UIImageView!
    @IBOutlet var layout2Selected : UIImageView!
    @IBOutlet var layout3Selected : UIImageView!
    
    
   
    
    
    
    var format : Format = .layout2 {
        didSet {
            setFormat(format)
        }
    }
    
    fileprivate func displayLayout1() {
        layout1Selected.isHidden = false
        layout2Selected.isHidden = true
        layout3Selected.isHidden = true
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = false
        view4.isHidden = false
        view5.isHidden = true
        view6.isHidden = false
    }
    
    fileprivate func displayLayout2() {
        layout1Selected.isHidden = true
        layout2Selected.isHidden = false
        layout3Selected.isHidden = true
        view1.isHidden = false
        view2.isHidden = false
        view3.isHidden = true
        view4.isHidden = true
        view5.isHidden = false
        view6.isHidden = true
    }
    
    fileprivate func displayLayout3() {
        layout1Selected.isHidden = true
        layout2Selected.isHidden = true
        layout3Selected.isHidden = false
        view1.isHidden = false
        view2.isHidden = false
        view3.isHidden = false
        view4.isHidden = false
        view5.isHidden = true
        view6.isHidden = true
    }
    
    private func setFormat(_ format : Format) {
        switch format {
        case .layout1:
            displayLayout1()
        case .layout2:
            displayLayout2()
        case .layout3:
            displayLayout3()
        }
        
        
    }
}
