//
//  VideosCollectionViewCell.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 21.07.2023.
//

import UIKit
import WebKit

class VideosCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadVideo(videoID: String) {
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)") else { return }
        webView.load(URLRequest(url: youtubeURL))
    }
}
