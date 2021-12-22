//
//  ViewController.swift
//  BooksKeeper
//
//  Created by Viktoriya on 17.12.2021.
//

import UIKit

// MARK: - BookPageView
protocol BookPageView: BaseView {
    
// MARK: - Show
    func show(data: BookPageData)
}

class BookPageViewController: BaseViewController {
    
    private var presenter: BookPagePresenter?
    var configurator: BookPageConfigurator?
    
    private var initialExperationDate: Date?
    private var initialBookName: String?
    private var hasSafeArea = false
    
// MARK: - Outlets
    @IBOutlet private weak var nameBookTextField: UITextField!
    @IBOutlet private weak var bookDatePicker: UIDatePicker!
    @IBOutlet private weak var bookPageActionButton: UIButton!
    @IBOutlet private weak var navItem: UINavigationItem!
    @IBOutlet private weak var nameTextField: UITextField!
    
    @IBOutlet private weak var bookDatpickerHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var bookPageActionButtonBottomConstraint: NSLayoutConstraint!
    
// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameTextField.delegate = self
        
        self.nameBookTextField.addTarget(self,
                                         action: #selector(textFieldDidChange(_:)),
                                         for: UIControl.Event.editingChanged)
        
        self.bookDatePicker.addTarget(self,
                                      action: #selector(datePickerChanged(_:)),
                                      for: .valueChanged)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil);
        
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.first
            if let bottomInset = window?.safeAreaInsets.bottom,
               bottomInset > 0 {
                self.hasSafeArea = true
            } else {
                self.hasSafeArea = false
            }
        }
                
        self.configureTextField()
        self.configureBookDatePicker()
        self.configureBookPageActionButton()

        self.presenter?.viewDidLoad()
    }
    
    func configureTextField() {
        self.nameTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Book name", comment: ""))
            self.nameTextField.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            self.nameTextField.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
            self.nameTextField.layer.shadowOpacity = 0.25
            self.nameTextField.layer.masksToBounds = false
    }
    
    func configureBookDatePicker() {
        self.bookDatpickerHeightConstraint.constant = UIScreen.main.bounds.height <= 667 ? 175 : 215
    }
    
    func configureBookPageActionButton() {
        self.bookPageActionButtonBottomConstraint.constant = 25
        self.bookPageActionButton.layer.shadowColor = UIColor.black.cgColor
        self.bookPageActionButton.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        self.bookPageActionButton.layer.shadowOpacity = 0.25
        self.bookPageActionButton.layer.masksToBounds = false
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let isEnabled = self.isNameChanged()
        self.changeBookPageActionButtonEnabled(isEnabled)
    }
    
    @objc func datePickerChanged(_ picker: UIDatePicker) {
        let isEnabled = self.isDateChanged() && !(self.nameBookTextField.text?.isEmpty ?? true)
        self.changeBookPageActionButtonEnabled(isEnabled)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? .zero
        let additionalHeight: CGFloat = self.hasSafeArea ? 0 : 25
                self.bookPageActionButtonBottomConstraint.constant = keyboardHeight + additionalHeight
        UIView.animate(withDuration: 0.3) {
                  self.view.superview?.layoutIfNeeded()
              }
    }

    @objc func keyboardWillHide(_ sender: NSNotification) {
        self.bookPageActionButtonBottomConstraint.constant = 25
        UIView.animate(withDuration: 0.3) {
                  self.view.superview?.layoutIfNeeded()
              }
    }
  
    @IBAction func onBookPageActionButtonClicked(_ sender: Any) {
        if let writedName = self.nameBookTextField.text {
            self.presenter?.onBookPageActionButtonClicked(pickedDate: self.bookDatePicker.date,
                                                  writedName: writedName)
        }
    }
}

extension BookPageViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.nameTextField.resignFirstResponder()
           return true
    }
}

// MARK: - Setup
extension BookPageViewController {

    func setup(presenter: BookPagePresenter?,
               configurator: BookPageConfigurator?) {
        self.presenter = presenter
        self.configurator = configurator
    }
}

extension BookPageViewController: BookPageView {
    
    func show(data: BookPageData) {
        self.configureBookDatePicker(data.book?.experationDate)
        self.configureNameBookTextField(data.book?.name)
        self.configureButton(data.isEditMode)
        self.navItem.title = data.isEditMode ? NSLocalizedString("Edit info", comment: "")  : NSLocalizedString("Add new book", comment: "")
    }
    
    private func configureButton(_ isEditMode: Bool) {
        let titleLabel = isEditMode ? NSLocalizedString("Edit", comment: "") : NSLocalizedString("Add", comment: "")
        self.bookPageActionButton.setTitle(titleLabel, for: .normal)
        
        let isEnabled = self.isDateChanged() && !(self.nameBookTextField.text?.isEmpty ?? true)
        self.changeBookPageActionButtonEnabled(isEnabled)
    }
    
    private func changeBookPageActionButtonEnabled (_ isEnabled: Bool) {
        self.bookPageActionButton.isEnabled = isEnabled
        self.bookPageActionButton.backgroundColor = isEnabled ? UIColor(named: "buttonBlue") : UIColor(named: "buttonGray")
    }
    
    private func configureBookDatePicker(_ experationDate: Date?) {
        self.initialExperationDate = experationDate
        let currentDate = Date()
        let maxDate = Calendar.current.date(byAdding: .month, value: 3, to: Date()) ?? Date()
        
        self.bookDatePicker.minimumDate = currentDate
        self.bookDatePicker.maximumDate = maxDate
        if let experationDate = experationDate,
           experationDate >= currentDate,
           experationDate <= maxDate {
            self.bookDatePicker.date = experationDate
        }
    }
    
    private func configureNameBookTextField(_ bookName: String?) {
        self.initialBookName = bookName
        self.nameBookTextField.text = bookName
    }
    
    private func isDateChanged() -> Bool {
        if (self.initialExperationDate?.stripTime() ?? Date()) < Date().stripTime() ||
            self.initialExperationDate?.stripTime() != self.bookDatePicker.date.stripTime() {
            return true
        }
        return false
    }
    
    private func isNameChanged() -> Bool {
        if (self.nameBookTextField.text != self.initialBookName && !(self.nameBookTextField.text?.isEmpty ?? true)) {
            return true
        }
        return false
    }
    
}


