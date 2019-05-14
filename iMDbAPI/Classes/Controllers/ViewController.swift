//
//  ViewController.swift
//  iMDbAPI
//
//  Created by Furkan Kurnaz on 14.05.2019.
//  Copyright © 2019 Furkan Kurnaz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Outlets

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var filterView: RoundedView!
    
    //MARK: - Properties
    
    var isFilterViewShowing: Bool = false
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    //MARK: - Helpers
    
    func configureView() {
        self.filterView.transform = CGAffineTransform(translationX: 0, y: self.view.bounds.height)
    }
    
    func showFilterView() {
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
    
    func hideFilterView() {
        UIView.animate(withDuration: 0.5) {
            self.filterView.transform = CGAffineTransform(translationX: 0, y: self.view.bounds.height)
        }
    }
    
    //MARK: - Actions
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        hideFilterView()
        searchTextField.resignFirstResponder()
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
    
    
}

//MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        hideFilterView()
        isFilterViewShowing = false
    }
}

