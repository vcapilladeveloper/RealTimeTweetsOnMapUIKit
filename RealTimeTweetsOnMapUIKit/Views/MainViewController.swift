//
//  MainViewController.swift
//  RealTimeTweetsOnMapUIKit
//
//  Created by Victor Capilla Developer on 29/8/21.
//

import UIKit
import MapKit

// This is the controller for the view
class MainViewController: UIViewController {
    // MARK: - Proprties
    private var textFromSearchBar = ""
    var viewModel = MainViewModel(APIService())

    // MARK: - Interface Builder Outlets and Actions
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func applyRule(_ sender: UIButton) {
        viewModel.searchAction(textFromSearchBar)
    }

    // MARK - View Controller Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // For manage the TextField content
        searchBar.delegate = self
        
        // By Default, hide searchButton
        searchButton.isEnabled = false

        // Specify the action to make when ViewModel execute the updateMap
        viewModel.updateMap = { [weak self] in
            DispatchQueue.main.async {
                self?.updateView()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpView()
        updateView()
    }

    // Default method for setup the view
    func setUpView() {
        for (index, time) in viewModel.lifeTimeOptions.enumerated() {
            segmentedControl.setTitle("\(time)", forSegmentAt: index)
        }
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
    }

    // Method for refresh the view, normaly from view model state changes.
    // Use ViewModel location for add this annotation on the Map View
    func updateView() {
        if let location = viewModel.location {
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.convertToLocationCoordinate()
            addAnnotationWithLifeTime(annotation)
        }
    }

    // Take the annotation argument, setup into the MapView, center to annotation coordinate
    // Start a timer scheduled using lifeTime from viewModel for Annotation Life Time.
    // The value LifeTime from ViewModel is changed with SegmentedControl
    private func addAnnotationWithLifeTime(_ annotation: MKPointAnnotation) {
        mapView.addAnnotation(annotation)
        mapView.centerToLocation(annotation.coordinate.convertToLocation())
        Timer.scheduledTimer(withTimeInterval: TimeInterval(viewModel.lifeTime), repeats: false) { [weak self] _ in
            self?.mapView.removeAnnotation(annotation)
        }
    }
    
    // Change the value of ViewModel LifeTime with segmentControl action
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        viewModel.changeLifeTime(sender.selectedSegmentIndex)
    }

}

extension MainViewController: UITextFieldDelegate {

    // Using this delegate method, enable or disable the button and set the text to the
    // private property textFromSearchBar.
    // I make this instead of edit ViewModel directy becouse the acton for
    // register the Rule is make it with the button action.
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = textField.text {
            searchButton.isEnabled = text == ""  ? false: true
            textFromSearchBar = text
        }
    }

}
