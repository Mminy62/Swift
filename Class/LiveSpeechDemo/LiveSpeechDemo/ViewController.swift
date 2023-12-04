//
//  ViewController.swift
//  LiveSpeechDemo
//
//  Created by 이민영 on 2023/12/04.
//

//import UIKit
//import Speech
//
//class ViewController: UIViewController {
//
//    @IBOutlet var transcribeButton: UIButton!
//    @IBOutlet var stopButton: UIButton!
//    @IBOutlet var myTextView: UITextView!
//    
//    // 4가지를 세팅해주고 시작
//    private let speechRecognizer = SFSpeechRecognizer(locale:  Locale(identifier: "ko-KR"))
//    private var speechRecognitionRequest: SFSpeechAudioBufferRecognitionRequest? // 버퍼 인식
//    private var speechRecognitionTask: SFSpeechRecognitionTask? // 인식된 task
//    private var audioEngine = AVAudioEngine() // audio 객체
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        authorizeSR()
//    }
//
//    
//    func authorizeSR() {
//          SFSpeechRecognizer.requestAuthorization { authStatus in
//
//              OperationQueue.main.addOperation {
//                  switch authStatus {
//                  case .authorized:
//                      self.transcribeButton.isEnabled = true
//
//                  case .denied:
//                      self.transcribeButton.isEnabled = false
//                      self.transcribeButton.setTitle("Speech recognition access denied by user", for: .disabled)
//
//                  case .restricted:
//                      self.transcribeButton.isEnabled = false
//                      self.transcribeButton.setTitle(
//                          "Speech recognition restricted on device", for: .disabled)
//
//                  case .notDetermined:
//                      self.transcribeButton.isEnabled = false
//                      self.transcribeButton.setTitle(
//                          "Speech recognition not authorized", for: .disabled)
//                  @unknown default:
//                      print("Unknown state")
//                  }
//              }
//          }
//      }
//    
//    @IBAction func startTranscribing(_ sender: Any) {
//        
//        transcribeButton.isEnabled = false
//        stopButton.isEnabled = true
//        
//        do{
//            try startSession()
//        } catch { }
//    }
//    
//    func startSession() throws {
//        if let recognitionTask = speechRecognitionTask {
//            recognitionTask.cancel()
//            self.speechRecognitionTask = nil
//        }
//
//        let audioSession = AVAudioSession.sharedInstance()
//        try audioSession.setCategory(.record, mode: .default)
//
//        speechRecognitionRequest = SFSpeechAudioBufferRecognitionRequest()
//
//        guard let recognitionRequest = speechRecognitionRequest else {
//            fatalError("SFSpeechAudioBufferRecognitionRequest create failed.")
//        }
//
//        let inputNode = audioEngine.inputNode
//        recognitionRequest.shouldReportPartialResults = true
//
//        speechRecognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
//
//            var finished = false
//
//            if let result = result {
//                self.myTextView.text = result.bestTranscription.formattedString
//                finished = result.isFinal
//            }
//            
//            if error != nil || finished {
//                self.audioEngine.stop()
//                inputNode.removeTap(onBus: 0)
//                
//                self.speechRecognitionRequest = nil
//                self.speechRecognitionTask = nil
//                
//                self.transcribeButton.isEnabled = true
//            }
//        }
//        
//        let recordingFormat = inputNode.outputFormat(forBus: 0)
//        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) {
//            (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
//            self.speechRecognitionRequest?.append(buffer)
//        }
//
//        audioEngine.prepare()
//        try audioEngine.start()
//    }
//    
//    @IBAction func stopTranscribing(_ sender: Any) {
//        if audioEngine.isRunning {
//            audioEngine.stop()
//            speechRecognitionRequest?.endAudio()
//
//            transcribeButton.isEnabled = true
//            stopButton.isEnabled = false
//        }
//    }
//}


//  ViewController.swift
//  LiveSpeechDemo
//

import UIKit
import Speech

class ViewController: UIViewController {

    @IBOutlet var transcribeButton: UIButton!
    @IBOutlet var stopButton: UIButton!
    @IBOutlet var myTextView: UITextView!
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))
    
    private var speechRecognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var speechRecognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authorizeSR()
    }
    
    func authorizeSR() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    self.transcribeButton.isEnabled = true
                    
                case .denied:
                    self.transcribeButton.isEnabled = false
                    self.transcribeButton.setTitle("Speech recognition access denied by user", for: .disabled)
                    
                case .restricted:
                    self.transcribeButton.isEnabled = false
                    self.transcribeButton.setTitle(
                        "Speech recognition restricted on device", for: .disabled)
                    
                case .notDetermined:
                    self.transcribeButton.isEnabled = false
                    self.transcribeButton.setTitle(
                        "Speech recognition not authorized", for: .disabled)
                @unknown default:
                    print("Unknown state")
                }
            }
        }
    }

    @IBAction func startTranscribing(_ sender: Any) {
        transcribeButton.isEnabled = false
        stopButton.isEnabled = true
        
        do {
            try startSession()
        } catch { }
    }
    
    func startSession() throws {
        
        if let recognitionTask = speechRecognitionTask {
            recognitionTask.cancel()
            self.speechRecognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .default)
        
        speechRecognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let recognitionRequest = speechRecognitionRequest else {
            fatalError("SFSpeechAudioBufferRecognitionRequest create failed.")
        }
        
        let inputNode = audioEngine.inputNode
        recognitionRequest.shouldReportPartialResults = true
        
        speechRecognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
            
            var finished = false
            
            if let result = result {
                self.myTextView.text = result.bestTranscription.formattedString
                finished = result.isFinal
            }
            
            if error != nil || finished {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.speechRecognitionRequest = nil
                self.speechRecognitionTask = nil
                
                self.transcribeButton.isEnabled = true
            }
        }
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) {
            (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.speechRecognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
    }
    
    @IBAction func stopTranscribing(_ sender: Any) {
        if audioEngine.isRunning {
            audioEngine.stop()
            speechRecognitionRequest?.endAudio()
            
            transcribeButton.isEnabled = true
            stopButton.isEnabled = false
        }
    }
    
}



