//
//  DetailsViewController.swift
//  WorldCities
//
//  Created by Mona Qora on 1/3/20.
//  Copyright © 2020 Mona Qora. All rights reserved.
//

import UIKit
import MapKit

protocol CityDetailsViewProtocol {
    func setCityMapData(coordinate: CLLocationCoordinate2D)
    func setCityViewTitle(_ name: String?)
    func setupErrorHandling(error: ModelError)
}

class CityDetailsViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var cityModel:City!
    var cityDetailsViewPresenter: CityDetailsViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ViewTitles.cityDetailsViewTitle
        cityDetailsViewPresenter = CityDetailsViewPresenter.init(view: self, model: CityDetailsModel(), city: cityModel)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "More Info", style: .plain, target: self, action: #selector(loadCityInfo))
    }
    
    private func centerMap(_ coordinate: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan.init(latitudeDelta: Map.zoom, longitudeDelta: Map.zoom)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        mapView.setRegion(region, animated: true)
    }

    private func annotate(_ coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
    
    @objc func loadCityInfo(sender: UIButton?) {
        let deatilsVC = storyboard!.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
        self.navigationController?.pushViewController(deatilsVC, animated: true)
    }
}

extension CityDetailsViewController: CityDetailsViewProtocol, BaseViewProtocol {

    func setCityMapData(coordinate: CLLocationCoordinate2D) {
        DispatchQueue.main.async {
            self.centerMap(coordinate)
            self.annotate(coordinate)
            self.mapView.reloadInputViews()
        }
    }
    
    func setCityViewTitle(_ name: String?) {
        self.title = name ?? ViewTitles.cityDetailsViewTitle
    }
    
    func setupErrorHandling(error: ModelError) {
        setupAlertView(view: self, title: "Error", message: error.errorDescription ?? ViewTitles.cityDetailsViewTitle, buttonTitle: "Close")
    }
}


