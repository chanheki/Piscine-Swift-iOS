//
//  ImgCollectionViewController.swift
//  day03
//
//  Created by Chan on 2022/08/19.
//

import UIKit

private let reuseIdentifier = "Cell"

class ImgCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	/*
	 // MARK: - Navigation
	 
	 // In a storyboard-based application, you will often want to do a little preparation before navigation
	 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	 // Get the new view controller using [segue destinationViewController].
	 // Pass the selected object to the new view controller.
	 }
	 */
	
	// MARK: UICollectionViewDataSource
	
	override func numberOfSections(in collectionView: UICollectionView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 1
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of items
		return imagesItem.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)  -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? myImgClass else {
			return UICollectionViewCell()
		}
		// Configure the cell
		cellConfig(cell: cell)
		
		//	저장된 이미지 불러오기
		//		let img = UIImage(named: "\(imagesItem[indexPath.row]).jpeg")
		//		cell.imgView?.image = img
		
		//	url 사용하여 불러오기
		let imgUrl = URL(string: imagesURL[indexPath.row])
		DispatchQueue.global().async {
			let data = try? Data(contentsOf: imgUrl!)
			if data == nil {
				DispatchQueue.main.async {
					let alertController = UIAlertController(title: "Error", message: "Cannot acces to \(imgUrl!)", preferredStyle: UIAlertController.Style.alert)
					alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
					self.present(alertController, animated: true, completion: nil)
				}
			} else {
				if let image = UIImage(data: data!) {
					DispatchQueue.main.async {
						cell.imgView?.image = image
						cell.loader.hidesWhenStopped = true
						cell.loader.stopAnimating()
					}
				}
			}
		}
		return cell
	}
	
	func cellConfig(cell: UICollectionViewCell) {
		let cell = cell as! myImgClass

		cell.loader.startAnimating()
		cell.loader.color = (UIColor.white)
		cell.layer.borderColor = (UIColor.black.cgColor)
		cell.layer.backgroundColor = (UIColor.black.cgColor)
		cell.layer.borderWidth = 1
		cell.layer.cornerRadius = 5
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let itemSpacing: CGFloat = 10 // 가로에서 cell과 cell 사이의 거리
		//			let textAreaHeight: CGFloat = 65 // textLabel이 차지하는 높이
		let width: CGFloat = (collectionView.bounds.width - itemSpacing)/2 // 셀 하나의 너비
		let height: CGFloat = width //셀 하나의 높이
		
		return CGSize(width: width, height: height)
	}
	
	// MARK: UICollectionViewDelegate
	
	/*
	 // Uncomment this method to specify if the specified item should be highlighted during tracking
	 override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
	 return true
	 }
	 */
	
	/*
	 // Uncomment this method to specify if the specified item should be selected
	 override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
	 return true
	 }
	 */
	
	/*
	 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
	 override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
	 return false
	 }
	 
	 override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
	 return false
	 }
	 
	 override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
	 
	 }
	 */
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard let cell  = collectionView.cellForItem(at: indexPath) as? myImgClass else {
			print("error")
			return
		}
		
		guard let vc = self.storyboard?.instantiateViewController(identifier: "detailView") as? DetailViewController else {
			print("error")
			return
		}
		//instantiateViewController(withIdentifier:)는 스토리보드에서 특정 identifier를 받아 뷰 컨트롤러를 생성하고 데이터를 초기화하는 메소드입니다. identifier는 string 타입으로, 스토리보드에서 고유하게 뷰 컨트롤러를 구별할 수 있는 문자열입니다. 인터페이스 빌더에서 Storyboard ID 어트리뷰트와 같은 값을 넣으면 됩니다. 이 identifier는 뷰 컨트롤러 객체 자체 프로퍼티는 아닙니다. 스토리보드는 뷰 컨트롤러에 데이터를 놓을 위치를 찾는 데에 이 identifier를 사용합니다. 만약 스토리보드에 해당 identifier가 없다면 exception이 일어납니다. 반환값은 뷰 컨트롤러이며, 찾지 못하면 exception이 발생합니다.
		print("vc created")
		
		vc.receiveImage = cell.imgView.image
		// sub view에 있는 parentView를 현재 view로 설정한다.
		self.navigationController?.pushViewController(vc, animated: true)
	}
}
class myImgClass: UICollectionViewCell {
	@IBOutlet var imgView: UIImageView!
	@IBOutlet var loader: UIActivityIndicatorView!
}
