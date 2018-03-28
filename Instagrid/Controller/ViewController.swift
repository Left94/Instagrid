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
    @IBOutlet var imageViews: [UIImageView]!
//Manage the Buttons
    @IBOutlet var imageViewButtons: [UIButton]!
//Manage the popUpView center constraint

    
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
    // Error popup
    private func displayErrorPopup(title:String, message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Continue", style: .cancel, handler: { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }))
        present(alertController, animated: true)
    }
    fileprivate func checkIfReadyToShareLayout1() {
        if mainView.format == .layout1{
            if (imageViews[2].image != nil) && (imageViews[3].image != nil) && (imageViews[5].image != nil) {
                shareMainView()
            }else{
                print("add photo please 1")
                displayErrorPopup(title: "Error", message: "Please add image to empty slot!")
                //showPopUp()
            }
        }
    }
    
    fileprivate func checkIfReadyToShareLayout2() {
        if mainView.format == .layout2 {
            if (imageViews[0].image != nil) && (imageViews[1].image != nil) && (imageViews[4].image != nil) {
                shareMainView()
            }else{
                print("add photo please 2")
                displayErrorPopup(title: "Error", message: "Please add image to empty slot!")
            }
        }
    }
    
    fileprivate func checkIfReadyToShareLayout3() {
        if mainView.format == .layout3 {
            if (imageViews[0].image != nil) && (imageViews[1].image != nil) && (imageViews[2].image != nil) && (imageViews[3].image != nil) {
                shareMainView()
            }else{
                print("add photo please 3")
                displayErrorPopup(title: "Error", message: "Please add image to empty slot!")
            }
        }
    }
    
    fileprivate func layoutReadyToShare() {
        checkIfReadyToShareLayout1()
        checkIfReadyToShareLayout2()
        checkIfReadyToShareLayout3()
        
    }
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
        flipView(view: imageViews[0], flipFrom: .transitionFlipFromRight)
        flipView(view: imageViews[1], flipFrom: .transitionFlipFromLeft)
        flipView(view: imageViews[2], flipFrom: .transitionFlipFromRight)
        flipView(view: imageViews[3], flipFrom: .transitionFlipFromLeft)
        flipView(view: imageViews[4], flipFrom: .transitionFlipFromRight)
        flipView(view: imageViews[5], flipFrom: .transitionFlipFromLeft)
    }
//action call after a down swipe (portrait mode) or right swipe (landscape mode) to delete images already selected
    fileprivate func clearImageViews() {
        imageViews.forEach { $0.image = nil }
    }
//action call after a down swipe (portrait mode) or right swipe (landscape mode) to do reappear the image button views
    fileprivate func showImageButtons() {
        imageViewButtons.forEach { $0.imageView?.isHidden = false }
    }
    fileprivate func hideImageButtons() {
        imageViewButtons.forEach { $0.imageView?.isHidden = true }
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
//action did after swiping on the swipe Gesture Recognizers (Left/Up gestures) using UIActivityViewController///////////////////
    fileprivate func shareMainView() {
        hideImageButtons()
        UIGraphicsBeginImageContext(mainView.frame.size)
        mainView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let activityViewController = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        activityViewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(activityViewController, animated: true, completion: nil)
    }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    @IBAction func shareSwipe(_ sender: UISwipeGestureRecognizer) {
        print("swiped to share")
        layoutReadyToShare()
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
            imageViews[0].image = pickedImage
            imageViewButtons[0].imageView?.isHidden = true
        }else if imagePicked == 4 {
            imageViews[1].image = pickedImage
            imageViewButtons[1].imageView?.isHidden = true
        }else if imagePicked == 5 {
            imageViews[2].image = pickedImage
            imageViewButtons[2].imageView?.isHidden = true
        }else if imagePicked == 6 {
            imageViews[3].image = pickedImage
            imageViewButtons[3].imageView?.isHidden = true
        }else if imagePicked == 7 {
            imageViews[4].image = pickedImage
            imageViewButtons[4].imageView?.isHidden = true
        }else if imagePicked == 8 {
            imageViews[5].image = pickedImage
            imageViewButtons[5].imageView?.isHidden = true
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
