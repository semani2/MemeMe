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
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Collectin view load")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Collection view appear, size of memes: \(appDelegate.memes.count)")
        memeCollectionView.reloadData()
        
        let space:CGFloat = 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: 150, height: 150)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appDelegate.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath)
            as! MemeCollectionViewCell
        let meme = appDelegate.memes[(indexPath as NSIndexPath).row]
        
        // Set the name and image
        cell.memeLabel.text = "\(meme.top) .. \(meme.bottom)"
        cell.memeImageView!.image = meme.memedImage
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        let memeIndex = (indexPath as NSIndexPath).row
        let meme = appDelegate.memes[memeIndex]
        goToMemeDetails(meme: meme, memeIndex: memeIndex)
    }
    
    func goToMemeDetails(meme: Meme, memeIndex: Int) {
        print("Trying to go to detail controller")
        let detailContoller = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController")
            as! MemeDetailViewController
        detailContoller.memeIndex = memeIndex;
        detailContoller.meme = meme;
        self.navigationController!.pushViewController(detailContoller, animated: true)
    }
}
