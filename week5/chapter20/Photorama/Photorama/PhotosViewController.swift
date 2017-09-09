//
//  PhotosViewController.swift
//  Photorama
//
//  Created by Kangsoo on 28/07/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    
    var photoStore = PhotoStore()
    let photoDataSource = PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = photoDataSource
        
        photoStore.fetchRecentPhotos() { (photosResult) -> Void in
            OperationQueue.main.addOperation {
                switch photosResult {
                case let .success(photos):
                    print("Successfully found \(photos.count) recent photos.")
                    self.photoDataSource.photos = photos
                case let .failure(error):
                    self.photoDataSource.photos.removeAll()
                    print("Error fetching recent photos: \(error)")
                }
                self.collectionView.reloadSections(IndexSet(integer: 0))
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ShowPhotoInfo" else{
            assertionFailure("The identifier for segue object is not 'ShowPhoto'.")
            return
        }
        guard let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first else{
            assertionFailure("The first element is nil.")
            return
        }
        guard let destinationViewController = segue.destination as? PhotoInfoViewController else {
            print("Failed downcasting destination to PhotoInfoViewController.")
            return
        }
        let photo = photoDataSource.photos[selectedIndexPath.row]
        
        destinationViewController.photo = photo
        destinationViewController.photoStore = photoStore
    }
}

extension PhotosViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        let photo = photoDataSource.photos[indexPath.row]
        
        photoStore.fetchImageForPhoto(photo: photo) { (result) -> Void in
            OperationQueue.main.addOperation {
                guard let photoIndex = self.photoDataSource.photos.index(of: photo) else {
                    assertionFailure("The index of photos is nil.")
                    return
                }
                let photoIndexPath = IndexPath(row: photoIndex, section: 0)
                
                if let cell = self.collectionView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell {
                    cell.updateWithImage(image: photo.image)
                }
            }
        }
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellLength = 0.0
        
        if UIDevice.current.orientation.isPortrait{
            cellLength = Double(collectionView.bounds.width) / 4
        } else if UIDevice.current.orientation.isLandscape {
            cellLength = Double(collectionView.bounds.width) / 8
        }
        
        return CGSize(width: cellLength, height: cellLength)
    }
}
