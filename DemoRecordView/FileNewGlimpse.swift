////
////  FileNewGlimpse.swift
////  DemoRecordView
////
////  Created by Tấn Tạ Đình on 10/6/20.
////  Copyright © 2020 com.ta.vn. All rights reserved.
////
//
////  Your converted code is limited to 1 KB.
////  Please Sign Up (Free!) to double this limit.
////
////  Converted to Swift 5.3 by Swiftify v5.3.19197 - https://swiftify.com/
////
////  GlimpseAssetWriter.m
////  Glimpse
////
////  Created by Wess Cope on 3/25/13.
////  Copyright (c) 2013 Wess Cope. All rights reserved.
////
//
//import AVFoundation
//import UIKit
//
//let GlimpseAssetWriterQueueName = "com.Glimpse.asset.writer.queue"
//
//class GlimpseAssetWriter: NSObject {
//    private var timeOfFirstFrame: CFAbsoluteTime?
//    private var timestamp: CFTimeInterval = 0
//    private var frameRate: Int32 = 0
//    private var frameCount: UInt64 = 0
//    private var queue: DispatchQueue?
//
//    private var frameBuffer: [AnyHashable]?
//    private var _writer: AVAssetWriter?
//    private var writer: AVAssetWriter? {
//        set {
//            self._writer = newValue
//        }
//
//        get {
//            if self._writer != nil {
//                return self._writer
//            }
//
//            self.fileOutputURL = createFileOutputURL()
//            guard let fileOutput = fileOutputURL else {
//                return nil
//            }
//
//            let error: Error? = nil
//            do {
//                self._writer = try AVAssetWriter(outputURL: fileOutput, fileType: .mov)
//            } catch {
//            }
//            assert(error == nil, error.debugDescription)
//
//            let settings = [
//                AVVideoCodecKey: AVVideoCodecType.h264,
//                AVVideoWidthKey: size.width,
//                AVVideoHeightKey: size.height
//                ] as [String : Any]
//
//            input = AVAssetWriterInput(mediaType: .video, outputSettings: settings)
//
//            let attributes = [
//                (kCVPixelBufferPixelFormatTypeKey as String): kCVPixelFormatType_32ARGB,
//                (kCVPixelBufferWidthKey as String): size.width,
//                (kCVPixelBufferHeightKey as String): size.height
//                ] as [String : Any]
//            adapter = AVAssetWriterInputPixelBufferAdaptor(assetWriterInput: input!, sourcePixelBufferAttributes: attributes)
//
//            self._writer?.add(input!)
//
//            input!.expectsMediaDataInRealTime = true
//
//            timeOfFirstFrame = CFAbsoluteTimeGetCurrent()
//
//            return self._writer
//
//        }
//
//    }
//    private var input: AVAssetWriterInput?
//    private var adapter: AVAssetWriterInputPixelBufferAdaptor?
//    private var displayLink: CADisplayLink?
//
//    var size = CGSize.zero
//    /// Frames per second for playback.
//    ///
//    var framesPerSecond = 0
//    /// Path of the file that the video is being written to.
//    ///
//    private(set) var fileOutputURL: URL?
//    /// When recording started.
//    ///
//    var startDate: Date?
//    /// When recording stopped.
//    ///
//    var endDate: Date?
//
//
//    override init() {
//        super.init()
//        self.size = UIScreen.main.bounds.size
//        framesPerSecond = 24
//        frameBuffer = []
//
//        frameRate = Int32(framesPerSecond)
//    }
//
//    func createFileOutputURL() -> URL? {
//        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).map(\.path)[0]
//        let timestamp = Date().timeIntervalSince1970
//        let filename = String(format: "glimpse_%08x.mov", Int(timestamp))
//        let path = "\(documentDirectory)/\(filename)"
//        let fileManager = FileManager.default
//
//        if fileManager.fileExists(atPath: path) {
//            do {
//                try fileManager.removeItem(atPath: path)
//            } catch {
//            }
//        }
//
//        print("OUTPUT: \(path)")
//        return URL(fileURLWithPath: path)
//    }
//
//    func pixelBuffer(for image: UIImage?) -> CVPixelBuffer? {
//        let cgImage = image?.cgImage
//
//        let options = [
//            kCVPixelBufferCGImageCompatibilityKey as String: NSNumber(value: true),
//            kCVPixelBufferCGBitmapContextCompatibilityKey as String: NSNumber(value: true)
//        ]
//        var buffer: CVPixelBuffer? = nil
//        CVPixelBufferCreate(kCFAllocatorDefault, cgImage?.width ?? 0, cgImage?.height ?? 0, kCVPixelFormatType_32ARGB, options as? CFDictionary, &buffer)
//
//        if let buffer = buffer {
//            CVPixelBufferLockBaseAddress(buffer, [])
//        }
//
//        var data: Void? = nil
//        if let buffer = buffer {
//            data = CVPixelBufferGetBaseAddress(buffer)
//        }
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
//        var context: CGContext? = nil
//        if let buffer = buffer {
//            context = CGContext(data: &data, width: cgImage?.width ?? 0, height: cgImage?.height ?? 0, bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(buffer), space: colorSpace, bitmapInfo: (CGBitmapInfo.alphaInfoMask.rawValue & CGImageAlphaInfo.noneSkipFirst.rawValue))
//        }
//        context?.draw(in: cgImage, image: CGRect(x: 0.0, y: 0.0, width: CGFloat(cgImage?.width ?? 0.0), height: CGFloat(cgImage?.height ?? 0.0)))
//        CGContextRelease(context!)
//
//        if let buffer = buffer {
//            CVPixelBufferUnlockBaseAddress(buffer, [])
//        }
//
//        return buffer
//    }
//
//
//   // func writer() -> AVAssetWriter? {
////        if writer {
////            return writer
////        }
////
////        fileOutputURL = createFileOutputURL()
////
////        var error: Error? = nil
////        do {
////            writer = try AVAssetWriter(outputURL: fileOutputURL, fileType: .mov)
////        } catch {
////        }
////        assert(error == nil, error.debugDescription)
////
////        let settings = [
////            AVVideoCodecKey: AVVideoCodecH264,
////            AVVideoWidthKey: NSNumber(value: size.width),
////            AVVideoHeightKey: NSNumber(value: size.height)
////        ]
////
////        input = AVAssetWriterInput(mediaType: .video, outputSettings: settings)
////
////        let attributes = [
////            kCVPixelBufferPixelFormatTypeKey as String: NSNumber(value: kCVPixelFormatType_32ARGB),
////            kCVPixelBufferWidthKey as String: NSNumber(value: size.width),
////            kCVPixelBufferHeightKey as String: NSNumber(value: size.height)
////        ]
////        adapter = AVAssetWriterInputPixelBufferAdaptor(assetWriterInput: input, sourcePixelBufferAttributes: attributes)
////
////        writer()?.add(input)
////
////        input.expectsMediaDataInRealTime = true
////
////        timeOfFirstFrame = CFAbsoluteTimeGetCurrent()
////
////        return writer
//    //}
//
//
//}
