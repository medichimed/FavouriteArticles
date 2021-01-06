//
//  ArticleContextViewModel.swift
//  Articles
//
//  Created by Оксана Котілевська on 15.11.2020.
//

import UIKit
import CoreData

class ArticleContextViewModel: NSObject {
    
    //MARK: - Properties
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: - Methods
    func saveToDataBase(article: ArticleDetails, completionHadler: @escaping(Result<String, SavingArticleError>) -> Void) {
        
        
        let request:NSFetchRequest<SavedArticle> = SavedArticle.fetchRequest()
        
        let predicate = NSPredicate(format: "id = %@", "\(article.id)")
        request.predicate = predicate
        
        do {
            let checkResult = try context.fetch(request)
            if checkResult.isEmpty {
                do {
                    let newSavedArticle = SavedArticle(context: context)
                    newSavedArticle.author = article.author
                    newSavedArticle.url = article.url
                    newSavedArticle.publishedDate = article.publishedDate
                    newSavedArticle.title = article.title
                    newSavedArticle.id = Int64(article.id)
                    
                    try context.save()
                    completionHadler(.success("Article saved!"))
                } catch {
                    completionHadler(.failure(.savingError))
                }
            } else {
                completionHadler(.failure(.alreadySaved))
            }
        } catch {
            completionHadler(.failure(.fetchingError))
        }
    }
}

enum SavingArticleError: Error {
    case alreadySaved, savingError, fetchingError
    
    func getErrorComment() -> String {
        switch self{
        case .alreadySaved: return "You have already saved this article"
        case .savingError: return "Error during saving data"
        case .fetchingError: return "Fetching error"
        }
    }
}
