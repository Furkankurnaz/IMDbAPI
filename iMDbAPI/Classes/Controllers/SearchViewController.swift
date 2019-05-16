//
//  SearchViewController.swift
//  iMDbAPI
//
//  Created by Furkan Kurnaz on 14.05.2019.
//  Copyright © 2019 Furkan Kurnaz. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var filterView: RoundedView!
    @IBOutlet weak var typePickButton: UIButton!
    @IBOutlet weak var yearPickButton: UIButton!
    
    @IBOutlet weak var pickerContentView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    // MARK: - Properties
    
    private var searchViewModel = SearchViewModel()
    private var types: [String] = []
    private var years: [String] = []
    
    private var isFilterViewShowing: Bool = false
    private var currentPickerViewType: PickerViewType = .type
    
    private var selectedType: String = ""
    private var selectedYear: String = ""
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    // MARK: - Helpers
    
    private func configureView() {
        self.pickerContentView.transform = CGAffineTransform(translationX: 0, y: self.view.bounds.height)
        hideFilterView()
        hidePickerView()
        getPickerViewDatas()
    }
    
    private func getPickerViewDatas() {
        types = searchViewModel.getTypes()
        years = searchViewModel.getYears()
    }
    
    private func showFilterView() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut,
                       animations: {
                        self.filterView.transform = .identity
        },
                       completion: nil)
    }
    
    private func hideFilterView() {
        UIView.animate(withDuration: 0.5) {
            self.filterView.transform = CGAffineTransform(translationX: 0, y: self.view.bounds.height)
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Error", message: "The name field cannot be blank.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showPickerView() {
        self.pickerContentView.transform = .identity
        pickerView.reloadAllComponents()
    }
    
    private func hidePickerView() {
        self.pickerContentView.transform = CGAffineTransform(translationX: 0, y: self.view.bounds.height)
    }
    
    // MARK: - Actions
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        isFilterViewShowing = false
        hideFilterView()
        searchTextField.resignFirstResponder()
        
        if searchTextField.text?.count == 0 {
            showAlert()
        } else {
            searchViewModel.getMedia(title: searchTextField.text!, type: selectedType, year: selectedYear)
        }
    }

    @IBAction func filtersButtonTapped(_ sender: UIButton) {
        searchTextField.resignFirstResponder()
        
        isFilterViewShowing = !isFilterViewShowing
        
        if isFilterViewShowing {
            showFilterView()
        } else {
            hideFilterView()
        }
    }
    
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        searchTextField.resignFirstResponder()
    }
    
    @IBAction func pickButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            currentPickerViewType = .type
        case 1:
            currentPickerViewType = .year
        default: break
        }
        
        UIView.animate(withDuration: 0.3) {
            self.showPickerView()
        }
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            typePickButton.setTitle("Pick...", for: .normal)
        case 1:
            yearPickButton.setTitle("Pick...", for: .normal)
        default: break
        }
    }
    
    @IBAction func applyButtonTapped(_ sender: UIButton) {
        hideFilterView()
        isFilterViewShowing = false
        
        if let typeText = typePickButton.titleLabel?.text {
            if typeText != "Pick..." {
                selectedType = typeText
            } else {
                selectedType = ""
            }
        }
        
        if let yearText = yearPickButton.titleLabel?.text {
            if yearText != "Pick..." {
                selectedYear = yearText
            } else {
                selectedYear = ""
            }
        }
    }
    
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.hidePickerView()
        }
        
        let index = pickerView.selectedRow(inComponent: 0)
        switch currentPickerViewType {
        case .type:
            let title = types[index]
            typePickButton.setTitle(title, for: .normal)
        case .year:
            let title = years[index]
            yearPickButton.setTitle(title, for: .normal)
        }
    }
    
}

// MARK: - UITextFieldDelegate

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        hideFilterView()
        isFilterViewShowing = false
    }
}

// MARK: - UIPickerViewDataSource

extension SearchViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch currentPickerViewType {
        case .type:
            return types.count
        case .year:
            return years.count
        }
    }
}

// MARK: - UIPickerViewDelegate

extension SearchViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch currentPickerViewType {
        case .type:
            return types[row]
        case .year:
            return years[row]
        }
    }
}
