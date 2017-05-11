//
//  ViewController.swift
//  ReadWriteFilePlist
//
//  Created by Kiet Nguyen on 5/11/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
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
    
    func loadData(){
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentDirectory = paths[0] as! String
        let path = documentDirectory.appending("myData.plist")
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: path){
            if let bundlePath = Bundle.main.path(forResource: "myData", ofType: "plist"){
                let result = NSMutableDictionary(contentsOfFile: bundlePath)
                print("Bundle file myData.plist is -> \(result?.description)")
                do{
                    try fileManager.copyItem(atPath: bundlePath, toPath: path)
                }catch{
                    print("copy failure.")
                }
            } else {
                print("file myData.plist not found.")
            }
        } else {
            print("file myData.plist alreadly exits at path.")
        }
        
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        print("load myData.plist is -> \(resultDictionary?.description)")
        
        let myDict = NSDictionary(contentsOfFile: path)
        if let dict = myDict{
            myItemValue = dict.object(forKey: myItemKey) as! String?
            txtValue.text = myItemValue
        } else {
            print("Load failure")
        }
    }
    
    func saveData(value: String){
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let docmentDictionary = paths.object(at: 0) as! String
        
        let path = docmentDictionary.appending("myData.plist")
        
        let dict: NSMutableDictionary = [:]
        
        dict.setObject(value, forKey: myItemKey as NSCopying)
        dict.write(toFile: path, atomically: false)
        print("Saved!!!")
    }
}

