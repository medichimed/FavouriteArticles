//
//  ArticlesViewModel.swift
//  Articles
//
//  Created by Оксана Котілевська on 14.11.2020.
//

import UIKit

protocol ArticlesViewModelDelegate: class {
    func updateTableView()
    func getChosenPage(for article: ArticleDetails)
    var parentVC: UIViewController { get }
}

class ArticlesViewModel: NSObject {
    
    //MARK: - Init
    required init(bind delegate: ArticlesViewModelDelegate?) {
        self.delegate = delegate
    }
    
    //MARK: - Properties
    weak var delegate: ArticlesViewModelDelegate?
    var dataSource: [ArticleDetails] = []
    
    //MARK: - Methods
    func getArticles(for requestType: ApiPurpose) {
        ApiService.shared.getArticles(for: requestType) { (result) in
            switch result {
            case .success(let articles):
                self.dataSource = articles.results
                self.delegate?.updateTableView()
            case .failure(let error):
                guard let parent = self.delegate?.parentVC as? ArticlesView else { return }
                CustomAlert.showAlertWith(message: error.localizedDescription, reason: .error, presenterVC: parent)
            }
        }
    }
}

//MARK: - UITableView protocols conformance
extension ArticlesViewModel: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: articleCellIdentifier, for: indexPath) as? ArticleCell else { return UITableViewCell() }
        cell.articleDetails = ArticleModelForCell(title: dataSource[indexPath.row].title, date: dataSource[indexPath.row].publishedDate, author: dataSource[indexPath.row].author)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.getChosenPage(for: dataSource[indexPath.row])
    }
    
}
