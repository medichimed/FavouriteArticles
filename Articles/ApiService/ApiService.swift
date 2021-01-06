//
//  ApiService.swift
//  Articles
//
//  Created by Оксана Котілевська on 14.11.2020.
//

import Foundation
import Alamofire
import AlamofireURLCache5

final class ApiService {
    
    static let shared: ApiService = {
        return ApiService()
    }()
    
    internal required init() {}

    func getArticles(for purpose: ApiPurpose, completionHandler: @escaping(Result<ArticleModel, ApiServiceError>) -> Void) {
        guard let url = URL(string: apiAddress + purpose.getAppropriateURLPart() + apiTimeInterval + apiKeyPart) else { return }

        AF.request(url).responseJSON(completionHandler: { (response) in
            guard let dataResponse = response.data else {
                completionHandler(.failure(.noData))
                return
            }

            do {
                let data = try JSONDecoder().decode(ArticleModel.self, from: dataResponse)
                completionHandler(.success(data))
            } catch {
                completionHandler(.failure(.parsingIssue))
            }
        }).cache(maxAge: 10)
            
    }

}

enum ApiPurpose: Int {
    case topEmailed, topShared, topViewed
    
    func getAppropriateURLPart() -> String {
        switch  self {
        case .topEmailed:
            return "/emailed"
        case .topShared:
            return "/shared"
        case .topViewed:
            return "/viewed"
        }
    }
}

enum ApiServiceError: Error {
    case noData, parsingIssue
    
    var description: String {
        switch self {
        case .noData: return "No data provided"
        case .parsingIssue: return "Parsing issue occured"
        }
    }
}
