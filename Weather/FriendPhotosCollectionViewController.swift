//
//  FriendPhotosCollectionViewController.swift
//  Weather
//
//  Created by Stanislav Vasilev on 15.05.2021.
//

import UIKit
import Alamofire
import AlamofireImage


class FriendPhotosCollectionViewController: UICollectionViewController {
   var userId: Int = 1
   var photos = [VKPhoto]()
   var selectedIndex = 0

   override func viewDidLoad() {
       super.viewDidLoad()
               
       requestData()
   }
   
   private func requestData() {
       VKService.instance.loadPhotos(userId: userId) { result in
           switch result {
           case .success(let photos):
               self.photos = photos
               self.collectionView.reloadData()
           case .failure(let error):
               print(error)
           }
       }
   }

   // MARK: UICollectionViewDataSource

   override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return photos.count
   }

   override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCollectionViewCell
       
       let photo = photos[indexPath.row]
       let photoUrl = URL(string: photo.url)!
       cell.photos.af.setImage(withURL: photoUrl)

       return cell
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           selectedIndex = indexPath.item
           self.performSegue(withIdentifier: "toPhoto" , sender: self )
       }
       
         func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "toPhoto",
          let destination = segue.destination as? BrowsingPhotosViewController {
             destination.selectedIndex = selectedIndex
             destination.photos = []
           }
      }
}
}


