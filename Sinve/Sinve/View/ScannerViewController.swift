//
//  ScannerViewController.swift
//  Sinve
//
//  Created by Morgana Galamba on 26/09/22.
//

import UIKit
import AVFoundation


class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var avCaptureSession: AVCaptureSession!
    var avPreviewLayer: AVCaptureVideoPreviewLayer!
    var products: [String] = []
    
    
    public let addquantidy: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = UIButton.Configuration.filled()
        button.setTitle("Ver carrinho", for: .normal)
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action:#selector(finishScan), for: .touchUpInside)
        return button
    }()

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
        view.addSubview(addquantidy)
        setupConstraints()
        avCaptureSession.startRunning()
        
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            addquantidy.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addquantidy.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
        ])
    }
    
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
        products.append(code)
        avCaptureSession.startRunning()
    }
    
    func filterAmountProd() -> Dictionary<String, Int> {
        let mappedItems = products.map { ($0, 1) }
        let counts = Dictionary(mappedItems, uniquingKeysWith: +)
        return counts
    }
    
    @objc func finishScan() {
        
        let sell = filterAmountProd()
        let view = FinalSaleTableViewController(productsCount: sell)
        self.navigationController?.pushViewController(view, animated: true)
    }


}
