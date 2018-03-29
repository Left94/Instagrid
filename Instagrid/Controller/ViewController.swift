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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
    }
//MARK: - OUTLETS
    //Manage the main view format
    @IBOutlet weak var mainView: MainView!
    @IBOutlet weak var buttonLayout1: UIButton!
    @IBOutlet weak var buttonLayout2: UIButton!
    @IBOutlet weak var buttonLayout3: UIButton!
    //Image views outlet's collection
    @IBOutlet var imageViews: [UIImageView]!
    //Button views outlet's collection
    @IBOutlet var imageViewButtons: [UIButton]!

//MARK: - VARS
    var imagePicker = UIImagePickerController()
    var imageTag = 0
    
//MARK: - METHODS
    // Error popup method using UIAlertConrtoller
    fileprivate func displayErrorPopup(title:String, message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Continue", style: .cancel, handler: { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }))
        present(alertController, animated: true)
    }
    //Check if layout 1 images Slots are not empty else we call the displayErrorPopup method to ask user to select missing images
    fileprivate func checkIfReadyToShareLayout1() {
        if mainView.format == .layout1{
            if (imageViews[2].image != nil) && (imageViews[3].image != nil) && (imageViews[5].image != nil) {
                shareMainView()
            }else{
                print("add photo please 1")
                displayErrorPopup(title: "Error", message: "Please add image to empty slot!")
            }
        }
    }
    //Check if layout 2 images Slots are not empty else we call the displayErrorPopup method to ask user to select missing images
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
    //Check if layout 3 images Slots are not empty else we call the displayErrorPopup method to ask user to select missing images
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
    //Method call when user wants to share to be sure images slots are not empty
    fileprivate func layoutReadyToShare() {
        checkIfReadyToShareLayout1()
        checkIfReadyToShareLayout2()
        checkIfReadyToShareLayout3()
    }
    //Flip effect used when a layout format is selected and also when the user clear images
    fileprivate func flipView(view : UIView, flipFrom: UIViewAnimationOptions) {
        let transitionOptions: UIViewAnimationOptions = [flipFrom, .showHideTransitionViews]
        UIView.transition(with: view, duration: 0.7, options: transitionOptions, animations: {
            self.view.isHidden = true
        })
        UIView.transition(with: view, duration: 0.7, options: transitionOptions, animations: {
            self.view.isHidden = false
        })
    }
    //Method call after a down swipe (portrait mode) or right swipe (landscape mode) to animate deleted images
    fileprivate func flipAllImagesAfterClear() {
        
        for i in 0..<imageViews.count {
            if i % 2 == 0 {
                flipView(view: imageViews[i], flipFrom: .transitionFlipFromRight)
            }else{
                flipView(view: imageViews[i], flipFrom: .transitionFlipFromLeft)
            }
        }
    }
    //Method call after a down swipe (portrait mode) or right swipe (landscape mode) to delete images already selected
    fileprivate func clearImageViews() {
        imageViews.forEach { $0.image = nil }
    }
    //Method call after a down swipe (portrait mode) or right swipe (landscape mode) to do reappear the image button views
    fileprivate func showImageButtons() {
        imageViewButtons.forEach { $0.imageView?.isHidden = false }
    }
    //Method call after a down swipe (portrait mode) or right swipe (landscape mode) to do hide the image button views

    fileprivate func hideImageButtons() {
        imageViewButtons.forEach { $0.imageView?.isHidden = true }
    }
    //Methods call when clear the views
    fileprivate func clearTheViews () {
        flipAllImagesAfterClear()
        showImageButtons()
        clearImageViews()
    }
//MARK: - BUTTONS
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
            imageTag = sender.tag
            present(imagePicker, animated: true)
        }
    }
//MARK: - SWIPE GESTURES
    //action did afer swiped down(portrait mode) swiped right (landscape mode)
    @IBAction func swipeToClear(_ sender: UISwipeGestureRecognizer) {
        print("swiped to clear")
        clearTheViews()
    }
    //action did after swiping on the swipe Gesture Recognizers (Left/Up gestures) using UIActivityViewController///////////////////
    fileprivate func shareMainView() {
        hideImageButtons()
        guard let image = Grid.convertGridViewToImage(mainView: mainView) else { return }
        
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityViewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(activityViewController, animated: true, completion: nil)
    }
    //Check layoutReadyToShare before make the final view to be shared
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
    //change imageView with user's selected image from gallery using imageViewButton's tag
    fileprivate func imageSelected(_ pickedImage: UIImage?) {

        for i in 0..<imageViews.count {
            if imageTag == i + 3 {
                pickAndHidden(pickedImage: pickedImage, imageTag: i)
            }
        }
    }
    func pickAndHidden(pickedImage: UIImage?, imageTag: Int) {
        imageViews[imageTag].image = pickedImage
        imageViewButtons[imageTag].imageView?.isHidden = true
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
