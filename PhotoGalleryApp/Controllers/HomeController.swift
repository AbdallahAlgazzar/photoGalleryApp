//
//  HomeController.swift
//  PhotoGalleryApp
//
//  Created by Algazzar on 04/02/2022.
//

import UIKit
import Alamofire
import CoreMedia

class HomeController: UIViewController {
    
    @IBOutlet weak var photosCollectionView: UICollectionView!{
        didSet{
            photosCollectionView.dataSource = self
            photosCollectionView.delegate = self
            photosCollectionView.registerCellNib(cellClass: PhotoCell.self)
        }
    }
    
    private var baseUrl = "https://api.unsplash.com/photos/"
    private var clientID = "ckfrUGYGPjoXhMYI5X3ewaiTfW26RsvZPHGOWIfriXw"
    private var page = 1
    private var photos = [Photo]()
    private var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title:"Grid", style: .plain, target: self, action: #selector(switcherTapped))

        title = "Photos"
        getPhotos()
        
    }
    
    @objc private func switcherTapped(){
                
        if navigationItem.rightBarButtonItem?.title == "Grid"{
            navigationItem.rightBarButtonItem?.title = "Row"
            photosCollectionView.reloadData()
        }else{
            navigationItem.rightBarButtonItem?.title = "Grid"
            photosCollectionView.reloadData()
        }
        
    }
    
    private func getPhotos(){
        
        let headers: HTTPHeaders = ["Authorization": "Client-ID \(clientID)"]
        
        APIServices.shared.fetchData(url: "\(baseUrl)?page=\(page)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers, responseModel: [Photo].self) { [weak self] result in
                
            guard let self = self else {return}
            
            self.isLoading = true

            switch result{
                
            case .success(let response):
                                
                guard let photos = response else {return}
                
                print(photos)
                
                for photo in photos {
                    self.photos.append(photo)
                }
                
                DispatchQueue.main.async {
                    
                    self.photosCollectionView.reloadData()
                }
                
                self.isLoading = false
                
            case .failure(let error):
                
                print(error)
            }
        }
        
    }


}

//MARK: - collection view methods
extension HomeController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeue(indexPath: indexPath) as PhotoCell
        cell.configureCell(photo: photos[indexPath.item])
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if navigationItem.rightBarButtonItem?.title == "Grid"{
            
            return CGSize(width: collectionView.frame.width - 30, height: collectionView.frame.height / 4)

        }else{
            
            return CGSize(width: (collectionView.frame.width - 30) / 2, height: (collectionView.frame.width - 30) / 2)
            
        }
                
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = FullScreenImageController.instantiateFromNib()
        vc.photo = photos[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HomeController{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !isLoading){
            
            page += 1
            getPhotos()
            
        }
    }
    
}
