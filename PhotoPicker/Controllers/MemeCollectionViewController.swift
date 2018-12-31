//
//  MemeCollectionViewController.swift
//  PhotoPicker
//
//  Created by Sai Emani on 12/5/18.
//  Copyright © 2018 Sai Emani. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var memeCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Collectin view load")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Collection view appear, size of memes: \(appDelegate.memes.count)")
        memeCollectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appDelegate.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath)
            as! MemeCollectionViewCell
        let meme = appDelegate.memes[(indexPath as NSIndexPath).row]
        
        // Set the name and image
        cell.memeLabel.text = meme.top
        cell.memeImageView!.image = meme.memedImage
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        let meme = appDelegate.memes[(indexPath as NSIndexPath).row]
        goToMemeDetails(meme: meme)
    }
    
    @IBAction func addNewMeme() {
        goToMemeEditor(meme: nil)
    }
    
    func goToMemeEditor(meme: Meme!) {
        print("Trying to go to edit controller")
        let editController = self.storyboard!.instantiateViewController(withIdentifier: "MemeEditorViewController")
            as! MemeEditorViewController
        if let meme = meme {
            editController.meme = meme
        }
        self.navigationController!.pushViewController(editController, animated: true)
    }
    
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
