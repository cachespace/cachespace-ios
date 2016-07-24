//
//  ViewController.swift
//  Cachespace
//
//  Created by Eude Kinsley Lesperance on 7/24/16.
//  Copyright © 2016 Cachespace. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bitcoinAddress: UITextField!
    @IBOutlet weak var amountToBeSpent: UITextField!
    @IBOutlet weak var generateButtonAction: UIButton!
    @IBOutlet weak var imgQRCode: UIImageView!
    
    
    var qrcodeImage: CIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func generateButtonPressed(sender: AnyObject) {
        if qrcodeImage == nil {
            if bitcoinAddress.text == "" || amountToBeSpent.text == "" {
                return
            }
            
            let str = "Address:\(bitcoinAddress.text!) Amount:\(amountToBeSpent.text!)"
            
            let data = str.dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)
            let filter = CIFilter(name: "CIQRCodeGenerator")
            filter?.setValue(data, forKey: "inputMessage")
            filter?.setValue("Q", forKey: "inputCorrectionLevel")
            
            qrcodeImage = filter?.outputImage
            
            bitcoinAddress.resignFirstResponder()
            amountToBeSpent.resignFirstResponder()
            
            generateButtonAction.setTitle("Clear", forState: .Normal)
            
           displayQRCodeImage()
            
        } else {
            imgQRCode.image = nil
            qrcodeImage = nil
            generateButtonAction.setTitle("Generate", forState: .Normal)
        }
        
        bitcoinAddress.enabled = !bitcoinAddress.enabled
        amountToBeSpent.enabled = !amountToBeSpent.enabled
    }
    
    func displayQRCodeImage() {
        let scaleX = imgQRCode.frame.size.width / qrcodeImage.extent.size.width
        let scaleY = imgQRCode.frame.size.height / qrcodeImage.extent.size.height
        
        let transformedImage = qrcodeImage.imageByApplyingTransform(CGAffineTransformMakeScale(scaleX, scaleY))
        
        imgQRCode.image = UIImage(CIImage: transformedImage)
    }
    

}

