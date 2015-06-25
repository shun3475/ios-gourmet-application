//
//  PostViewController.swift
//  GourmetApp
//
//  Created by 岩瀬　駿 on 2015/06/24.
//  Copyright (c) 2015年 岩瀬　駿. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var placeHolder: UILabel!
    @IBOutlet weak var selectRestaurantButton: UIButton!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    var restaurant: Restaurant? = Restaurant()
    var image: UIImage? = nil
    let ipc = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        caption.delegate = self
        ipc.delegate = self
        ipc.allowsEditing = true
        
        partsLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - IBAction
    @IBAction func selectRestaurantButtonTapped(sender: UIButton) {
        performSegueWithIdentifier("modalSelectRestaurant", sender: nil)
    }
    
    @IBAction func onTapped(sender: AnyObject) {
        caption.resignFirstResponder()
    }
    
    @IBAction func addPhotoTapped(sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            alert.addAction(
                UIAlertAction(
                    title: "写真を撮る",
                    style: .Default,
                    handler: {
                        action in
                        self.ipc.sourceType = .Camera
                        self.presentViewController(self.ipc, animated: true, completion: nil)
                    }
                )
            )
        }
        
        // 「写真を選択」ボタンはいつでも使える
        alert.addAction(
            UIAlertAction(
                title: "写真を選択",
                style: .Default,
                handler: {
                    action in
                    self.ipc.sourceType = .PhotoLibrary
                    self.presentViewController(self.ipc, animated: true, completion: nil)
                }
            )
        )
        
        alert.addAction(
            UIAlertAction(
                title: "キャンセル",
                style: .Cancel,
                handler: {
                    action in
                }
            )
        )
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        ipc.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            // TODO: ここに画像を受け取った時の処理を書く.
            self.addPhotoButton.setBackgroundImage(image, forState: UIControlState.Normal)
            self.image = image
        }
        ipc.dismissViewControllerAnimated(true, completion: nil)
    }

    // MARK: - UITextViewDelegate
    //textviewがフォーカスされたら、Labelを非表示
    func textViewShouldBeginEditing(textView: UITextView) -> Bool
    {
        placeHolder.hidden = true
        return true
    }
    
    //textviewからフォーカスが外れて、TextViewが空だったらLabelを再び表示
    func textViewDidEndEditing(textView: UITextView) {
        if(caption.text.isEmpty){
            placeHolder.hidden = false
        }
    }
    
    // MARK: - UIPartsLayout
    func partsLayout(){
        caption.layer.borderWidth = 1
        caption.layer.borderColor = UIColor.blackColor().CGColor
        selectRestaurantButton.layer.borderWidth = 1
        selectRestaurantButton.layer.borderColor = UIColor.blackColor().CGColor
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.blueColor().CGColor
        submitButton.layer.cornerRadius = 10
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "modalSelectRestaurant" {
            if let nc = segue.destinationViewController as? SelectRestaurantViewController {
                nc.delegate = self
            }
        }
    }

}
