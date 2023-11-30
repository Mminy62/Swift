//
//  ViewController.swift
//  CameroDemo
//
//  Created by 이민영 on 2023/11/24.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet var imageView: UIImageView!


    // 뒷 부분에서 필요할 Boolean 속성 선언
    var newMeida: Bool?
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
        }
    @IBAction func useCamera(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.mediaTypes = [UTType.image.identifier]
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
            
            newMeida = true
        }
        
    }
    
//    // 오류가 발생하면 경고 상자를 통해 사용자에게 보고
//    @objc func image(image: UIImage, )
//
   
    @IBAction func useCameraRoll(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.savedPhotosAlbum) {
                    
                    let imagePicker = UIImagePickerController()

                    imagePicker.delegate = self
                    imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                    imagePicker.mediaTypes = [UTType.image.identifier]
                    imagePicker.allowsEditing = false

                    self.present(imagePicker, animated: true, completion: nil)
                    
                    newMeida = false
                }
        }
    func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            // UIImagePickerController.InfoKey.mediaType
            let mediaType = info[.mediaType] as! NSString
            
            self.dismiss(animated: true, completion: nil)
            
            if mediaType.isEqual(to: UTType.image.identifier) {
                let image = info[.originalImage] as! UIImage
                
                imageView.image = image
                
                if (newMeida == true) {
                    UIImageWriteToSavedPhotosAlbum(image, self, #selector(ViewController.image(image:didFinishSavingWithError:contextInfo:)), nil)
                }
                
            }
        }
        
        // 오류가 발생하면 경고 상자를 통해 사용자에게 보고
        @objc func image(image: UIImage,
                         didFinishSavingWithError error: NSErrorPointer,
                         contextInfo: UnsafeRawPointer) {
            if error != nil {
                print("error")
            }

        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.dismiss(animated: true, completion: nil)
        }

}