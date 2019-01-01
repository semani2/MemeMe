//
//  MemeTableViewController.swift
//  PhotoPicker
//
//  Created by Sai Emani on 12/21/18.
//  Copyright © 2018 Sai Emani. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var memeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Table view load")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Table view appear, size of memes: \(appDelegate.memes.count)")
        memeTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Reading table details")
        let CellID = "MemeTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath) as! MemeTableViewCell
        
        let meme = appDelegate.memes[(indexPath as NSIndexPath).row]
        
        cell.memeTitleLabel!.text = meme.top + " .. " + meme.bottom
        cell.memeImageView!.image = meme.memedImage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memeIndex = (indexPath as NSIndexPath).row
        let meme = appDelegate.memes[memeIndex]
        goToMemeDetails(meme: meme, memeIndex: memeIndex)
    }
    
    func goToMemeDetails(meme: Meme, memeIndex: Int) {
        print("Trying to go to detail controller")
        let detailContoller = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController")
            as! MemeDetailViewController
        detailContoller.meme = meme
        detailContoller.memeIndex = memeIndex
        self.navigationController!.pushViewController(detailContoller, animated: true)
    }
}
