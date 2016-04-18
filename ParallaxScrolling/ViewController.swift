//
//  ViewController.swift
//  ParallaxScrolling
//
//  Created by David on 2016/4/18.
//  Copyright © 2016年 David. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	let container = UIScrollView()
	let imageView = UIImageView()
	let maskView = UIView()
	let maskHeight: CGFloat = 360
	let imagegHeight: CGFloat = 500
	let imageView2 = UIImageView()
	let maskView2 = UIView()
	let imageView2Offset: CGFloat = 400

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		configureContainer()
		configureView()
		configureImageView()
		
		container.delegate = self
	}

	func configureContainer() {
		
		container.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
		container.contentSize = CGSize(width: UIScreen.mainScreen().bounds.width*2, height: UIScreen.mainScreen().bounds.height * 2)
		view.addSubview(container)
		container.pagingEnabled = true
		container.directionalLockEnabled = true
		container.backgroundColor = UIColor.blackColor()
	}
	
	func configureImageView() {
		imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: imagegHeight)
		imageView.image = UIImage(named: "a.png")
		imageView.contentMode = .ScaleAspectFill
		imageView.center = CGPoint(x: maskView.bounds.midX, y: maskView.bounds.midY)
		maskView.addSubview(imageView)
		
		imageView2.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: imagegHeight)
		imageView2.image = UIImage(named: "c.png")
		imageView2.contentMode = .ScaleAspectFill
		imageView2.center = CGPoint(x: maskView2.bounds.midX - imageView2Offset, y: maskView2.bounds.midY)
		maskView2.addSubview(imageView2)
	}
	
	func configureView() {
		maskView.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: maskHeight)
		maskView.clipsToBounds = true
		container.addSubview(maskView)
		maskView.layer.borderColor = UIColor.blackColor().CGColor
		maskView.layer.borderWidth = 3.0
		
		maskView2.frame = CGRect(x: UIScreen.mainScreen().bounds.width, y: 0, width: UIScreen.mainScreen().bounds.width, height: maskHeight)
		maskView2.clipsToBounds = true
		container.addSubview(maskView2)
		maskView2.layer.borderColor = UIColor.blackColor().CGColor
		maskView2.layer.borderWidth = 3.0
	}
	
	func update(offset: CGFloat) {
		imageView.center.y = maskView.bounds.midY + offset * 0.3
	}
	
	func enlarge(amount: CGFloat) {
		maskView.frame.size.height = maskHeight + amount
		imageView.frame.size.height = imagegHeight + amount
		imageView.center = CGPoint(x: maskView.bounds.midX, y: maskView.bounds.midY)
		maskView.frame.origin.y = -amount
		
		maskView2.frame.size.height = maskHeight + amount
		imageView2.frame.size.height = imagegHeight + amount
		imageView2.center = CGPoint(x: maskView2.bounds.midX - imageView2Offset, y: maskView2.bounds.midY)
		maskView2.frame.origin.y = -amount
	}
	
	func stayCentral(amount: CGFloat) {
//		maskView.frame.origin.x = amount
		imageView.frame.origin.x = amount * 0.7
		imageView2.frame.origin.x = amount * 0.7 - imageView2Offset + imageView2.bounds.width / 2
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

extension ViewController : UIScrollViewDelegate {
	func scrollViewDidScroll(scrollView: UIScrollView) {
		let amount = scrollView.contentOffset.y
		if amount > 0 {
			update(amount)
		} else {
			print(amount)
			enlarge(-amount)
		}
		let xAmount = scrollView.contentOffset.x
		stayCentral(xAmount)
	}
}

