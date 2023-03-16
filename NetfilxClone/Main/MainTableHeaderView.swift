//
//  MainTableHeaderView.swift
//  NetfilxClone
//
//  Created by 이송은 on 2023/03/14.
//

import UIKit

class MainTableHeaderView: UIView {

    var imageView : UIImageView = {
       let imageView = UIImageView(image: UIImage(named: "Top-Gun-Maverick"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private func addView(){
        self.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    //init 사용시 반드시 호출 되어있어야 함
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(){
        super.init(frame: .zero)
        addView()
    }
}
