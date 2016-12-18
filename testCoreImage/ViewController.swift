//
//  ViewController.swift
//  testCoreImage
//
//  Created by rong on 2016/12/18.
//  Copyright © 2016年 rong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var originalImage: UIImage = {
        let path = NSBundle.mainBundle().pathForResource("test", ofType: "jpg")!
        let image = UIImage(contentsOfFile: path)
        return image!
    }()
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        GaussianBlur();
    }

    // 褐色滤镜，复古风格
    func coreImageTest1() {

        let path = NSBundle.mainBundle().pathForResource("test", ofType: "jpg")!

        let context = CIContext()
        guard let filter = CIFilter(name: "CISepiaTone") else {
            return
        }
        filter.setValue(1.0, forKey: kCIInputIntensityKey)

        let image = CIImage(contentsOfURL: NSURL(fileURLWithPath: path))
        filter.setValue(image, forKey: kCIInputImageKey)
        let result = filter.outputImage!
        let cgImage = context.createCGImage(result, fromRect: result.extent)

        imageView.image = UIImage(CGImage: cgImage!)
    }

    // 高斯模糊
    func GaussianBlur() {
        let path = NSBundle.mainBundle().pathForResource("test", ofType: "jpg")!

        let context = CIContext()
        guard let filter = CIFilter(name: "CIGaussianBlur") else {
            return
        }
        print("\(filter.attributes)")
        filter.setValue(5.0, forKey: "inputRadius")

        let image = CIImage(contentsOfURL: NSURL(fileURLWithPath: path))
        filter.setValue(image, forKey: kCIInputImageKey)
        let result = filter.outputImage!
        let cgImage = context.createCGImage(result, fromRect: result.extent)

        imageView.image = UIImage(CGImage: cgImage!)
    }


    // 自动改善图像
    @IBAction func autoAjustmentImage() {

        let inputImage = CIImage(image: originalImage)!
        var resultImage: CIImage?
        let filters = inputImage.autoAdjustmentFilters() as [CIFilter]

        for filter: CIFilter in filters {
            filter.setValue(inputImage, forKey: kCIInputImageKey)
            resultImage = filter.outputImage!
        }
        if let result = resultImage {

            imageView.image = UIImage(CIImage: result)
        }
    }

    @IBAction func showOriginalImage() {
        imageView.image = originalImage
    }
}

