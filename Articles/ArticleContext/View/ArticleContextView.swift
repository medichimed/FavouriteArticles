//
//  ArticleContextView.swift
//  Articles
//
//  Created by Оксана Котілевська on 14.11.2020.
//

import UIKit
import WebKit

class ArticleContextView: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var webView: WKWebView!
    
    //MARK: - Properties
    var chosenArticle: ArticleDetails!
    var viewModel: ArticleContextViewModel = {
        return ArticleContextViewModel()
    }()
    var isFavouriteArticle: Bool?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard  let url = URL(string: chosenArticle.url) else { return }
        webView.load(URLRequest(url: url))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        guard let _ = isFavouriteArticle  else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(setArticleToChosenList))
            return
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    //MARK: - Methods
    @objc func setArticleToChosenList() {
        viewModel.saveToDataBase(article: chosenArticle) { (result) in
            switch result {
            case .success(let message):
                CustomAlert.showAlertWith(message: message, reason: .success, presenterVC: self)
            case .failure(let error):
                CustomAlert.showAlertWith(message: error.getErrorComment(), reason: .error, presenterVC: self)
            }
        }
    }
    
    //MARK: - Actions
    
}

extension ArticleContextView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
}
