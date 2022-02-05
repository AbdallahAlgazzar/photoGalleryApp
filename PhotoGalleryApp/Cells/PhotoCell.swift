//
//  PhotoCell.swift
//  PhotoGalleryApp
//
//  Created by Algazzar on 04/02/2022.
//

import UIKit
import Kingfisher

class PhotoCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var sponsorProfileImageView: UIImageView!
    @IBOutlet weak var tagLineLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        photoImageView.layer.cornerRadius = 8
        sponsorProfileImageView.layer.cornerRadius = 20
    }
    
    func configureCell(photo: Photo){
        
        
        if let url = URL(string: photo.photosUrls?.photoRegular?.safeUrl ?? ""){
            
            photoImageView.kf.indicatorType = .activity
            photoImageView.kf.setImage(with: url)
        }
        
        
        if let sponserProfileUrl = URL(string: photo.sponsorShip?.sponsor?.profileImage?.medium?.safeUrl ?? ""){
            
            sponsorProfileImageView.kf.indicatorType = .activity
            
            sponsorProfileImageView.kf.setImage(with: sponserProfileUrl)
        }
        
        if let tagLine = photo.sponsorShip?.tagLine{
            
            tagLineLabel.text = tagLine
        }
        
    }

}
