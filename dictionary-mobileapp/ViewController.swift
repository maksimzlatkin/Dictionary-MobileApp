//
//  ViewController.swift
//  dictionary-mobileapp
//
//  Created by Maksim Zlatkin on 11/9/22.
//

import UIKit
import SwiftUI

enum WordType : String {
    case noun, adjective, verb
    var id : Self { self }
}

class ViewController: UIViewController {
    
    @State private var selectedWordType: WordType = .noun
    let data = ["Noun", "Adjective", "Verb"]
    var definitions : [String]?
    
    var word : String = ""
    var type : String = "noun"
    
    @IBOutlet var picker: UIPickerView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var dictionaryLabel : UILabel!
    @IBOutlet weak var searchButton: UIButton!
    
    var labels : [UILabel] = []
    
    let screenWidth : Int = Int(UIScreen.main.bounds.width)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        picker.dataSource = self
        picker.delegate = self
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if let input : String = textField.text{
            print(input)
            
            resetWord(word: input, type: "noun")
        }else{
            //no string
        }
    }
    
    func resetWord(word : String, type : String){
        for label in labels {
            label.removeFromSuperview()
        }
        labels = []
        
        let url = "http://localhost:3000/dictionary/\(word)/\(type)"
        let dotSymbol = "•"
        definitions = getData(from: url)
        
        if let result = definitions {
            for (index, definition) in result.enumerated() {
                print("\(index) : \(definition)")
                labels.append(UILabel(frame: CGRect(x: 10, y: 250 + (index * 50), width: screenWidth, height: 60)))
                //label.center = CGPoint(x: 160, y: 285)
                labels[index].textAlignment = .left
                labels[index].text = "\(dotSymbol) \(definition)"
                labels[index].lineBreakMode = .byWordWrapping
                labels[index].numberOfLines = 3
                self.view.addSubview(labels[index])
            }
            
        } else {
            print("Unable to unwrap definitions")
        }
    }

}

extension ViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
}
extension ViewController : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
}
