//
//  DetailViewController.swift
//  NetfilxClone
//
//  Created by 이송은 on 2023/03/16.
//

import UIKit
import AVKit

class DetailViewController: UIViewController {

    @IBOutlet weak var playerContainer: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    private var loadedViewAndDataSet : (() -> Void)?
    var player = AVPlayer()
    var playerLayer = AVPlayerLayer()
    
    var modelResult : Result? {
        didSet {
            loadedViewAndDataSet = {[self] in
                titleLabel.text = modelResult?.trackName
                detailLabel.text = modelResult?.longDescription
                if let previewURL = modelResult?.previewURL, let url = URL(string: previewURL){
                    setPlayer(url: url)
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        makePlayer()
        loadedViewAndDataSet?()
        loadedViewAndDataSet = nil
    }

    
    @IBAction func clickPlay(_ sender: Any) {
        if player.timeControlStatus != .playing{
            player.play()
        }
       
    }
    
    
    @IBAction func clickStop(_ sender: Any) {
        player.pause()
    }
    
    func setPlayer(url : URL){
        player = AVPlayer(url: url)
        playerLayer.player = player
        player.play()
    }
    
    func makePlayer(){
        playerContainer.layer.addSublayer(playerLayer)
        playerLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300)
        
    }
}
