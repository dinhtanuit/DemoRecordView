//
//  ViewController.swift
//  DemoRecordView
//
//  Created by Tấn Tạ Đình on 10/4/20.
//  Copyright © 2020 com.ta.vn. All rights reserved.
//

import UIKit

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
    }

    @IBAction func actionRecord(_ sender: Any) {
        self.isStartRecord = !self.isStartRecord
        if self.isStartRecord {
            self.glimpse.startRecording(self.recordView) { (url) in
                //
            }
            
//            self.recorder.start()
        } else {
//            self.recorder.stop()
        }
        
    }
    
}

