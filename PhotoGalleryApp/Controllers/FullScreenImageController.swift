//
//  FullScreenImageController.swift
//  PhotoGalleryApp
//
//  Created by Algazzar on 05/02/2022.
//

import UIKit

class FullScreenImageController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    var photo: Photo?

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self
        updateZoomFor(size: view.bounds.size)

        scrollView.contentSize = .init(width: 2000, height: 2000)
        
        if let url = URL(string: photo?.photosUrls?.photoRegular?.safeUrl ?? ""){
            photoImageView.kf.indicatorType = .activity
            photoImageView.kf.setImage(with: url)
        }

    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }

    func updateZoomFor(size: CGSize){
        let widthScale = size.width / photoImageView.bounds.width
        let heightScale = size.height / photoImageView.bounds.height
        let scale = min(widthScale,heightScale)
        scrollView.minimumZoomScale = scale
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
