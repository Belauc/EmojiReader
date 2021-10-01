//
//  NewEmojiTableViewController.swift
//  EmojiReader
//
//  Created by sergey on 04.08.2021.
//

import UIKit

class NewEmojiTableViewController: UITableViewController {
    
    var baseEmoji = Emoji(emoji: "🥰", name: "Love", description: "Lets love", isFavourit: true)

    @IBOutlet weak var emojiTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSaveButtonState()
        updateUI()
    }

    private func updateSaveButtonState () {
        let emoji = emojiTF.text ?? ""
        let name = nameTF.text ?? ""
        let description = descriptionTF.text ?? ""
        
        saveButton.isEnabled = !emoji.isEmpty && !name.isEmpty && !description.isEmpty
    }
    private func updateUI() {
        emojiTF.text = baseEmoji.emoji
        nameTF.text = baseEmoji.name
        descriptionTF.text = baseEmoji.description
        
    }
    @IBAction func saveButtonPress(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func textChange(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegeu" else { return }
        let emoji = emojiTF.text ?? baseEmoji.emoji
        let name = nameTF.text ?? baseEmoji.name
        let description = descriptionTF.text ?? baseEmoji.description
        
        self.baseEmoji = Emoji(emoji: emoji, name: name, description: description, isFavourit: false)
        
        
    }

    
}
