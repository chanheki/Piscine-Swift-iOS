//
//  MapKitViewController.swift
//  day05
//
//  Created by Chan on 2022/08/23.
//

import UIKit
import MapKit
import CoreLocationUI

var currentCoorLatitude = "35.6646191"
var currentCoorLongitude = "139.7377873"

var dic: [String:[Any]] = ["seoul":[37.4882145, 127.0647887, "한국"],"tokyo":[35.6646191, 139.7377873,"일본"], "paris":[48.896607, 2.318501,"프랑스"]]

class PlacesList {
	static var places: [MKAnnotation] = [
		MKPointAnnotation(__coordinate: CLLocationCoordinate2D(latitude: 55.79714, longitude: 37.57983),
						  title: "School 21",
						  subtitle: "Moscow Campus"),
		MKPointAnnotation(__coordinate: CLLocationCoordinate2D(latitude: 48.89662, longitude: 2.31851),
						  title: "42",
						  subtitle: "Paris Campus"),
		MKPointAnnotation(__coordinate: CLLocationCoordinate2D(latitude: 45.77966, longitude: 4.75065),
						  title: "42",
						  subtitle: "Lyon Campus"),
		MKPointAnnotation(__coordinate: CLLocationCoordinate2D(latitude: 52.42673, longitude: 10.78987),
						  title: "42",
						  subtitle: "Wolfsburg Campus")
	]
}

class MapKitViewController: UIViewController, CLLocationManagerDelegate {
	
	@IBOutlet var myMap: MKMapView!
	@IBOutlet var mapSeg: UISegmentedControl!
	var currentCoor = false
	let locationManager = CLLocationManager()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
//		setAnnotation(latitudeValue: 37.4882145, longitudeValue: 127.0647887, delta: 0.1, title: "42서울", subtitle: "개포")
		
		dic.forEach {
			setAnnotation(latitudeValue: $0.value[0] as! CLLocationDegrees, longitudeValue: $0.value[1] as! CLLocationDegrees, delta: 0.1, title: $0.key, subtitle: $0.value[2] as! String, style: 0)
		}
		
		locationManager.delegate = self
		// 정확도를 최고로 설정
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		// 위치 데이터를 추적하기 위해 사용자에게 승인 요구
		locationManager.requestWhenInUseAuthorization()
		// 위치 업데이트를 시작
		locationManager.startUpdatingLocation()
		// 위치 보기 설정
		
		myMap.isZoomEnabled = true
		myMap.showsUserLocation = true
		myMap.addAnnotations(PlacesList.places)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		goLocation(latitudeValue: Double(currentCoorLatitude)!, longtudeValue: Double(currentCoorLongitude)!, delta: 0.01)
	}
	
	@IBAction func currentCoor(_ sender: Any) {
		if currentCoor == false {
			myMap.showsUserLocation = true
			myMap.setUserTrackingMode(.follow, animated: true)
		} else {
			myMap.showsUserLocation = false
			myMap.setUserTrackingMode(.none, animated: true)
		}
	}
	
	@IBAction func sgChange(_ sender: UISegmentedControl) {
		if sender.selectedSegmentIndex == 0 {
			myMap.mapType = .standard
		} else if sender.selectedSegmentIndex == 1 {
			myMap.mapType = .satellite
		} else {
			myMap.mapType = .hybrid
		}
	}
	
	// 위도와 경도, 스팬(영역 폭)을 입력받아 지도에 표시
	func goLocation(latitudeValue: CLLocationDegrees,
					longtudeValue: CLLocationDegrees,
					delta span: Double) -> CLLocationCoordinate2D {
		let pLocation = CLLocationCoordinate2DMake(latitudeValue, longtudeValue)
		let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
		let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
		myMap.setRegion(pRegion, animated: true)
		return pLocation
	}

	// 특정 위도와 경도에 핀 설치하고 핀에 타이틀과 서브 타이틀의 문자열 표시
	func setAnnotation(latitudeValue: CLLocationDegrees,
					   longitudeValue: CLLocationDegrees,
					   delta span: Double,
					   title strTitle: String,
					   subtitle strSubTitle: String,
					   style style: Int){
		let annotation = MKPointAnnotation()
		
		annotation.coordinate = goLocation(latitudeValue: latitudeValue, longtudeValue: longitudeValue, delta: span)
		annotation.title = strTitle
		annotation.subtitle = strSubTitle
		
		
		myMap.addAnnotation(annotation)
	}
	
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		if (annotation.isEqual(mapView.userLocation)) { return nil }
		let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
		annotationView.canShowCallout = true
		guard let title = annotation.title! else {
			return annotationView
		}
		guard let subtitel = annotation.subtitle! else {
			return annotationView
		}
		if title.contains("21") {
			annotationView.pinTintColor = UIColor.magenta
		} else if subtitel.contains("Paris") {
			annotationView.pinTintColor = UIColor.black
		} else if subtitel.contains("Wolfsburg") {
			annotationView.pinTintColor = UIColor.yellow
		} else {
			annotationView.pinTintColor = UIColor.red
		}
		return annotationView
	}
	
	func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let coor = manager.location?.coordinate {
			print("latitude" + String(coor.latitude) + "/ longitude" + String(coor.longitude))
			currentCoorLatitude = String(coor.latitude)
			currentCoorLongitude = String(coor.longitude)
			
		}
	}
	
	
	@IBAction func unwindToPlacesMapViewController(_ segue: UIStoryboardSegue) {
		locationManager.stopUpdatingLocation()
		currentCoor = false
//		updateTrackingButtonViev()
//		showPlace(coordinate: placeToShow.coordinate)
	}
	
}
