//
//  CreatorsTableViewCell.swift
//  MarvelHeroes
//
//  Created by ket on 3/7/19.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

class CreatorsTableViewCell: UITableViewCell {

    @IBOutlet weak var creatorNameLabel: UILabel!
    @IBOutlet weak var creatorImageLabel: UIImageView!
    @IBOutlet weak var creatorWriteFirstComicsLabel: UILabel!
    @IBOutlet var creatorDetailsLabels: [UILabel]!
    @IBOutlet weak var creatorComicsLabel: UILabel!
    @IBOutlet weak var creatorSeriesLabel: UILabel!
    @IBOutlet weak var creatorStoriesLabel: UILabel!
    @IBOutlet weak var creatorEventsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // set corner radius to details labels
        for label in creatorDetailsLabels {
            label.layer.cornerRadius = 5
            label.layer.masksToBounds = true
        }
    }

    // find matches in string by the RegEx pattern
    func matches(for regex: String, in text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let nsString = text as NSString
            let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
            return results.map { nsString.substring(with: $0.range) }
        } catch let error {
            print(error)
            return []
        }
    }
    
    // find the earliest date when creator write first comics
    func findEarliestDate(from results: Creator) -> String {
        var dateArray = [String]()
        for comics in results.comics.items {
            let comicsDate = matches(for: "\\([0-9]{4}\\)", in: comics.name)
            if comicsDate != [] {
                dateArray.append(comicsDate[0])
            }
        }
        return dateArray.sorted(by: < ).first ?? "(????)"
    }

    // assembled the cell
    func updateCell(withResults results: Creator) {
        // replase "http" with "https", because source link looks like "http", and iOS is angry 😡!
        let imageLink = "https" + results.thumbnail.path.dropFirst(4) + "." + results.thumbnail.extension
        self.creatorImageLabel.sd_setImage(with: URL(string: imageLink), completed: nil)
        self.creatorNameLabel.text = String(results.fullName)
        self.creatorWriteFirstComicsLabel.text = findEarliestDate(from: results)
        self.creatorComicsLabel.text = String(describing: results.comics.available)
        self.creatorSeriesLabel.text = String(describing: results.series.available)
        self.creatorStoriesLabel.text = String(describing: results.stories.available)
        self.creatorEventsLabel.text = String(describing: results.events.available)
    }

}
