//
//  UIImage_CVPixelBuffer.swift
//  601wardrobe
//
//  Created by Tommy Zheng on 11/12/17.
//  Copyright © 2017 Tommy Zheng. All rights reserved.
//

import UIKit

extension UIImage {
//    func toCVPixelBuffer() -> CVPixelBuffer? {
//        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
//        var pixelBuffer : CVPixelBuffer?
//        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(self.size.width), Int(self.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
//        guard (status == kCVReturnSuccess) else {
//            return nil
//        }
//
//        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
//        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
//
//        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
//        let context = CGContext(data: pixelData, width: Int(self.size.width), height: Int(self.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
//
//        context?.translateBy(x: 0, y: self.size.height)
//        context?.scaleBy(x: 1.0, y: -1.0)
//
//        UIGraphicsPushContext(context!)
//        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
//        UIGraphicsPopContext()
//        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
//
//        return pixelBuffer
//    }
    ////////////////////////////////////////////
    public func pixelBufferGray(width: Int, height: Int) -> CVPixelBuffer? {
        
        var pixelBuffer : CVPixelBuffer?
        let attributes = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue]
        
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(width), Int(height), kCVPixelFormatType_OneComponent8, attributes as CFDictionary, &pixelBuffer)
        
        guard status == kCVReturnSuccess, let imageBuffer = pixelBuffer else {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(imageBuffer, CVPixelBufferLockFlags(rawValue: 0))
        
        let imageData =  CVPixelBufferGetBaseAddress(imageBuffer)
        
        guard let context = CGContext(data: imageData, width: Int(width), height:Int(height),
                                      bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(imageBuffer),
                                      space: CGColorSpaceCreateDeviceGray(),
                                      bitmapInfo: CGImageAlphaInfo.none.rawValue) else {
                                        return nil
        }
        
        context.translateBy(x: 0, y: CGFloat(height))
        context.scaleBy(x: 1, y: -1)
        
        UIGraphicsPushContext(context)
        self.draw(in: CGRect(x:0, y:0, width: width, height: height) )
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(imageBuffer, CVPixelBufferLockFlags(rawValue: 0))
        
        return imageBuffer
        
    }
}
