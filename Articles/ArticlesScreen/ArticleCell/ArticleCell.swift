//
//  ArticleCell.swift
//  Articles
//
//  Created by Оксана Котілевська on 14.11.2020.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    //MARK: - Properties
    var articleDetails: ArticleModelForCell! {
        didSet {
            updateCellContent()
        }
    }
    
    //MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        dateLabel.text = nil
        authorLabel.text = nil
    }
    
    //MARK: - Methods
    private func updateCellContent() {
        titleLabel.text = articleDetails.title
        dateLabel.text = getFormattedDate(from: articleDetails.date) 
        authorLabel.text = articleDetails.author
        
        updateFonts()
    }
    
    private func getFormattedDate(from date: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let newDate = formatter.date(from: date)
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: newDate!)
    }
    
    private func updateFonts() {
        titleLabel.font = UIFont(name: fontName, size: 17)
        titleLabel.textColor = UIColor(red: 11/255, green: 145/255, blue: 140/255, alpha: 1.0)
        dateLabel.font = UIFont(name: fontName, size: 12)
        dateLabel.textColor = .gray
        authorLabel.font = UIFont(name: fontName, size: 12)
        authorLabel.textColor = .darkGray
    }

}

struct ArticleModelForCell {
    let title: String
    let date: String
    let author: String
}
