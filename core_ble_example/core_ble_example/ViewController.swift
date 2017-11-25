//
//  ViewController.swift
//  core_ble_example
//
//  Created by Batuhan Duzgun on 22/11/2017.
//  Copyright © 2017 Batuhan Duzgun. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    var manager:CBCentralManager!
    var peripheral:CBPeripheral!
    var selectedCharacteristic:CBCharacteristic!
    
    @IBOutlet var writeBtn: UIButton!
    @IBOutlet var messageTxt: UITextField!
    
    let beanName = "echo"
    let serviceUUID = CBUUID(string:"ec00")
    let characteristicUUID = CBUUID(string:"ec0e")
    

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            self.manager.scanForPeripherals(withServices: nil, options: nil)
            debugPrint("Scanning peripherals...")
        case .poweredOff:
            debugPrint("Bluetooth on this device is currently powered off.")
        case .unsupported:
            debugPrint("This device does not support Bluetooth Low Energy.")
        case .unauthorized:
            debugPrint("This app is not authorized to use Bluetooth Low Energy.")
        case .resetting:
            debugPrint("The BLE Manager is resetting; a state update is pending.")
        case .unknown:
            debugPrint("The state of the BLE Manager is unknown.")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        // Device
        let device = (advertisementData as NSDictionary).object(forKey: CBAdvertisementDataLocalNameKey) as? NSString
        debugPrint("peripheral: \(String(describing: device))")

        if device?.contains(self.beanName) == true {
            self.manager.stopScan()
            self.peripheral = peripheral
            self.peripheral.delegate = self
            self.manager.connect(peripheral, options: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        
        peripheral.discoverServices(nil)
        debugPrint("Getting services ...")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        
        for service in peripheral.services! {
            
            let currentService = service as CBService
            
            if currentService.uuid == self.serviceUUID {
                peripheral.discoverCharacteristics(nil, for: currentService)
                debugPrint("Using scratch.")
            }
            debugPrint("Service: ", service.uuid)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        debugPrint("Enabling ...")
    
        for characteristic in service.characteristics! {
            
            let currentCharacteristic = characteristic as CBCharacteristic
            
            if currentCharacteristic.uuid == self.characteristicUUID {
                self.selectedCharacteristic = currentCharacteristic
                self.peripheral.setNotifyValue(true, for: currentCharacteristic)
                self.peripheral.readValue(for: characteristic)
                debugPrint("Set to notify: ", currentCharacteristic.uuid)
            }
            debugPrint("Characteristic: ", currentCharacteristic.uuid)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {

        if characteristic.uuid == self.characteristicUUID {
            
            let content = String(data: characteristic.value!, encoding: String.Encoding.utf8)
            debugPrint(content!)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?)
    {
        if error != nil {
            print("error: \(String(describing: error))")
            return
        }
        
        print("Succeeded!")
    }
    
    @IBAction func writeMessageClick(_ sender: Any) {
        
        let messageData = self.messageTxt.text?.data(using: .utf8)
        
        self.peripheral.writeValue(messageData as! Data, for: self.selectedCharacteristic, type: CBCharacteristicWriteType.withResponse)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.manager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

