//
//  ViewController.swift
//  DatePicker_pr
//
//  Created by 江啟綸 on 2022/1/24.
//

import UIKit

var interval: Double = 0.0
var retireDate: Date?


class ViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var TimeView: UIView! {
        didSet{
            
            let gradient = CAGradientLayer()

            gradient.frame = TimeView.bounds
            gradient.colors = [UIColor.systemPink.cgColor, UIColor.purple.cgColor]

            TimeView.layer.insertSublayer(gradient, at: 0)
            TimeView.layer.cornerRadius = 20
            

//            TimeView.layer.borderWidth = 3
//            TimeView.layer.borderColor = UIColor.white.cgColor
            
            
        }
    }
    @IBOutlet weak var chColor: UIButton! {
        didSet {
            let gradient = CAGradientLayer()

            gradient.frame = chColor.bounds
            gradient.colors = [UIColor.blue.cgColor, UIColor.purple.cgColor]
            chColor.layer.insertSublayer(gradient, at: 0)
            chColor.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var dateTFFF: UITextField! {
        didSet{
            dateTFFF.layer.borderWidth = 3
            dateTFFF.layer.borderColor = UIColor.white.cgColor
            dateTFFF.layer.cornerRadius = 10
            dateTFFF.layer.backgroundColor = UIColor.white.cgColor
        }
    }
    @IBOutlet weak var dateMth: UITextField! {
        didSet{
            dateMth.layer.borderWidth = 3
            dateMth.layer.borderColor = UIColor.white.cgColor
            dateMth.layer.cornerRadius = 10
            dateMth.layer.backgroundColor = UIColor.white.cgColor
        }
    }
    @IBOutlet weak var dateHrs: UITextField! {
        didSet{
            dateHrs.layer.borderWidth = 3
            dateHrs.layer.borderColor = UIColor.white.cgColor
            dateHrs.layer.cornerRadius = 10
            dateHrs.layer.backgroundColor = UIColor.white.cgColor
        }
    }
    @IBOutlet weak var oneText: UILabel!
    @IBOutlet weak var twoText: UILabel!
    @IBOutlet weak var threeText: UILabel!
    
    
    
    
    var timer: Timer?
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dateTFFF.delegate = self
        dateTFFF.endEditing(true)
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(_:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.locale = Locale(identifier: "zh_Hant_TW")
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.minimumDate = Date()
        let maxDate = Calendar.current.date(byAdding: .year, value: 1, to: Date())
        datePicker.maximumDate = maxDate
        
        dateTFFF.inputView = datePicker
        dateMth.inputView = datePicker
        dateHrs.inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: 300, height: 40))
        //        toolBar.tintColor = UIColor.white
        toolBar.backgroundColor = #colorLiteral(red: 0.1725490196, green: 0.1725490196, blue: 0.1725490196, alpha: 1)
        
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let titleText = UIBarButtonItem(title: "選擇結束日期", style: .plain, target: self, action: nil);
        titleText.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: UIControl.State.normal)
        toolBar.setItems([spaceButton,titleText, spaceButton], animated: false)
        
        dateTFFF.inputAccessoryView = toolBar
        dateMth.inputAccessoryView = toolBar
        dateHrs.inputAccessoryView = toolBar
        
    
        
    }
    
    
    @objc func dateChange(_ sender: UIDatePicker) {
        
        retireDate = sender.date
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
            
             //            let now = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy MM dd HH"
            if retireDate != nil {
                interval = retireDate!.timeIntervalSinceNow
            }
            let secTo = Int(interval) % 60
            let minTo = Int(interval / 60) % 60
            let hoursTo = Int(interval / 3600) % 24
            let daysTo = Int(interval / 86400) % 30
            let mthTo = Int(interval / (60 * 60 * 24 * 30))
            
            
            
            if mthTo != 0 {
                self.dateTFFF.text = "\(mthTo)"
                self.dateMth.text = "\(daysTo)"
                self.dateHrs.text = "\(hoursTo)"
                
                self.oneText.text = "個月"
                self.twoText.text = "天"
                self.threeText.text = "小時"
            }else if daysTo != 0 {
                self.dateTFFF.text = "\(daysTo)"
                self.dateMth.text = "\(hoursTo)"
                self.dateHrs.text = "\(minTo)"
                
                self.oneText.text = "天"
                self.twoText.text = "小時"
                self.threeText.text = "分鐘"
            }
            else {
                self.dateTFFF.text = "\(hoursTo)"
                self.dateMth.text = "\(minTo)"
                self.dateHrs.text = "\(secTo)"
                
                self.oneText.text = "小時"
                self.twoText.text = "分鐘"
                self.threeText.text = "秒"
            }
            
        }
        
    }
    @IBAction func chColorPressed(_ sender: UIButton) {
        
//        self.TimeView.layer.backgroundColor = UIColor.black.cgColor
        let gradient = CAGradientLayer()

        gradient.frame = self.TimeView.bounds
        gradient.colors = [UIColor.blue.cgColor, UIColor.purple.cgColor]

        self.TimeView.layer.insertSublayer(gradient, at: 1)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if timer != nil {
            timer?.invalidate()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return textField != self.dateTFFF
    }
    
    
    
    
    
}

