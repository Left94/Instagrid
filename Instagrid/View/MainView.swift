//
//  MainView.swift
//  Instagrid
//
//  Created by vincent  on 01/03/2018.
//  Copyright © 2018 Loret Vincent. All rights reserved.
//

import UIKit

class MainView: UIView {

    @IBOutlet var roundedView1 : UIView!
    @IBOutlet var roundedView2 : UIView!
    @IBOutlet var roundedView3 : UIView!
    @IBOutlet var roundedView4 : UIView!
    @IBOutlet var roundedView5 : UIView!
    @IBOutlet var roundedView6 : UIView!

    @IBOutlet var layout1Selected : UIImageView!
    @IBOutlet var layout2Selected : UIImageView!
    @IBOutlet var layout3Selected : UIImageView!
    
    
   
    
    enum Format {
        case layout1, layout2, layout3
    }
    
    var format : Format = .layout2 {
        didSet {
            setFormat(format)
        }
    }
    
    private func setFormat(_ format : Format) {
        switch format {
        case .layout1:
            layout1Selected.isHidden = false
            layout2Selected.isHidden = true
            layout3Selected.isHidden = true
            roundedView1.isHidden = true
            roundedView2.isHidden = true
            roundedView3.isHidden = false
            roundedView4.isHidden = false
            roundedView5.isHidden = true
            roundedView6.isHidden = false
        case .layout2:
            layout1Selected.isHidden = true
            layout2Selected.isHidden = false
            layout3Selected.isHidden = true
            roundedView1.isHidden = false
            roundedView2.isHidden = false
            roundedView3.isHidden = true
            roundedView4.isHidden = true
            roundedView5.isHidden = false
            roundedView6.isHidden = true
        case .layout3:
            layout1Selected.isHidden = true
            layout2Selected.isHidden = true
            layout3Selected.isHidden = false
            roundedView1.isHidden = false
            roundedView2.isHidden = false
            roundedView3.isHidden = false
            roundedView4.isHidden = false
            roundedView5.isHidden = true
            roundedView6.isHidden = true
        
        }
        
    }
}
