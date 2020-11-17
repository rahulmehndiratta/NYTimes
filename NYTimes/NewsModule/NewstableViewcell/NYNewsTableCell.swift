//
//  NYNewsTableCell.swift
//  NYTimes
//
//  Created by Apple on 17/11/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class NYNewsTableCell: UITableViewCell {

    static var ID = "NYNewsTableCell"
    
    @IBOutlet weak var timeStemp: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var byLineLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageItem: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populateData(news: NYNewsListModel?) {
        timeStemp.text = news?.publishedDate ?? "N/A"
        titleLabel.text = news?.title ?? "N/A"
        byLineLabel.text = news?.byLine ?? "N/A"
        typeLabel.text = news?.section ?? "N/A"
        if news?.media?.mediaType == .image, let mediaUrl = URL(string: news?.media?.mediaMetadata?.first?.url ?? "") {
            //TODO: set Media File i have some doubts in it thats why i havnt written it
        }
        
    }
    
}
