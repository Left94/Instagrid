//
//  ViewController.swift
//  Instagrid
//
//  Created by vincent  on 06/02/2018.
//  Copyright © 2018 Loret Vincent. All rights reserved.
//

import UIKit


import UIKit



class ViewController: UIViewController {
    
    //MARK : - OUTLETS
    //Manage the main view format
    @IBOutlet weak var mainView: MainView!
    @IBOutlet weak var buttonLayout1: UIButton!
    @IBOutlet weak var buttonLayout2: UIButton!
    @IBOutlet weak var buttonLayout3: UIButton!
    
    
    //Manage the Images view
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var imageView6: UIImageView!
    
    
    
    //Manage the Buttons view
    @IBOutlet weak var imageView1Button: UIButton!
    @IBOutlet weak var imageView2Button: UIButton!
    @IBOutlet weak var imageView3Button: UIButton!
    @IBOutlet weak var imageView4Button: UIButton!
    @IBOutlet weak var imageView5Button: UIButton!
    @IBOutlet weak var imageView6Button: UIButton!
    
    
    
    //VARS
    var imagePicker = UIImagePickerController()
    var imagePicked = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        
    }
    //MARK : - METHODS
    //Flip effect
    fileprivate func flipView(view : UIView, flipFrom: UIViewAnimationOptions) {
        let transitionOptions: UIViewAnimationOptions = [flipFrom, .showHideTransitionViews]
        UIView.transition(with: view, duration: 0.7, options: transitionOptions, animations: {
            self.view.isHidden = true
        })
        UIView.transition(with: view, duration: 0.7, options: transitionOptions, animations: {
            self.view.isHidden = false
        })
    }
    //action call after a down swipe (portrait mode) or right swipe (landscape mode) to animate deleted images
    fileprivate func flipAllImagesAfterClear() {
        flipView(view: imageView1, flipFrom: .transitionFlipFromRight)
        flipView(view: imageView2, flipFrom: .transitionFlipFromLeft)
        flipView(view: imageView3, flipFrom: .transitionFlipFromRight)
        flipView(view: imageView4, flipFrom: .transitionFlipFromLeft)
        flipView(view: imageView5, flipFrom: .transitionFlipFromRight)
        flipView(view: imageView6, flipFrom: .transitionFlipFromLeft)
    }
    //action call after a down swipe (portrait mode) or right swipe (landscape mode) to delete images already selected
    fileprivate func clearImageViews() {
        [imageView1, imageView2, imageView3, imageView4, imageView5, imageView6].forEach { $0?.image = nil }
    }
    //action call after a down swipe (portrait mode) or right swipe (landscape mode) to do reappear the image buttons view
    fileprivate func showImageButtons() {
        [imageView1Button, imageView2Button, imageView3Button, imageView4Button,imageView5Button, imageView6Button].forEach { $0?.imageView?.isHidden = false }
    }
    //Methods call when clear the views
    fileprivate func clearTheViews () {
        flipAllImagesAfterClear()
        showImageButtons()
        clearImageViews()
    }

    //MARK : - BUTTONS
    //action did after taping a layout button
    @IBAction func buttonLayoutClicked(_ sender: UIButton) {
        let tag = sender.tag
        switch tag {
        case 0:
            mainView.format = .layout1
            flipView(view: mainView, flipFrom: .transitionFlipFromBottom)
        case 1:
            mainView.format = .layout2
            flipView(view: mainView, flipFrom: .transitionFlipFromTop)
        case 2:
            mainView.format = .layout3
            flipView(view: mainView, flipFrom: .transitionFlipFromBottom)
        default:
            break
        }
    }
    //action did after taping an imageView button
    @IBAction func buttonViewCliked(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum){
            imagePicked = sender.tag
            present(imagePicker, animated: true)
        }
        
    }
    //action did afer swiped down(portrait mode) swiped right (landscape mode)
    @IBAction func swipeToClear(_ sender: UISwipeGestureRecognizer) {
        print("swiped to clear")
        clearTheViews()
    }
    //action did after swiping on the swipe Gesture Recognizers (Left/Up gestures) using UIActivityViewController
    @IBAction func shareSwipe(_ sender: UISwipeGestureRecognizer) {
        print("swiped to share")
        
        UIGraphicsBeginImageContext(mainView.frame.size)
        mainView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        let activityViewController = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        
        activityViewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(activityViewController, animated: true, completion: nil)
    }
}

//MARK: - UIImagePickerController

extension UIImagePickerController {
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
}
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    fileprivate func imageSelected(_ pickedImage: UIImage?) {
        if imagePicked == 3 {
            imageView1.image = pickedImage
            imageView1Button.imageView?.isHidden = true
        }else if imagePicked == 4 {
            imageView2.image = pickedImage
            imageView2Button.imageView?.isHidden = true
        }else if imagePicked == 5 {
            imageView3.image = pickedImage
            imageView3Button.imageView?.isHidden = true
        }else if imagePicked == 6 {
            imageView4.image = pickedImage
            imageView4Button.imageView?.isHidden = true
        }else if imagePicked == 7 {
            imageView5.image = pickedImage
            imageView5Button.imageView?.isHidden = true
        }else if imagePicked == 8 {
            imageView6.image = pickedImage
            imageView6Button.imageView?.isHidden = true
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController , didFinishPickingMediaWithInfo info: [String : Any]) {
        let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        imageSelected(pickedImage)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
