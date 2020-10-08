//
//  ViewController.swift
//  DemoRecordView
//
//  Created by Tấn Tạ Đình on 10/4/20.
//  Copyright © 2020 com.ta.vn. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {
    @IBOutlet weak var recordView: UIView!
    @IBOutlet weak var btnRecord: UIButton!
    var glimpse = Glimpse.init()
    var isStartRecord: Bool = false
    let recorder = Recorder()
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.recorder.view = self.recordView
//        self.recorder.start()
//        self.isStartRecord = true
        
        // Do any additional setup after loading the view.
        self.btnRecord.setTitle("Start Record", for: .normal)
        
    }

    @IBAction func actionRecord(_ sender: Any) {
        self.isStartRecord = !self.isStartRecord
        
        if self.isStartRecord {
            self.btnRecord.setTitle("Recording", for: .normal)

            glimpse.startRecording(self.recordView, onCompletion: { [weak self] videoUrl in
                
                guard let strongSelf = self else {
                    return
                }
                
                if let url = videoUrl {
                    strongSelf.saveVideoToAlbum(url) { (error) in
                        if error == nil {
                            DispatchQueue.main.async {
                                let alertController = UIAlertController(title: "Your video was successfully saved", message: nil, preferredStyle: .alert)
                                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                                alertController.addAction(defaultAction)
                                strongSelf.present(alertController, animated: true, completion: nil)
                            }
                        }
                    }
                }
            })
        } else {
            self.btnRecord.setTitle("Start Record", for: .normal)

            glimpse.stop()
        }
    }
    
    func requestAuthorization(completion: @escaping ()->Void) {
            if PHPhotoLibrary.authorizationStatus() == .notDetermined {
                PHPhotoLibrary.requestAuthorization { (status) in
                    DispatchQueue.main.async {
                        completion()
                    }
                }
            } else if PHPhotoLibrary.authorizationStatus() == .authorized{
                completion()
            }
        }



    func saveVideoToAlbum(_ outputURL: URL, _ completion: ((Error?) -> Void)?) {
            requestAuthorization {
                PHPhotoLibrary.shared().performChanges({
                    let request = PHAssetCreationRequest.forAsset()
                    request.addResource(with: .video, fileURL: outputURL, options: nil)
                }) { (result, error) in
                    DispatchQueue.main.async {
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            print("Saved successfully")
                        }
                        completion?(error)
                    }
                }
            }
        }
    
}

