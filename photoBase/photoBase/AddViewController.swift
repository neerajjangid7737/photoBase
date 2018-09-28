//
//  AddViewController.swift
//  photoBase
//
//  Created by neeraj on 08/09/18.
//  Copyright © 2018 neeraj. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        self.resignFirstResponder()
    }
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var imageTextField: UIImageView!
    
    var userData : UserData? = nil
    
    let pc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if userData == nil {
            navigationItem.title = "Add New Data"
        }else {
            navigationItem.title = userData?.titletext
            
            titleTextField.text = userData?.titletext
            descriptionTextField.text = userData?.desctext
            imageTextField.image = UIImage(data: (userData?.image)! as Data)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func camera(_ sender: Any) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.camera
        pickerController.allowsEditing = true
        
        self.present(pickerController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let imagee = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageTextField.image = imagee
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func library(_ sender: Any) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        pickerController.allowsEditing = true
        self.present(pickerController, animated: true, completion: nil)
        
    }
   
    @IBAction func save(_ sender: Any) {
        
        if userData == nil {
            let entityDescription = NSEntityDescription.entity(forEntityName: "UserData", in: pc);
            let item = UserData(entity: entityDescription!, insertInto: pc)
            item.titletext = titleTextField.text
            item.desctext = descriptionTextField.text
            item.image = UIImagePNGRepresentation(imageTextField.image!) as NSData?
            
        }else{
            userData?.titletext = titleTextField.text
            userData?.desctext = descriptionTextField.text
            userData?.image = UIImagePNGRepresentation(imageTextField.image!) as NSData?
        }
        do {
            try pc.save()
        }catch{
            print("Database insertion problem ->  ", error)
            return
        }
        navigationController!.popViewController(animated: true)
    }
    
    

}
