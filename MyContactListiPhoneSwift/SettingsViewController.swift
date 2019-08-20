//
//  SettingsViewController.swift
//  MyContactListiPhoneSwift
//
//  Created by Emmanuel Muse on 4/3/19.
//  Copyright © 2019 Emmanuel Muse. All rights reserved.
//

import UIKit

class SettingsViewController:  UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

  
    @IBOutlet weak var swAscending: UISwitch!
    
    @IBOutlet weak var pckSortField: UIPickerView!
    
    let sortOrderItems: Array<String> = ["Contact Name", "City", "Birthday", "Test"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        pckSortField.dataSource = self
        pckSortField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let settings = UserDefaults.standard
        swAscending.setOn(settings.bool(forKey: Constants.kSortDirectionAscending), animated: true)
        let sortField = settings.string(forKey: Constants.kSortField)
        var i = 0
        for field in sortOrderItems{
            if field == sortField {
                pckSortField.selectRow(i, inComponent: 0, animated: false)
            }
            i += 1
        }
        pckSortField.reloadComponent(0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    @IBAction func sortDirectionChanged(_ sender: Any) {
        
        let settings = UserDefaults.standard
        settings.set(swAscending.isOn, forKey: Constants.kSortDirectionAscending)
        settings.synchronize()
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sortOrderItems.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sortOrderItems[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let sortField = sortOrderItems[row]
        let settings = UserDefaults.standard
        settings.set(sortField, forKey: Constants.kSortField)
        settings.synchronize()
        
    }

    
}
