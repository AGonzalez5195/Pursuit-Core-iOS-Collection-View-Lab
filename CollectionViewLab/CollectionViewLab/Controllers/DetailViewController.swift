//
//  DetailViewController.swift
//  CollectionViewLab
//
//  Created by Anthony Gonzalez on 9/26/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var currentCountry: Country!
    @IBOutlet weak var CountryNameLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var CountryCapitalLabel: UILabel!
    
    @IBOutlet weak var CountryPopulationLabel: UILabel!
    
    @IBOutlet weak var CountryFlagImage: UIImageView!
    
    private func configureLayout() {
        CountryNameLabel.text = currentCountry.name
        CountryPopulationLabel.text = "Population: \(currentCountry.population)"
        if currentCountry.capital == "" {
            CountryCapitalLabel.text = "No Capital"
        } else {
            CountryCapitalLabel.text = "Capital: \(currentCountry.capital)"
        }
    }
    
    private func loadImage(){
        if currentCountry.name == "Mexico" {
            CountryFlagImage.image = #imageLiteral(resourceName: "dora")
            spinner.isHidden = true
        } else {
            spinner.startAnimating()
            spinner.isHidden = false
            ImageHelper.shared.getImage(urlStr: CountryAPIClient.getFlagImageURLString(from: currentCountry.alpha2Code)) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let imageFromOnline):
                        self.CountryFlagImage.image = imageFromOnline
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        
                    }
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        loadImage()
    }
}
