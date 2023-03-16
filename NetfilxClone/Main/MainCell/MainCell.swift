//
//  MainCell.swift
//  NetfilxClone
//
//  Created by 이송은 on 2023/03/14.
//

import UIKit

class MainCell: UITableViewCell {

    var movieModel : MovieModel?
    @IBOutlet weak var collectionView : UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal //가로로 스크롤 할거다
        flowLayout.minimumLineSpacing = 10
        
        collectionView.collectionViewLayout = flowLayout
        
        collectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func requestMediaAPI(type : MediaType?){
        guard let hasType = type else {
            return
        }
        NetworkLayer.request(type: hasType) { model in
            self.movieModel = model
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
    }
    
}

extension MainCell : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieModel?.resultCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as? MainCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let hasUrl = movieModel?.results[indexPath.item].artworkUrl100{
            NetworkLayer.request(urlstring: hasUrl) { image in
                DispatchQueue.main.async {
                    cell.imageView.image = image
                }
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieResult = movieModel?.results[indexPath.row]
        NotificationCenter.default.post(name: NSNotification.Name("presentDetailVC"), object: movieResult)
        
    }
}

extension MainCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
}
