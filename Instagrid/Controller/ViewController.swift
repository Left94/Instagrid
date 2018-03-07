//
//  ViewController.swift
//  Instagrid
//
//  Created by vincent  on 06/02/2018.
//  Copyright © 2018 Loret Vincent. All rights reserved.
//

import UIKit


import UIKit

@IBDesignable public class RoundedView: UIView { //Class Custom to add some border color,size and radius
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
}

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //Manage the main view format
    @IBOutlet weak var mainView: MainView!
    @IBOutlet weak var buttonLayout1: UIButton!
    @IBOutlet weak var buttonLayout2: UIButton!
    @IBOutlet weak var buttonLayout3: UIButton!
    
    //Manage the Image views
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView1button: UIButton!
    @IBOutlet weak var imageView2button: UIButton!
    var imagePicker = UIImagePickerController()
    var imagePicked = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false    }

    
    //action did after taping a layout button
    @IBAction func didTapButtonLayout1() {
        mainView.format = .layout1
    }
    @IBAction func didTapButtonLayout2() {
        mainView.format = .layout2
    }
    @IBAction func didTapButtonLayout3() {
        mainView.format = .layout3
    }
   
    
    //action did after taping an imageView button
    @IBAction func imageView1BtnClicked(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func imageView2BtnClicked(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController , didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageView1.image = pickedImage
            self.imageView1button.imageView?.isHidden = true
            
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    

}

