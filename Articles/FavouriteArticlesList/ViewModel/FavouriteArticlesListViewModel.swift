//
//  FavouriteArticlesListViewModel.swift
//  Articles
//
//  Created by Оксана Котілевська on 14.11.2020.
//

import UIKit
import CoreData

class FavouriteArticlesListViewModel: NSObject {
    
    //MARK: - Init
    required init(bind delegate: ArticlesViewModelDelegate?) {
        self.delegate = delegate
    }
    
    //MARK: - Properties
    weak var delegate: ArticlesViewModelDelegate?
    var dataSource: [SavedArticle] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: - Methods
    func retrieveArticlesFromDataBase() {
        do {
            self.dataSource = try context.fetch(SavedArticle.fetchRequest())
            self.delegate?.updateTableView()
        } catch {
            guard let parent = self.delegate?.parentVC as? FavouriteArticlesListView else { return }
            CustomAlert.showAlertWith(message: error.localizedDescription, reason: .error, presenterVC: parent)
        }
    }
    
}

//MARK: - UITableView protocols conformance
extension FavouriteArticlesListViewModel: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: favouriteCellIdentifier, for: indexPath) as? FavouriteArticleCell else { return UITableViewCell() }
        guard let title = dataSource[indexPath.row].title,
              let date = dataSource[indexPath.row].publishedDate,
              let author = dataSource[indexPath.row].author else { return UITableViewCell() }
        cell.articleDetails = ArticleModelForCell(title: title, date: date, author: author)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = dataSource[indexPath.row].url,
           let publishedDate = dataSource[indexPath.row].publishedDate,
           let title = dataSource[indexPath.row].title,
           let author = dataSource[indexPath.row].author {
            let article = ArticleDetails(url: url, id: Int(dataSource[indexPath.row].id), publishedDate: publishedDate, title: title, author: author)
            delegate?.getChosenPage(for: article)
        }
    }
    
}
