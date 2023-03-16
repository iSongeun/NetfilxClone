//
//  DateHeaderView.swift
//  NetfilxClone
//
//  Created by 이송은 on 2023/03/15.
//

import UIKit

class DateHeaderView : UITableViewHeaderFooterView {
    
    var dateAttributeString : NSMutableAttributedString? {
        didSet {
            dateLabel.attributedText = dateAttributeString
        }
    }
    
    private var dateLabel : UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .white
        lbl.backgroundColor = .black
        lbl.numberOfLines = 0
        
        return lbl
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(dateLabel)
        dateLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 50).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 5).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
