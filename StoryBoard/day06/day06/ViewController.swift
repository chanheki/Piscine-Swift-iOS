//
//  ViewController.swift
//  day06
//
//  Created by Chan on 2022/08/24.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
	@IBOutlet var pinchGestureRecognizer: UIPinchGestureRecognizer!
	@IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
	@IBOutlet var rotationGestureRecognizer: UIRotationGestureRecognizer!
	
	var dynamicAnimator = UIDynamicAnimator()
	var motionManager = CMMotionManager()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		dynamicAnimator = UIDynamicAnimator(referenceView: view)
		dynamicAnimator.addBehavior(gravity)
		dynamicAnimator.addBehavior(collider)
		dynamicAnimator.addBehavior(itemBehaviour)
		
		if motionManager.isAccelerometerAvailable {
			motionManager.accelerometerUpdateInterval = 0.1
			motionManager.startAccelerometerUpdates(to: OperationQueue.main, withHandler: handleAccelerometer)
		}
	}
	
	@IBAction func touchTap(_ sender: UITapGestureRecognizer) {
		let location = sender.location(in: view)
		let frame = CGRect(
			x: location.x - Shape.size.width / 2,
			y: location.y - Shape.size.height / 2,
			width: Shape.size.width,
			height: Shape.size.height)
		let element = Shape(frame: frame)
		element.isUserInteractionEnabled = true
		element.clipsToBounds = true
		view.addSubview(element)
		
		dynamicStyle(element)
		gestureInit(element)
	}
	
	@IBAction func panGesture(_ sender: UIPanGestureRecognizer) {
		guard let element = sender.view else {return print("pan error")}
		
		switch sender.state {
		case .began:
			gravity.removeItem(element)
		case .changed:
			element.center = sender.location(in: self.view)
			dynamicAnimator.updateItem(usingCurrentState: element)
		case .ended:
			gravity.addItem(element)
			
		default:
			break
		}
	}
	
	@IBAction func rotationGesture(_ sender: UIRotationGestureRecognizer) {
		guard let element = sender.view else {return print("rotation error")}
		
		switch sender.state {
		case .began:
			gravity.removeItem(element)
		case .changed:
			element.transform = CGAffineTransform(rotationAngle: sender.rotation)
			dynamicAnimator.updateItem(usingCurrentState: element)
		case .ended:
			gravity.addItem(element)
			
		default:
			break
		}
	}
	
	@IBAction func pinchGesture(_ sender: UIPinchGestureRecognizer) {
		guard let element = sender.view else {return print("pinch error")}
		
		switch sender.state {
		case .began:
			gravity.removeItem(element)
		case .changed:
			element.bounds.size.width *= sender.scale
			element.bounds.size.height *= sender.scale
			if element.layer.cornerRadius != 0 {
				element.layer.cornerRadius *= sender.scale
			}
			sender.scale = 1
			dynamicAnimator.updateItem(usingCurrentState: element)
		case .ended:
			gravity.addItem(element)
			
		default:
			break
		}
	}
	
	private let itemBehaviour: UIDynamicItemBehavior = {
		let itemBehaviour = UIDynamicItemBehavior()
		itemBehaviour.elasticity = 0.5
		return itemBehaviour
	}()
	
	private let gravity: UIGravityBehavior = {
		let gravity = UIGravityBehavior()
		gravity.magnitude = 1.5
		return gravity
	}()
	
	private let collider: UICollisionBehavior = {
		let collider = UICollisionBehavior()
		collider.translatesReferenceBoundsIntoBoundary = true
		return collider
	}()
	
	func handleAccelerometer(data: CMAccelerometerData?, error: Error?) {
		if let accelerometerData = data {
			let accelerationX = CGFloat(accelerometerData.acceleration.x);
			let accelerationY = CGFloat(accelerometerData.acceleration.y);
			let accelerationVector = CGVector(dx: accelerationX, dy: -accelerationY);
			gravity.gravityDirection = accelerationVector;
		}
	}
	
	func gestureInit(_ e: Shape) {
		e.addGestureRecognizer(panGestureRecognizer)
		e.addGestureRecognizer(pinchGestureRecognizer)
		e.addGestureRecognizer(rotationGestureRecognizer)
	}
	
	func dynamicStyle(_ e: Shape) {
		collider.addItem(e)
		gravity.addItem(e)
		itemBehaviour.addItem(e)
	}
}
