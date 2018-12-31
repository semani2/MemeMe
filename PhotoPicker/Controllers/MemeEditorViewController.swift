//
//  ViewController.swift
//  PhotoPicker
//
//  Created by Sai Emani on 11/17/18.
//  Copyright © 2018 Sai Emani. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    let topText = "TOP"
    let bottomText = "BOTTOM"

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    let strokeTextAttributes = [
        NSAttributedString.Key.strokeColor : UIColor.black,
        NSAttributedString.Key.foregroundColor : UIColor.white,
        NSAttributedString.Key.strokeWidth : -4.0,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!]
        as [NSAttributedString.Key : Any]
    
    var meme: Meme!
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTextField(topTextField)
        initTextField(bottomTextField)
        
        shareButton.isEnabled = false
        
        resetViews()
        
        if (meme != nil) {
            topTextField.text = meme.top
            bottomTextField.text = meme.bottom
            imageView.image = meme.originalImage
            
            shareButton.isEnabled = true
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("user selected an image")
        dismiss(animated: true, completion: nil)
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
            shareButton.isEnabled = true
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("User cancelled picking an image")
        dismiss(animated: true, completion: nil)
    }

    @IBAction func pickImage(_ sender: Any) {
        performImagePicking(.photoLibrary)
    }
    
    @IBAction func pickCameraImage(_ sender: Any) {
        performImagePicking(.camera)
    }
    
    func performImagePicking(_ source: UIImagePickerController.SourceType) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = source
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func saveMeme(_ sender: Any) {
        print("Save meme called")
        let memedImage = generateMemedImage()
        
        let controller = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        controller.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if !completed {
                // User canceled
                return
            }
            let meme = Meme(top: self.topTextField.text!, bottom: self.bottomTextField.text!, originalImage: self.imageView.image!, memedImage: memedImage)
            (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
            
            print("Meme appended, size of memes \((UIApplication.shared.delegate as! AppDelegate).memes.count)")
            
            self.resetViews()
            self.dismissView()
        }
        
        self.present(controller, animated: true, completion: nil)
    }

    @IBAction func dismissView() {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    func generateMemedImage() -> UIImage {
        toggleToolbarsVisibility(true)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        toggleToolbarsVisibility(false)
        return memedImage
    }
    
    func toggleToolbarsVisibility(_ isHidden: Bool) {
        bottomToolbar.isHidden = isHidden
        navigationBar.isHidden = isHidden
    }
    
    func resetViews() {
        self.imageView.image = nil
        self.topTextField.text = topText
        self.bottomTextField.text = bottomText
        shareButton.isEnabled = false
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            if textField.tag == 0 {
                textField.text = topText
            } else if textField.tag == 1 {
                textField.text = bottomText
            }
        }
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if (bottomTextField.isEditing) {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func initTextField(_ textField: UITextField) {
        textField.defaultTextAttributes = strokeTextAttributes
        textField.delegate = self
    }
}

