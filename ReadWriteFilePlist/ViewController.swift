//
//  ViewController.swift
//  ReadWriteFilePlist
//
//  Created by Thanh Duy on 5/11/17.
//  Copyright © 2017 Thanh Duy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let myItemKey = "myItem"
    var myItemValue: String?
    @IBOutlet weak var txtValue: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSave(_ sender: Any) {
        self.saveData(value: txtValue.text!)
    }
    
    func loadData() {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentDirectory = paths[0] as! String
        let path = documentDirectory.appending("myData.plist");
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: path) {
            if let bundlePath = Bundle.main.path(forResource: "myData", ofType: "plist") {
                let result = NSMutableDictionary(contentsOfFile: bundlePath)
                print("copy sucess")
                do {
                    try fileManager.copyItem(atPath: bundlePath, toPath: path)
                    
                }
                catch {
                    
                }

            }
        }
        let resultDirectory = NSMutableDictionary(contentsOfFile: path)
        let myDic = NSDictionary(contentsOfFile: path)
        if let dict = myDic {
            myItemValue = dict.object(forKey: myItemKey) as! String?
            txtValue.text = myItemValue
        }
    }
    
    func saveData(value: String) {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentDirectory = paths.object(at: 0) as! String
        let path = documentDirectory.appending("myData.plist");
        
        let dict: NSMutableDictionary = [:]
        
        dict.setObject(value, forKey: myItemKey as NSCopying)
        dict.write(toFile: path, atomically: false)
    }
    
}

