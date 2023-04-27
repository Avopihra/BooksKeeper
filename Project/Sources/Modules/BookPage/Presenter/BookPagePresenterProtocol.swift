//
//  BookPagePresenter.swift
//  BooksKeeper
//
//  Created by Viktoriya on 19.12.2021.
//

import Foundation

// MARK: - BookPagePresenter
protocol BookPagePresenterProtocol: BasePresenterProtocol {
    
    func setCompletionValue(isEditMode: Bool,
                            book: Book?,
                            completion: ((Book) -> Void)?)
    
    func onBookPageActionButtonClicked(pickedDate: Date,
                               writedName: String)
}

// MARK: - BookPagePresenterImpl
class BookPagePresenterImpl: BasePresenterImpl {

    private weak var view: BookPageViewProtocol?
    private var router: BookPageRouter?
    private var valueCompletion: ((Book) -> Void)?

// MARK: - Data
    private var data = BookPageData()
    
// MARK: - Init
    required init(view: BookPageViewProtocol,
                  router: BookPageRouter) {
        self.view = view
        self.router = router
    }

// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view?.show(data: self.data)
    }
}

// MARK: - BookPagePresenter
extension BookPagePresenterImpl: BookPagePresenterProtocol {
    
    func setCompletionValue(isEditMode: Bool,
                            book: Book?,
                            completion: ((Book) -> Void)?) {
        self.data.isEditMode = isEditMode
        self.data.book = book
        self.valueCompletion = completion
    }

    func onBookPageActionButtonClicked(pickedDate: Date, writedName: String) {
        if self.data.isEditMode {
            self.editBook(pickedDate, writedName)
        } else {
            self.createNewBook(pickedDate, writedName)
        }
        self.view?.navigationController?.popViewController(animated: true)
    }
    
    private func editBook(_ pickedDate: Date, _ writedName: String) {
        self.data.book?.setexperationDate(experationDate: pickedDate)
        self.data.book?.setName(name: writedName)
        
        if let book = self.data.book {
            self.valueCompletion?(book)
        }
    }
    
    private func createNewBook(_ pickedDate: Date, _ writedName: String) {
        if !writedName.isEmpty,
           writedName != data.book?.name,
           let book = Book(id: UUID().uuidString,
                           name: writedName,
                           experationDate: pickedDate) {
            self.valueCompletion?(book)
        }
    }
}
