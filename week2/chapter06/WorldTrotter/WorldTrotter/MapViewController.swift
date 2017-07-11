//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Kangsoo on 07/07/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    // MARK: Properties
    var mapView: MKMapView?
    
    // MARK: Methods
    func mapTypeChanged(segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView?.mapType = .standard
        case 1:
            mapView?.mapType = .hybrid
        case 2:
            mapView?.mapType = .satellite
        default:
            break
        }
    }
    
    override func loadView() {
        // 지도 뷰 생성
        mapView = MKMapView()
        
        // 지도 뷰를 뷰 컨트롤러의 view로 지정
        view = mapView
        
        // Constraints
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self, action: #selector(mapTypeChanged), for: .valueChanged)

        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8)
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MapViewController loaded its view.")
    }
}
