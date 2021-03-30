//
//  CommentsController.swift
//  DynamicCell
//
//  Created by Mohannad on 29.03.2021.
//

import UIKit
import Fakery

class CommentsController: UIViewController {
    
    
    @IBOutlet weak var commentColllection: UICollectionView!
    
    let commentFlowLayout = CommentFlowLayout()

    private var comments = [Comment]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        buildComments()
        configure()
        
    }
    
    
    
    func configure ()  {
        
        commentColllection.dataSource = self
        commentColllection.register(CommentCell.self, forCellWithReuseIdentifier: "cell")
        commentFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        commentFlowLayout.minimumInteritemSpacing = 10
        commentFlowLayout.minimumLineSpacing = 10
        commentColllection.collectionViewLayout = commentFlowLayout
        commentColllection.contentInsetAdjustmentBehavior = .always
        commentColllection.reloadData()
    }
    
    
    func buildComments(){
        
        let faker = Faker(locale: "nb-NO")
        for i in 0...9 {
            let randomInt = Int(arc4random_uniform(6) + 1)
            var info = Comment(owner: faker.name.name(), id: UUID().uuidString, message: faker.lorem.sentences(amount: 5), ownerPhoto: "9\(i)")
            
            comments.append(info)
            
        }
        
    }
}



extension CommentsController : UICollectionViewDataSource  {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CommentCell
        
         cell.comment = comments[indexPath.row]

        return cell
    }

    

}
