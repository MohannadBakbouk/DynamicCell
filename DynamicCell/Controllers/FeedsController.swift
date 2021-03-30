//
//  FeedsController.swift
//  DynamicCell
//
//  Created by Mohannad on 29.03.2021.
//

import UIKit
import Fakery

class FeedsController: UIViewController {

    @IBOutlet weak var feedCollection: UICollectionView!
    
    var photos = [Photo]()
    
    var headers = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildHeaders()
        configure()

    }
    
    
    func configure(){
        
        let layout = PinterestLayout()
        layout.delegate = self
        
        feedCollection.register(FeedCell.self, forCellWithReuseIdentifier: "FeedCell")
        feedCollection.dataSource = self
        feedCollection.collectionViewLayout = layout
        feedCollection.toggleActivityIndicator()
        
        ApiService.shared.getPhotos { (res) in
            
            if let photos = res {
                
                DispatchQueue.main.async {
                    
                    self.feedCollection.toggleActivityIndicator()
                    
                    self.photos = photos
                    
                    self.feedCollection.reloadData()
                }
            }
        }
    }
    
    func buildHeaders(){
        
        let faker = Faker(locale: "nb-NO")
        for i in 0...50 {
            let randomInt = Int(arc4random_uniform(13) + 2)
            var text = faker.lorem.words(amount: randomInt)
            headers.append(text)
        } 
    }
}

extension FeedsController : UICollectionViewDataSource , UICollectionViewDelegate  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCell", for: indexPath) as! FeedCell

        cell.info = photos[indexPath.row]
        
        cell.descLab.text = headers[indexPath.row]
        
        return cell
        
    }

}



extension FeedsController : PinterestLayoutDelegate {
   
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, cellWidth: CGFloat) -> CGFloat {
        
        let imgHeight = calculateImageHeight(sourceImage: photos[indexPath.row] , scaledToWidth: cellWidth)
        
        let textHeight = requiredHeight(text: headers[indexPath.row], cellWidth: (cellWidth - 10))
        
        return (imgHeight + textHeight + 10)
        
    }
    
    func calculateImageHeight (sourceImage:Photo, scaledToWidth: CGFloat) -> CGFloat {
        let oldWidth = CGFloat( sourceImage.width)
        let scaleFactor = scaledToWidth / oldWidth
        let newHeight = CGFloat(sourceImage.height) * scaleFactor
        return newHeight
    }
    
    func requiredHeight(text:String , cellWidth : CGFloat) -> CGFloat {

        let font = UIFont(name: "Helvetica", size: 16.0)
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: cellWidth, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height

    }
}
