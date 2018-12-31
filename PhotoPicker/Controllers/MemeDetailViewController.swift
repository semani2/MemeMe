//
//  MemeDetailViewController.swift
//  PhotoPicker
//
//  Created by Sai Emani on 12/30/18.
//  Copyright © 2018 Sai Emani. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    @IBOutlet weak var memeImageView: UIImageView!
    var meme: Meme?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem (barButtonSystemItem: .edit, target: self, action: #selector(editMeme))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memeImageView.image = meme!.memedImage
    }
    
    @objc func editMeme() {
        let memeEditorViewController = storyboard!.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        memeEditorViewController.meme = meme
        
        present(memeEditorViewController, animated: true)
    }
    
}
