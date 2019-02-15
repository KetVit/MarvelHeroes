//
//  TableViewCell.swift
//  MarvelHeroes
//
//  Created by ket on 30.01.2019.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit
import SDWebImage

class HeroesTableVC: UITableViewController {
    let marvelHeroes = HeroesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        marvelHeroes.updateData { (bool) in
            if bool {
                self.tableView.reloadData()
            }
        }
    }
    
    // get retrieve heroes data
   
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var detailLink = ""
        var wikiLink = ""
        // find "wiki" key among data
        for url in marvelHeroes.allHeroesData[indexPath.row].urls {
            if url.type == "wiki" {
                wikiLink = url.url
            } else {
                detailLink = url.url
            }
        }
        // go to "wiki" link or "detail" link
        if wikiLink != "" {
            wikiLink.insert("s", at: wikiLink.index(wikiLink.startIndex, offsetBy: 4))
            self.performSegue(withIdentifier: "goToHeroInfo", sender: URL(string: wikiLink))
        } else {
            detailLink.insert("s", at: detailLink.index(detailLink.startIndex, offsetBy: 4))
            self.performSegue(withIdentifier: "goToHeroInfo", sender: URL(string: detailLink))
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return marvelHeroes.allHeroesData.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HeroTableViewCell
        cell.updateCell(withResults: marvelHeroes.allHeroesData[indexPath.row])
        // pagination cells
        if false {
            marvelHeroes.updateData { (bool) in
                if bool {
                    tableView.reloadData()
                }
            }
        }
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let WebVC = segue.destination as? WebVC
        WebVC?.heroLink = sender as? URL
    }
    
}
