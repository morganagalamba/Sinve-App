//
//  ScannerViewController.swift
//  Sinve
//
//  Created by Morgana Galamba on 26/09/22.
//

import UIKit
import AVFoundation

@objc protocol ScannerViewDelegate: class {
    @objc func didFindScannedText(text: String)
}

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var avCaptureSession: AVCaptureSession!
    var avPreviewLayer: AVCaptureVideoPreviewLayer!
    
    @objc public weak var delegate: ScannerViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        avCaptureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            print("Your device is not aplicablw for video processing")
            return
        }
        let avVideoInput: AVCaptureDeviceInput
        
        do {
            avVideoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            print("Your device can not give video input!")
            return
        }
        
        if (self.avCaptureSession.canAddInput(avVideoInput)) {
            self.avCaptureSession.addInput(avVideoInput)
        } else {
            print("Your device can not add input in capture session")
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (self.avCaptureSession.canAddOutput(metadataOutput)) {
            self.avCaptureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417, .qr]
        } else {
            self.failed()
            return
        }
        
        avPreviewLayer = AVCaptureVideoPreviewLayer(session: avCaptureSession)
        avPreviewLayer.frame = view.layer.bounds
        avPreviewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(avPreviewLayer)
        
        avCaptureSession.startRunning()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func failed() {
        let ac = UIAlertController(title: "Scanner not supported", message: "Please use a device with a camera. Because this device does not support scanning a code", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        avCaptureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (avCaptureSession?.isRunning == false) {
            avCaptureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (avCaptureSession?.isRunning == true) {
            avCaptureSession.stopRunning()
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

}

extension ScannerViewController {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        avCaptureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        } else {
            print("Not able to read the code! Please try again or keep your device on Bar code or Scanner Code!")
        }
        
        dismiss(animated: true)
    }
    
    func found(code: String) {
        print(code)
        
        delegate?.didFindScannedText(text: code)
    }
}
