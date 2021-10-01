//
//  EmojiTableViewCell.swift
//  EmojiReader
//
//  Created by sergey on 04.07.2021.
//

import UIKit

class EmojiTableViewCell: UITableViewCell {

    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descripLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func set(obj: Emoji) {
        self.descripLabel.text = obj.description
        self.emojiLabel.text = obj.emoji
        self.nameLabel.text = obj.name
    }

}
