//
//  FeedCell.swift
//  DynamicCell
//
//  Created by Mohannad on 29.03.2021.
//


import UIKit
import Kingfisher

class FeedCell: UICollectionViewCell {
    
    
    var img : UIImageView = {
      let img = UIImageView()
      img.backgroundColor = .gray
      img.contentMode = .scaleAspectFill
      img.clipsToBounds = true
      img.translatesAutoresizingMaskIntoConstraints = false
      img.setContentHuggingPriority(.defaultLow, for: .vertical)
      return img
    }()
    
    var descLab : UILabel = {
        let lab = UILabel()
        lab.textColor = .white
        lab.numberOfLines = 0
        lab.lineBreakMode = .byWordWrapping
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.font = UIFont(name: "Helvetica", size: 16)
        lab.setContentHuggingPriority(.defaultHigh, for: .vertical)
       return lab
    }()
    
    var info : Photo? {
        didSet {
            assignPhoto()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
        setupConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        info = nil
        img.removeFromSuperview()
        descLab.removeFromSuperview()

    }
    
    deinit {
        info = nil
    }
    
    
    func setupViews(){
        
        layer.borderWidth = 1
        layer.borderColor =  UIColor.lightGray.cgColor
        backgroundColor = .mainColor
        contentView.addSubview(img)
        contentView.addSubview(descLab)
    
    }
    
    func setupConstraints(){
        img.anchor(top: contentView.topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: contentView.leadingAnchor, paddingLeft: 0, right: contentView.trailingAnchor, paddingRight: 0, width: 0, height: 0)
        
        descLab.anchor(top: img.bottomAnchor , paddingTop: 5, bottom: contentView.bottomAnchor, paddingBottom: -5, left: contentView.leadingAnchor, paddingLeft: 5, right: contentView.trailingAnchor, paddingRight: -5, width: 0, height: 0)
    }
    
    func assignPhoto(){
        
        guard let data = info else {
            return
        }
        
        img.kf.setImage(with: URL(string: data.download_url)!) { res in
            if case .success(let value)  = res   {
                ImageCache.default.store(value.image, forKey: data.download_url)

            }
        }
    }
    
}

