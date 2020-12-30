//
//  ViewController.swift
//  customlayout_collectionview
//
//  Created by Rajeeva Ranjan on 21/10/20.
//  Copyright © 2020 Rajeeva Ranjan. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: *** Properties ***

    var collectionview = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: CV_WIDTH, height: CV_HEIGHT), collectionViewLayout: CustomCollectionViewLayout())
    var numberItemsInsec1: NSInteger = 0
    var numberItemsInsec2: NSInteger = 0
    var DEVICE_HEIGHT = UIScreen.main.bounds.size.height
    var DEVICE_WIDTH = UIScreen.main.bounds.size.width
    var b1: UIButton = UIButton()
    var b2: UIButton = UIButton()
    var b3: UIButton = UIButton()
    var b4: UIButton = UIButton()
    var b5: UIButton = UIButton()
    
    
    // MARK: *** View Controller apis ***

    override func viewDidLoad() {
        
        super.viewDidLoad()
        numberItemsInsec1 = NSInteger(NUMBER_OF_ITEMS_IN_SEC1)
        numberItemsInsec2 = NSInteger(NUMBER_OF_ITEMS_IN_SEC2)
        
        let gc = UILongPressGestureRecognizer(target: self, action: #selector(gcAction(gc:)))
        collectionview.addGestureRecognizer(gc)
        
        let bgView = UIView.init(frame: CGRect(x: 0, y: 0, width: CV_WIDTH, height: CV_HEIGHT))
        bgView.backgroundColor = UIColor.cyan
        collectionview.isDirectionalLockEnabled = true
        collectionview.backgroundView = bgView
        collectionview.bounces = false
            
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "cellIdentifier")
        collectionview.register(headerfooterview.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionview.register(headerfooterview.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")
        
        collectionview.backgroundColor = UIColor.white
        self.view.addSubview(collectionview)
        
        b1 = UIButton.init(type: UIButton.ButtonType.system)
        b1.frame = CGRect(x: 0, y: DEVICE_HEIGHT-75, width: DEVICE_WIDTH/3, height: 50)
        b1.setTitle("Vertical Layout", for: UIControl.State.normal)
        b1.setTitle("Vertical Layout", for: UIControl.State.focused)
        b1.addTarget(self, action: #selector(setVerticalLayoutAttributes), for: UIControl.Event.touchDown)

        b2 = UIButton.init(type: UIButton.ButtonType.system)
        b2.frame = CGRect(x: DEVICE_WIDTH/3, y: DEVICE_HEIGHT-75, width: DEVICE_WIDTH/3, height: 50)
        b2.setTitle("Horizontal Layout", for: UIControl.State.normal)
        b2.setTitle("Horizontal Layout", for: UIControl.State.focused)
        b2.addTarget(self, action: #selector(setHorizontalLayoutAttributes), for: UIControl.Event.touchDown)
        
        b3 = UIButton.init(type: UIButton.ButtonType.system)
        b3.frame = CGRect(x: DEVICE_WIDTH*2/3, y: DEVICE_HEIGHT-75, width: DEVICE_WIDTH/3, height: 50)
        b3.setTitle("Custom Layout", for: UIControl.State.normal)
        b3.setTitle("Custom Layout", for: UIControl.State.focused)
        b3.addTarget(self, action: #selector(setCustomLayoutAttributes), for: UIControl.Event.touchDown)
        
        b4 = UIButton.init(type: UIButton.ButtonType.system)
        b4.frame = CGRect(x: 0, y: DEVICE_HEIGHT-125, width: DEVICE_WIDTH/2, height: 50)
        b4.setTitle("Add item at 2nd index", for: UIControl.State.normal)
        b4.setTitle("Add item at 2nd index", for: UIControl.State.focused)
        b4.addTarget(self, action: #selector(addAtOne), for: UIControl.Event.touchDown)
        
        b5 = UIButton.init(type: UIButton.ButtonType.system)
        b5.frame = CGRect(x: DEVICE_WIDTH/2, y: DEVICE_HEIGHT-125, width: DEVICE_WIDTH/2, height: 50)
        b5.setTitle("Remove item at 2nd index", for: UIControl.State.normal)
        b5.setTitle("Remove item at 2nd index", for: UIControl.State.focused)
        b5.addTarget(self, action: #selector(removeAtOne), for: UIControl.Event.touchDown)
        
        b1.backgroundColor = UIColor.systemBlue
        b1.setTitleColor(UIColor.white, for: UIControl.State.normal)
        b1.setTitleColor(UIColor.white, for: UIControl.State.focused)
        b1.layer.cornerRadius = 10

        b2.backgroundColor = UIColor.systemBlue
        b2.setTitleColor(UIColor.white, for: UIControl.State.normal)
        b2.setTitleColor(UIColor.white, for: UIControl.State.focused)
        b2.layer.cornerRadius = 10
        
        b3.backgroundColor = UIColor.systemBlue
        b3.setTitleColor(UIColor.white, for: UIControl.State.normal)
        b3.setTitleColor(UIColor.white, for: UIControl.State.focused)
        b3.layer.cornerRadius = 10
        
        b4.backgroundColor = UIColor.systemBlue
        b4.setTitleColor(UIColor.white, for: UIControl.State.normal)
        b4.setTitleColor(UIColor.white, for: UIControl.State.focused)
        b4.layer.cornerRadius = 10
        
        b5.backgroundColor = UIColor.systemBlue
        b5.setTitleColor(UIColor.white, for: UIControl.State.normal)
        b5.setTitleColor(UIColor.white, for: UIControl.State.focused)
        b5.layer.cornerRadius = 10

        self.view.addSubview(b1)
        self.view.addSubview(b2)
        self.view.addSubview(b3)
        self.view.addSubview(b4)
        self.view.addSubview(b5)
        
        self.setCustomLayoutAttributes()
        //collectionview.reloadData();

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        var collViewFrame = collectionview.frame
        collViewFrame = CGRect(x: collViewFrame.origin.x, y: 0, width: collViewFrame.size.width, height: DEVICE_HEIGHT)
        collectionview.contentInsetAdjustmentBehavior = .always
        collectionview.frame = collViewFrame

    }
    
    // MARK: CollectionView datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (section == 0) {
            return numberItemsInsec1;
        }
        
        return numberItemsInsec2;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Int(NUMBER_OF_SECTIONS)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell1 = collectionview.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath)
        
        let cell = cell1 as! CustomCollectionViewCell
        
        cell.clipsToBounds = true
        cell.backgroundColor = UIColor.clear
        cell.layer.borderWidth = 1
        
        let bv = UIView.init(frame: cell.frame)
        bv.backgroundColor = UIColor.cyan
        
        let sbv = UIView.init(frame: cell.frame)
        sbv.backgroundColor = UIColor.systemBlue
        
        cell.backgroundView = bv;
        cell.selectedBackgroundView = sbv;
                
        if (cell.myLabel == nil) {

            cell.myLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: 150, height: 75))
            cell.myLabel.isOpaque = true;

//            cell.myLabel.textColor = UIColor.black
//            cell.myLabel.textAlignment = NSTextAlignment.center
            cell.contentView.addSubview(cell.myLabel)
        
        }
        
        cell.myLabel.textColor = UIColor.black
        cell.myLabel.textAlignment = NSTextAlignment.left
        cell.myLabel.backgroundColor = UIColor.clear

        
        if !collectionview.collectionViewLayout.isMember(of: CustomCollectionViewLayout.self) {
           
            cell.myLabel.text = "Item ".appendingFormat("%d", indexPath.section).appendingFormat("%d", indexPath.item+1)
            cell.myLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 75)


        } else {
            if (indexPath.section == 4) {
                if (indexPath.item == 0) {
                    cell.myLabel.frame = CGRect(x: 0, y: 0, width: CV_WIDTH, height: 75)
                    cell.myLabel.text = "COMMERCIAL";
                    cell.myLabel.textAlignment = NSTextAlignment.center
                    cell.myLabel.backgroundColor = UIColor.red
                    cell.myLabel.textColor = UIColor.yellow

                } else {
                    cell.myLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 75)
                    cell.myLabel.text = nil;
                    
                }
            } else if (indexPath.section != 0) {
                cell.myLabel.text = " Prog ".appendingFormat("%d", indexPath.section).appendingFormat("%d", indexPath.item+1)
            } else {
                cell.myLabel.text = " Time slot ".appendingFormat("%d", indexPath.section).appendingFormat("%d", indexPath.item+1)
                cell.myLabel.backgroundColor = UIColor.systemBlue
                cell.myLabel.textColor = UIColor.white
                cell.myLabel.textAlignment = NSTextAlignment.center


                
            }
        }
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var view: UICollectionReusableView;
        if (kind == UICollectionView.elementKindSectionHeader) {
            view = collectionview.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
            view.backgroundColor = UIColor.systemBlue;
        } else {
            view = collectionview.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath)
            view.backgroundColor = UIColor.purple;
        }
        return view;
    }
    
    // MARK: *** Data operation ***
    
    @objc func addAtOne() {
        numberItemsInsec1 += 1
        collectionview.insertItems(at: [IndexPath(item: 1, section: 0)])
    }
    
    @objc func removeAtOne() {
        numberItemsInsec1 -= 1
        collectionview.deleteItems(at: [IndexPath(item: 1, section: 0)])
    }
    
    // MARK: *** Layout ***
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize(width: 0, height: 0);
        if (indexPath.item == 0) {
            size = CGSize(width: CV_WIDTH*0.2, height: CV_WIDTH*0.2)
        } else if (indexPath.item == 1) {
            size = CGSize(width: CV_WIDTH*0.3, height: CV_WIDTH*0.3)
        } else if (indexPath.item == 2) {
            size = CGSize(width: CV_WIDTH*0.4, height: CV_WIDTH*0.4)
        } else if (indexPath.item == 3){
            size = CGSize(width: CV_WIDTH*0.2, height: CV_WIDTH*0.2)
        } else if (indexPath.item == 4) {
            size = CGSize(width: CV_WIDTH*0.2, height: CV_WIDTH*0.2)
        } else if (indexPath.item == 5) {
            size = CGSize(width: CV_WIDTH*0.2, height: CV_WIDTH*0.2)
        } else if (indexPath.item == 6) {
            size = CGSize(width: CV_WIDTH*0.2, height: CV_WIDTH*0.2)
        } else if (indexPath.item == 7) {
            size = CGSize(width: CV_WIDTH*0.5, height: CV_WIDTH*0.5)
        } else {
            size = CGSize(width: Int(ITEM_WIDTH), height: Int(ITEM_HEIGHT))
        }
        return size;
    }
    
    
    // MARK: *** Item movement ***

    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        if !collectionview.collectionViewLayout.isMember(of: CustomCollectionViewLayout.self) {
            return true
        }
        return false
    }

    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

    }
    
    @objc func gcAction(gc: UILongPressGestureRecognizer) {
        
        switch gc.state {
        
        case .began:

            let point: CGPoint = gc.location(in: collectionview)
            let indexPath = collectionview.indexPathForItem(at: point)
            if indexPath == nil {
                break
            }
            collectionview.beginInteractiveMovementForItem(at: indexPath!)
            
        case .changed:
 
            let point = gc.location(in: collectionview)
            collectionview.updateInteractiveMovementTargetPosition(point)
        
        case .ended:
            collectionview.endInteractiveMovement()

        default:
            collectionview.cancelInteractiveMovement()
        }
    }
    
    // MARK: *** Util methods ***
    
    func createTemplateFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.minimumLineSpacing = 1
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.itemSize = CGSize(width: Int(ITEM_WIDTH), height: Int(ITEM_HEIGHT))
        flowLayout.headerReferenceSize = CGSize(width: 50, height: 50)
        flowLayout.footerReferenceSize = CGSize(width: 50, height: 50)
        return flowLayout
    }
    
    @objc func setVerticalLayoutAttributes() {
        
        let flowLayout = createTemplateFlowLayout()
        //collectionview.collectionViewLayout.invalidateLayout()

        collectionview.setCollectionViewLayout(flowLayout, animated: false)
        collectionview.reloadData();
        
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        //collectionview.setContentOffset(CGPoint(x: 0, y: 0), animated: true)

        b4.isHidden = false
        b5.isHidden = false
    }
    
    @objc func setHorizontalLayoutAttributes() {

        let flowLayout = createTemplateFlowLayout()
        //collectionview.collectionViewLayout.invalidateLayout()

        collectionview.setCollectionViewLayout(flowLayout, animated: false)
        collectionview.reloadData();
        
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
                
        //collectionview.setContentOffset(CGPoint(x: 0, y: 0), animated: true)


        b4.isHidden = false
        b5.isHidden = false
    }
    
    @objc func setCustomLayoutAttributes() {
        
        let layout = CustomCollectionViewLayout()
        //collectionview.collectionViewLayout.invalidateLayout()
        collectionview.setCollectionViewLayout(layout, animated: false)
        numberItemsInsec1 = NSInteger(NUMBER_OF_TIME_SLOTS);
        numberItemsInsec2 = NSInteger(NUMBER_OF_TIME_SLOTS);
        
        collectionview.reloadData()
        
        //collectionview.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        
        b4.isHidden = true
        b5.isHidden = true
    }

}
