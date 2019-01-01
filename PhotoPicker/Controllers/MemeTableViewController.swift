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
//    
//    @IBAction func addNewMeme() {
//        goToMemeEditor(meme: nil)
//    }
    
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
        let meme = appDelegate.memes[(indexPath as NSIndexPath).row]
        goToMemeDetails(meme: meme)
    }
    
//    func goToMemeEditor(meme: Meme!) {
//        print("Trying to go to edit controller")
//        let editController = self.storyboard!.instantiateViewController(withIdentifier: "MemeEditorViewController")
//            as! MemeEditorViewController
//        if let meme = meme {
//            editController.meme = meme
//        }
//        self.navigationController!.pushViewController(editController, animated: true)
//    }
    
    func goToMemeDetails(meme: Meme!) {
        print("Trying to go to detail controller")
        let detailContoller = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController")
            as! MemeDetailViewController
        if let meme = meme {
            detailContoller.meme = meme
        }
        self.navigationController!.pushViewController(detailContoller, animated: true)
    }
}
