//
//  PhotoViewController.swift
//  Weather
//
//  Created by Stanislav Vasilev on 09.03.2021.
//

import UIKit
import Alamofire
import AlamofireImage



class PhotoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource , UIScrollViewDelegate, UICollectionViewDelegateFlowLayout{
    @IBOutlet weak var imagesBox: UIView!
    let w = UIScreen.main.bounds.width
    var currentPage = 0
    var currentPosition = CGPoint()
    var userId: Int = 1
    
    var selectedIndex = 0
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    let tap = UITapGestureRecognizer()
    @IBOutlet  var carousel: UIScrollView!
    
    var photos = [#imageLiteral(resourceName: "photo4"), #imageLiteral(resourceName: "photo9"), #imageLiteral(resourceName: "photo3"), #imageLiteral(resourceName: "photo8")]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AF.request("https://api.vk.com/method/photo.get",
                   parameters: [
                    "access_token" : Session.shared.accessToken,
                    "user_id" : Session.shared.userId,
                    "extended" : "1",
                    "count" : "4",
                    "no_service_albums" : "0",
                    "v" : "5.68"
                   ]).responseJSON {
                    response in
                    print(response.value)
                   }
        
        imagesBox.isHidden = true
        tap.addTarget(self, action: #selector(GotoGallery))
        imagesBox.isUserInteractionEnabled = true
        imagesBox.addGestureRecognizer(tap)
       initImagesBox()
        // Do any additional setup after loading the view.
        
    }
    @objc func GotoGallery(){

        
        collectionView.isHidden = false
        self.imagesBox.isHidden = true
        UIView.animate(withDuration: 0.3) {
            // return default settings
            (self.collectionView.visibleCells[self.currentPage] as! PhotoCollectionViewCell).image.frame.origin = self.currentPosition
         
            (self.collectionView.visibleCells[self.currentPage] as! PhotoCollectionViewCell).image.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)

            (self.collectionView.visibleCells[self.currentPage] as! PhotoCollectionViewCell).image.contentMode = .scaleAspectFit
           
            
           
        } completion: { (isFinish) in
            UIView.animate(withDuration: 0.3) {
                (self.collectionView.visibleCells[self.currentPage] as! PhotoCollectionViewCell).image.contentMode = .scaleAspectFill
                (self.collectionView.visibleCells[self.currentPage] as! PhotoCollectionViewCell).image.transform = CGAffineTransform(scaleX: 1, y: 1)
                (self.collectionView.visibleCells[self.currentPage] as! PhotoCollectionViewCell).image.frame.size = CGSize(width: self.w / 2 - 10, height: self.w / 2 - 10)
                
                (self.collectionView.visibleCells[self.currentPage] as! PhotoCollectionViewCell).image.layer.zPosition = 0
                
            }
                
        }
        }
    func changeOffset(scroolViewoffset : CGFloat) {
        carousel.contentOffset.x = scroolViewoffset
        UIView.animate(withDuration: 0.3) {
            
        
            for (n, i) in self.carousel.subviews.enumerated() {
                let offset = n == 0 ? 0 : (CGFloat(n) * self.imagesBox.bounds.width)
                
            i.transform = CGAffineTransform(scaleX: 1, y: 1)
                i.frame = CGRect(x: offset, y: 0, width: self.w , height: self.collectionView.bounds.height)
        }
        }
    }
    func initImagesBox() {
        let h = collectionView.bounds.height
        // create the UISCrollView
        carousel = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: h))
        carousel.translatesAutoresizingMaskIntoConstraints = false
        carousel.delegate = self
        // if needed, hide the indicator
        
        carousel.isDirectionalLockEnabled = true
        carousel.showsHorizontalScrollIndicator = false
        carousel.showsVerticalScrollIndicator = false
        // enable paginated scrolling
        carousel.isPagingEnabled = true
        // loops on [UIImage]
        for i in 0..<photos.count {
            // calcuate the horizontal offset
            let offset = i == 0 ? 0 : (CGFloat(i) * imagesBox.bounds.width)
            // create a UIImageView
            let imgView = UIImageView(frame: CGRect(x: offset, y: 0, width: imagesBox.bounds.width, height: h))
            imgView.image = photos[i]
            // handle the overflow
            imgView.clipsToBounds = true
            // handle the contentMode
            imgView.contentMode = .scaleAspectFit
            // add the UIImageView to the UIScrollView
            carousel.addSubview(imgView)
        }
       
        // set the contentSize
        carousel.contentSize = CGSize(width: CGFloat(photos.count) * imagesBox.bounds.width, height: h)
       
        carousel.isScrollEnabled = true
        carousel.alwaysBounceHorizontal = false
        carousel.alwaysBounceVertical = false
        imagesBox.addSubview(carousel)
        
        UIView.animate(withDuration: 0.3) {
            for (n, i) in self.carousel.subviews.enumerated() {
                
                let offset = n == 0 ? 0 : (CGFloat(n) * self.imagesBox.bounds.width)
            i.transform = CGAffineTransform(scaleX: 1, y: 1)
                i.frame = CGRect(x: offset, y: 0, width: self.w , height: h)
        }
        }

    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y != 0 {
            scrollView.contentOffset.y = 0
        }
        let h = collectionView.bounds.height
       
        UIView.animate(withDuration: 0.3) {
            
        
            for (n, i) in self.carousel.subviews.enumerated() {
                let offset = n == 0 ? 0 : (CGFloat(n) * self.imagesBox.bounds.width)
                
                i.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                if scrollView.contentOffset.x > 0 {
                    i.frame = CGRect(x: offset - 30, y: 0, width: i.bounds.size.width / 2 , height: h)
                } else {
                    i.frame = CGRect(x: offset + 30, y: 0, width: i.bounds.size.width / 2 , height: h)
                }
               
        }
        }
    }
  
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let x = scrollView.contentOffset.x
            let w = scrollView.bounds.size.width
        let h = collectionView.bounds.height
            currentPage = Int(ceil(x/w))
        
        
        UIView.animate(withDuration: 0.3) {
            
        
            for (n, i) in self.carousel.subviews.enumerated() {
                let offset = n == 0 ? 0 : (CGFloat(n) * self.imagesBox.bounds.width)
                
            i.transform = CGAffineTransform(scaleX: 1, y: 1)
            i.frame = CGRect(x: offset, y: 0, width: self.w , height: h)
        }
        }
       
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCollectionViewCell
        let photo = photos[indexPath.item]
        cell.image.image = photo
    
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: w / 2 - 10, height: w / 2 - 10)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     //   collectionView.isHidden = true
        
        UIView.animate(withDuration: 0.3) {
            let h = collectionView.bounds.height
            self.currentPosition =  (collectionView.visibleCells[indexPath.item] as! PhotoCollectionViewCell).image.frame.origin
            (collectionView.visibleCells[indexPath.item] as! PhotoCollectionViewCell).image.frame = CGRect(x: 0, y: 0, width: self.imagesBox.bounds.width, height: h)
            (collectionView.visibleCells[indexPath.item] as! PhotoCollectionViewCell).image.contentMode = .scaleAspectFit
            (collectionView.visibleCells[indexPath.item] as! PhotoCollectionViewCell).image.layer.zPosition = 2
        } completion: { (isFinish) in
          //  guard isFinish else { return}
            
            
            
            //open gallery
            let offset = indexPath.item == 0 ? 0 : (CGFloat(indexPath.item) * self.imagesBox.bounds.width)
            
            self.changeOffset(scroolViewoffset: offset)
            UIView.animate(withDuration: 0.3) {
            self.imagesBox.isHidden = false
            collectionView.isHidden = true
           
            self.currentPage = indexPath.item
            }
        }

       

    }

}

/*
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
*/
