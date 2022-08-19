//
//  DetailViewController.swift
//  day03
//
//  Created by Chan on 2022/08/19.
//

import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate {
	
	var receiveImage: UIImage?
	
	@IBOutlet var detailImageView: UIImageView!
	@IBOutlet var scrollView: UIScrollView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		detailImageView.image = receiveImage
		scrollViewConfig()
	}
	
	func scrollViewConfig() {
		scrollView.alwaysBounceVertical = false
		scrollView.alwaysBounceHorizontal = false
		
		scrollView.minimumZoomScale = 1.0
		scrollView.maximumZoomScale = 2.0
		scrollView.delegate = self
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	@available(iOS 2.0, *)
	public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return self.detailImageView
	}
	
	//	public func receiveImage(_ img: UIImageView) {
	//		receiveImage.image = img.image
	//	}
	
	/*
	 // MARK: - Navigation
	 
	 // In a storyboard-based application, you will often want to do a little preparation before navigation
	 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	 // Get the new view controller using segue.destination.
	 // Pass the selected object to the new view controller.
	 }
	 */
	
}
