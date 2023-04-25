//
//  BooksListPresenter.swift
//  BooksKeeper
//
//  Created by Viktoriya on 17.12.2021.
//

import Foundation

// MARK: - BooksListPresenter
protocol BooksListPresenter: BasePresenter {

// MARK: - Actions
    func onAddButtonClicked()
    func onSortingButtonClicked()
    func onBookClicked(_ bookId: String?)
    func deleteBook(_ bookId: String?)
}

// MARK: - BooksListPresenterImpl
class BooksListPresenterImpl: BasePresenterImpl {

    private weak var view: BooksListViewControllerProtocol?
    private var router: BooksListRouter?
    private var interactors: BooksListInteractors

// MARK: - Data
    private var data = BooksListData()
    
// MARK: - Init
    required init(view: BooksListViewControllerProtocol,
                  router: BooksListRouter,
                  interactors: BooksListInteractors) {
        self.view = view
        self.router = router
        self.interactors = interactors
    }

// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.loadBooks()
    }
}

// MARK: - BooksListPresenter
extension BooksListPresenterImpl: BooksListPresenter {
 
    func onSortingButtonClicked() {
        self.router?.showAlert(completion: { sortingType in
            switch sortingType {
            case .sortByName:
                self.data.books.sort(by: {$0.name < $1.name})
            case .sortByDate:
                self.data.books.sort(by: {$0.experationDate < $1.experationDate})
            }
            self.view?.show(data: self.data)
            self.saveBooks()
        })
    }
    func onBookClicked(_ bookId: String?) {
        guard let book = self.data.books.first(where: {$0.id == bookId}) else { return }
        
        self.router?.showBookPage(isEditMode: true,
                                  book: book,
                                  completion: { book in
                                    if let row = self.data.books.firstIndex(where: {$0.id == book.id}) {
                                        self.data.books[row] = book
                                        self.view?.show(data: self.data)
                                        self.saveBooks()
                                    }
                                  })
    }
    
    func onAddButtonClicked() {
        self.router?.showBookPage(isEditMode: false,
                                  book: nil,
                                  completion: { book in
                                    self.data.books.append(book)
                                    self.view?.show(data: self.data)
                                    self.saveBooks()
                                  })
    }
    
    func deleteBook(_ bookId: String?) {
        if let row = self.data.books.firstIndex(where: { $0.id == bookId }) {
            self.data.books.remove(at: row)
            self.view?.show(data: self.data)
            self.saveBooks()
        }
    }
    
    private func loadBooks() {
        self.interactors.getBooksListInteractor.execute { books in
            self.data.books = books
            self.view?.show(data: self.data)
        }
    }
    
    private func saveBooks() {
        self.interactors.saveBooksListInteractor.execute(books: self.data.books) {}
    }
}
