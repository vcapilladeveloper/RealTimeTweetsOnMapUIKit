//
//  MainViewController.swift
//  RealTimeTweetsOnMapUIKit
//
//  Created by Victor Capilla Developer on 29/8/21.
//

import UIKit
import MapKit

class MainViewController: UIViewController {

    var viewModel = MainViewModel()
    
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    private var textFromSearchBar = ""
    @IBAction func applyRule(_ sender: UIButton) {
        viewModel.searchAction(textFromSearchBar)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchButton.isEnabled = false
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpView()
        updateView()
    }
    
    func setUpView() {
        for (index, time) in viewModel.lifeTimeOptions.enumerated() {
            segmentedControl.setTitle("\(time)", forSegmentAt: index)
        }
    }
    
    func updateView() {
        let london = MKPointAnnotation()
        london.title = "London"
        london.coordinate = CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)
       addAnnotationWithLifeTime(london)
    }
    
    func addAnnotationWithLifeTime(_ annotation: MKPointAnnotation) {
        mapView.addAnnotation(annotation)
        mapView.centerToLocation(annotation.coordinate.convertToLocation())
        Timer.scheduledTimer(withTimeInterval: 10, repeats: false) { [weak self] _ in
            self?.mapView.removeAnnotation(annotation)
        }
    }
    
}

extension MainViewController: UITextFieldDelegate {

    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = textField.text {
            searchButton.isEnabled = text == ""  ? false: true
            textFromSearchBar = text
        }
    }
    
}

private extension CLLocationCoordinate2D {
    func convertToLocation() -> CLLocation {
        return CLLocation(latitude: self.latitude, longitude: self.longitude)
    }
}

private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 100
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
