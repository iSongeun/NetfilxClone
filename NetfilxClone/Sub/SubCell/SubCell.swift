//
//  SubCell.swift
//  NetfilxClone
//
//  Created by 이송은 on 2023/03/15.
//

import UIKit
import AVKit
 
class SubCell: UITableViewCell {
    var baseContainer : UIView = {
        let baseView = UIView()
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.backgroundColor = .black
        return baseView
    }()
    
    var movieContainerView : UIView = {
        let movieView = UIView()
        movieView.translatesAutoresizingMaskIntoConstraints = false
        movieView.backgroundColor = .black
        return movieView
    }()
    
    var thumbnailImage : UIImageView = {
        let thumbnail = UIImageView()
        thumbnail.translatesAutoresizingMaskIntoConstraints = false
        thumbnail.backgroundColor = .clear
        thumbnail.contentMode = .scaleAspectFill
        return thumbnail
    }()
    
    var dateLabel : UILabel = {
        let datelabel = UILabel()
        datelabel.translatesAutoresizingMaskIntoConstraints = false
        datelabel.backgroundColor = .clear
        datelabel.textColor = .white
        return datelabel
    }()
    
    var titleLabel : UILabel = {
       let titlelabel = UILabel()
        titlelabel.translatesAutoresizingMaskIntoConstraints = false
        titlelabel.backgroundColor = .clear
        titlelabel.textColor = .white
        return titlelabel
    }()
    
    var detailLabel : UILabel = {
       let detail = UILabel()
        detail.translatesAutoresizingMaskIntoConstraints = false
        detail.backgroundColor = .black
        detail.textColor = .white
        detail.numberOfLines = 0
        return detail
    }()
    
    var coverImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "photo")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var player = AVPlayer()
    var playerLayer = AVPlayerLayer()
    var movieResult : Result? {
        didSet {
            DispatchQueue.main.async {
                self.settingPlayerURL()
                self.setDate()
                self.setTitle()
                self.setDetail()
                self.setThumbnail()
                self.setCoverImage()
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .black
        addBaseView()
        addMovieContrainer()
        addThumbnailView()
        addLabel()
        addPlayer()
        addCoverImage()
    }
    
    private func settingPlayerURL(){
        if let previewURL = movieResult?.previewURL, let hasURL = URL(string: previewURL) {
            self.player = AVPlayer(url: hasURL)
            self.playerLayer.player = self.player
            self.player.volume = 0
            self.player.play()
//            self.player.pause()
        }
    }
    
    private func setDate(){
        if let hasDate = movieResult?.releaseDate {
            let formmater = ISO8601DateFormatter()
            if let isoDate = formmater.date(from: hasDate) {
                let myFormatter = DateFormatter()
                myFormatter.dateFormat = "yyyy-MM-dd"
                let dateString = myFormatter.string(from: isoDate)
                
                self.dateLabel.text = dateString
            }
        }
    }
    
    private func setTitle(){
        if let titleString = movieResult?.trackName {
            self.titleLabel.text = titleString
        }
    }
    
    private func setDetail(){
        if let detailString = movieResult?.shortDescription {
            self.detailLabel.text = detailString
        }
    }
    private func setThumbnail(){
        if let urlString = movieResult?.artworkUrl100{
            NetworkLayer.request(urlstring: urlString) { image in
                DispatchQueue.main.async {
                    self.thumbnailImage.image = image
                }
            }
        }
    }
    
    private func setCoverImage(){
        if let urlString = movieResult?.artworkUrl100{
            NetworkLayer.request(urlstring: urlString) { image in
                DispatchQueue.main.async {
                    self.coverImageView.image = image
                }
            }
        }
    }
    private func addBaseView(){
        self.contentView.addSubview(baseContainer)
        
        //base container
        baseContainer.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 50).isActive = true
        baseContainer.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        baseContainer.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        baseContainer.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
    }
    
    private func addMovieContrainer(){
        baseContainer.addSubview(movieContainerView)
        
        movieContainerView.topAnchor.constraint(equalTo: baseContainer.topAnchor).isActive = true
//        movieContainerView.bottomAnchor.constraint(equalTo: baseContainer.bottomAnchor).isActive = true
        movieContainerView.leftAnchor.constraint(equalTo: baseContainer.leftAnchor).isActive = true
        movieContainerView.rightAnchor.constraint(equalTo: baseContainer.rightAnchor).isActive = true
        movieContainerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    private func addThumbnailView(){
        baseContainer.addSubview(thumbnailImage)
        
        thumbnailImage.topAnchor.constraint(equalTo: movieContainerView.bottomAnchor).isActive = true
        thumbnailImage.leftAnchor.constraint(equalTo: baseContainer.leftAnchor).isActive = true
        thumbnailImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        thumbnailImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func addLabel(){
        baseContainer.addSubview(dateLabel)
        baseContainer.addSubview(titleLabel)
        baseContainer.addSubview(detailLabel)
        
        dateLabel.topAnchor.constraint(equalTo: thumbnailImage.bottomAnchor).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: baseContainer.leftAnchor).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: baseContainer.rightAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: baseContainer.leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: baseContainer.rightAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        detailLabel.leftAnchor.constraint(equalTo: baseContainer.leftAnchor).isActive = true
        detailLabel.rightAnchor.constraint(equalTo: baseContainer.rightAnchor).isActive = true
        detailLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func addCoverImage(){
        movieContainerView.addSubview(coverImageView)
        
        coverImageView.leftAnchor.constraint(equalTo: movieContainerView.leftAnchor).isActive = true
        coverImageView.rightAnchor.constraint(equalTo: movieContainerView.rightAnchor).isActive = true
        coverImageView.topAnchor.constraint(equalTo: movieContainerView.topAnchor).isActive = true
        coverImageView.bottomAnchor.constraint(equalTo: movieContainerView.bottomAnchor).isActive = true
    }
    
    private func addPlayer(){
        playerLayer.player = player
        movieContainerView.layer.addSublayer(playerLayer)
        playerLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 50, height: 200)
        playerLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 50, height: 200)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func movieWPlay(){
        if self.player.timeControlStatus != .playing{
            self.player.play()
            self.coverImageView.isHidden = true
        }
    }
    
    func moviewStop(){
        self.player.pause()
        if self.player.currentTime().seconds > 1 {
            coverImageView.isHidden = true
        }else{
            self.coverImageView.isHidden = false
        }
    }
}
