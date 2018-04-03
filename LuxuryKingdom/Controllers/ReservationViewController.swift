//
//  ReservationViewController.swift
//  LuxuryKingdom
//
//  Created by Atif Imran on 13/03/18.
//  Copyright © 2018 Aimran. All rights reserved.
//

import UIKit

class ReservationViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var bookingField: UITextField!
    @IBOutlet weak var expenseField: UITextField!
    @IBOutlet weak var confirmBookingBtn: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var successView: UIView!
    
    var datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let customButton = UIBarButtonItem(image: UIImage(named: "BackIcon"), style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem  = customButton
        
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.init(named: "LuxuryGold") ?? UIColor.white,
             NSAttributedStringKey.font: UIFont(name: "PingFang HK", size: 14)!]
        self.navigationItem.title = "RESERVATION"

        nameField.underline()
        phoneField.underline()
        emailField.underline()
        bookingField.underline()
        expenseField.underline()
        
        datePicker.minimumDate = Date()
        datePicker.datePickerMode = .date
        datePicker.setValue(UIColor(named: "ContrastWhite"), forKeyPath: "textColor")
        datePicker.backgroundColor = UIColor(named: "BlackBackground")
        datePicker.addTarget(self, action: #selector(self.updateDateField(_:)), for: UIControlEvents.valueChanged)
        bookingField.inputView = datePicker
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)//remove transparancy from nav bar
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //Transparent Nav Bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    @objc func updateDateField(_ sender: Any){
        let d = DateFormatter();d.dateFormat = "dd-MM-yyyy"
        let picker:UIDatePicker! = bookingField.inputView as! UIDatePicker
        bookingField.text = d.string(from: picker.date)
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confirmBooking(_ sender: UIButton) {
        successView.isHidden = false
        self.navigationController?.navigationBar.isHidden = true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
