//
//  PhotosViewController.swift
//  VirtualTourist
//
//  Created by Glenn Cole on 11/11/19.
//  Copyright © 2019 Glenn Cole. All rights reserved.
//

import UIKit
import MapKit

class PhotosViewController: UIViewController {

    @IBOutlet weak var shortMapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureFlowLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    private func configureFlowLayout() {
        
        let spacing: CGFloat = 3.0
        flowLayout.minimumLineSpacing = spacing
        flowLayout.minimumInteritemSpacing = spacing
        flowLayout.sectionInset = UIEdgeInsets(top: 0.0, left: 2 * spacing, bottom: spacing, right: 2 * spacing)
        
        print( "width: frame=\(view.frame.size.width) / bounds=\(view.bounds.size.width)" )
        let screenWidth = UIScreen.main.bounds.width
        let insetLeft = view.safeAreaInsets.left
        let insetRight = view.safeAreaInsets.right
        print( "screen width=\(screenWidth) / leftInset=\(insetLeft) / rightInset=\(insetRight)" )
        
        let preferredSize: CGFloat = 120.0
        let hNumItems = CGFloat( Int((view.frame.size.width - spacing) / preferredSize))
        
        let hItemSize = CGFloat( Int(view.frame.size.width / hNumItems))
        
        let bestItemSize = hItemSize - spacing * 2
        flowLayout.itemSize = CGSize( width: bestItemSize, height: bestItemSize )
    }
}

extension PhotosViewController: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell",
                                                      for: indexPath) as! PhotosCollectionViewCell
        
        cell.backgroundColor = .gray
        
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print( "tapped cell" )
    }
}
