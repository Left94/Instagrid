//
//  Grid.swift
//  Instagrid
//
//  Created by vincent  on 26/03/2018.
//  Copyright © 2018 Loret Vincent. All rights reserved.
//


import UIKit

class Grid {
    
    //Method to convert the mainView to an image
    static func convertGridViewToImage(mainView: MainView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(mainView.bounds.size, mainView.isOpaque, 0.0)
        mainView.drawHierarchy(in: mainView.bounds, afterScreenUpdates: true)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }
}

