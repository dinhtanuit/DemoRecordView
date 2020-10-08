//
//  NewRecorder.swift
//  DemoRecordView
//
//  Created by Tấn Tạ Đình on 10/6/20.
//  Copyright © 2020 com.ta.vn. All rights reserved.
//

//import UIKit
//
//class NewRecorder: NSObject {
//
//}


//  ScreenRecorderService.swift
//  FlappyBirdScream
//
//  Created by Mikita Manko on 4/25/17.
//  Copyright © 2017 Mikita Manko. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class NewRecorder: NSObject {

}

//class ScreenRecorderService {
//    private let fpsToSkip : Int = 4
//    private var frameNumber : Int = 0
//
//    var view : UIView?
//    private var frames = [UIImage]()
//    private var recording = false
//
//
//
//    func start(view: UIView) {
//        self.view = view
//        recording = true
//        //frames.removeAll()
//    }
//
//    func getFramesToSkip() -> Int {
//        return fpsToSkip
//    }
//
//    func getFames() -> [UIImage] {
//        return frames
//    }
//
//    /**
//     * This method triggers every frame (60 fps).
//     * It's too overhelming from performance stand point to make 60 screen per second
//     *   (todo: investigate use separate thread for that)
//     * Let's make 60/5 screen per second.
//     */
//    func update() {
//        if recording, let view = self.view {
//            if frameNumber == 0 {
//                frameNumber = fpsToSkip
//                frames.append(ImageUtils.captureScreen(view: view))
//            } else if frameNumber > 0 {
//                frameNumber = frameNumber - 1
//            }
//        }
//    }
//
//    func stop() {
//        recording = false
//        if IS_DEBUG {
//            print("ScreenRecorderService stopped with number of frames: " + String(frames.count))
//        }
//    }
//
//
//    func generateVideoUrl(complete: @escaping(_:URL)->()) {
//        let settings = ImagesToVideoUtils.videoSettings(codec: AVVideoCodecJPEG /*AVVideoCodecH264*/, width: (frames[0].cgImage?.width)!, height: (frames[0].cgImage?.height)!)
//        let movieMaker = ImagesToVideoUtils(videoSettings: settings)
//
//        //Override fps
//        movieMaker.frameTime = CMTimeMake(value: 1, timescale: Int32(60 / (1 + self.fpsToSkip)))
//        movieMaker.createMovieFrom(images: frames) { (fileURL:URL) in
//            complete(fileURL)
//        }
//
//    }
//
//    func saveAsVideo() {
//        generateVideoUrl(complete: { (fileURL:URL) in
//
//            VideoService.saveVideo(url: fileURL, complete: {saved in
//                print("animation video save complete")
//                print(saved)
//            })
//            //let video = AVAsset(url: fileURL)
//            //let playerItem = AVPlayerItem(asset: video)
//            //let player = CXEPlayer()
//            //player.setPlayerItem(playerItem: playerItem)
//            //self.playerView.player = player
//        })
//    }
//}

//class ScreenRecorderService {
//    private let fpsToSkip : Int = 4
//    private var frameNumber : Int = 0
//    
//    var view : UIView?
//    private var frames = [UIImage]()
//    private var recording = false
//    
//    
//    
//    func start(view: UIView) {
//        self.view = view
//        recording = true
//        //frames.removeAll()
//    }
//    
//    func getFramesToSkip() -> Int {
//        return fpsToSkip
//    }
//    
//    func getFames() -> [UIImage] {
//        return frames
//    }
//    
//    /**
//     * This method triggers every frame (60 fps).
//     * It's too overhelming from performance stand point to make 60 screen per second
//     *   (todo: investigate use separate thread for that)
//     * Let's make 60/5 screen per second.
//     */
//    func update() {
//        if recording, let view = self.view {
//            if frameNumber == 0 {
//                frameNumber = fpsToSkip
//                frames.append(ImageUtils.captureScreen(view: view))
//            } else if frameNumber > 0 {
//                frameNumber = frameNumber - 1
//            }
//        }
//    }
//    
//    func stop() {
//        recording = false
//        print("ScreenRecorderService stopped with number of frames: " + String(frames.count))
//    }
//    
//    
//    func generateVideoUrl(complete: @escaping(_:URL)->()) {
//        let settings = ImagesToVideoUtils.videoSettings(codec: AVVideoCodecJPEG /*AVVideoCodecH264*/, width: (frames[0].cgImage?.width)!, height: (frames[0].cgImage?.height)!)
//        let movieMaker = ImagesToVideoUtils(videoSettings: settings)
//        
//        //Override fps
//        movieMaker.frameTime = CMTimeMake(value: 1, timescale: Int32(60 / (1 + self.fpsToSkip)))
//        movieMaker.createMovieFrom(images: frames) { (fileURL:URL) in
//            complete(fileURL)
//        }
//    
//    }
//    
//    func saveAsVideo() {
//        generateVideoUrl(complete: { (fileURL:URL) in
//            
//            VideoService.saveVideo(url: fileURL, complete: {saved in
//                print("animation video save complete")
//                print(saved)
//            })
//        })
//    }
//    
//    static func saveVideo(url: URL, complete:@escaping(_:Bool)->()) {
//        VideoService.checkPhotoLibraryPermissions(result: {granted in
//            if granted {
//                let library = PHPhotoLibrary.shared()
//                library.performChanges({
//                    PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url)
//                }, completionHandler: {success, error in
//                    if success {
//                        if IS_DEBUG { print("VideoService: Video file have been saved successfully") }
//                    } else {
//                        print("\n\nVideoService:  Error: failed to save video file.")
//                        print(error ?? "unknown")
//                    }
//                    complete(success)
//                })
//            } else {
//                complete(false)
//            }
//        })
//    }
//}
