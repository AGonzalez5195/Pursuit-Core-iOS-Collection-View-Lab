//
//  CountryCollectionViewCell.swift
//  CollectionViewLab
//
//  Created by Anthony Gonzalez on 9/26/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import UIKit

class CountryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var countryFlagImage: UIImageView!
    @IBOutlet weak var countryCapitalLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryPopulationLabel: UILabel!
    
    func configureCell(from country: Country) {
        
        countryNameLabel.text = country.name
        if country.capital == "" {
            countryCapitalLabel.text = "No Capital"
        } else {
            countryCapitalLabel.text = country.capital
        }
        countryPopulationLabel.text = "Population: \(country.population)"
        
        spinner.startAnimating()
        spinner.isHidden = false
        
        if country.name == "Mexico" {
            countryFlagImage.image = #imageLiteral(resourceName: "dora")
        } else {
            ImageHelper.shared.getImage(urlStr: CountryAPIClient.getFlagImageURLString(from: country.alpha2Code)) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let imageFromOnline):
                        self.countryFlagImage.image = imageFromOnline
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        
                    }
                }
            }
        }
    }
}
