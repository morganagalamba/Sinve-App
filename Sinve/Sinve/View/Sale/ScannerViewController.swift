//
//  ScannerViewController.swift
//  Sinve
//
//  Created by Morgana Galamba on 26/09/22.
//

import UIKit
import AVFoundation
import Foundation

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var avCaptureSession: AVCaptureSession!
    var avPreviewLayer: AVCaptureVideoPreviewLayer!
    var productsCode: [String] = []
    var produtos: [Produto] = []
    
    public let addquantidy: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = UIButton.Configuration.filled()
        button.setTitle("Ver carrinho", for: .normal)
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action:#selector(finishScan), for: .touchUpInside)
        return button
    }()
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "TimberWolf")
        view.layer.cornerRadius = 10
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public var feedback: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        view.addSubview(cellView)
        view.addSubview(feedback)
        setupConstraints()
        DispatchQueue.main.async {
            self.avCaptureSession.startRunning()
        }
    }
    
    private func setupConstraints(){
        
        NSLayoutConstraint.activate([
            cellView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cellView.bottomAnchor.constraint(equalTo: addquantidy.topAnchor, constant: -25),
            cellView.heightAnchor.constraint(equalToConstant: 45),
            cellView.widthAnchor.constraint(equalToConstant: 370)
        ])
        
        NSLayoutConstraint.activate([
            feedback.centerXAnchor.constraint(equalTo: cellView.centerXAnchor),
            feedback.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            feedback.widthAnchor.constraint(equalToConstant: 350)
        ])
        
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
        getInfoProd(barCode: code)
        self.avCaptureSession.startRunning()
    }
    
    func filterAmountProd() -> Dictionary<String, Int> {
        let mappedItems = productsCode.map { ($0, 1) }
        let counts = Dictionary(mappedItems, uniquingKeysWith: +)
        return counts
    }
    
    func getInfoProd(barCode: String ){
        guard let url = URL(string: "https://sinve-back-production.up.railway.app/produto/" + barCode) else{
                return
            }
        
        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            
            let decoder = JSONDecoder()
            if let data = data {
                do {
                    let produto = try decoder.decode(Produto.self, from: data)
                    print(produto)
                    print(data)
                    let queue = DispatchQueue(label: "update")
                    if produto.nome != nil {
                        self.produtos.append(produto)
                        queue.async {
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.cellView.isHidden = true
                                self.feedback.isHidden = true

                            }

                            DispatchQueue.main.async {
                                self.feedback.text = (produto.nome ?? "")
                                self.cellView.isHidden = false
                                self.feedback.isHidden = false
                            }
                        }
        

                    } else {
                        queue.async {
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.cellView.isHidden = true
                                self.feedback.isHidden = true
                                
                            }
                            DispatchQueue.main.async {
                                self.feedback.text = "Produto não encontrado!"
                                self.cellView.isHidden = false
                                self.feedback.isHidden = false
                            }
                        }
                    }
                    
                } catch {
                    print(error)
                }
            }
        }

        task.resume()
    }
    
    @objc func finishScan() {
        let correctArrayProd = produtos.removingDuplicates()
        self.productsCode = []
        for produto in produtos {
            if let name = produto.nome{
                self.productsCode.append(name)
            }
        }
        let sell = filterAmountProd()
        let view = FinalSaleTableViewController(productsCount: sell, produtos: correctArrayProd )
        self.navigationController?.pushViewController(view, animated: true)
    }


}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
