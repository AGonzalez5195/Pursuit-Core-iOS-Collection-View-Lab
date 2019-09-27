//
//  ViewController.swift
//  CollectionViewLab
//
//  Created by Anthony Gonzalez on 9/26/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var countryCollectionView: UICollectionView!
    
    var countries = [Country]() {
        didSet {
            DispatchQueue.main.async {
                self.countryCollectionView.reloadData()
                
            }
        }
    }
    
    var filteredCountries: [Country] {
        get {
            guard let searchString = searchString else { return countries }
            guard searchString != ""  else { return countries }
            return Country.getFilteredCountryByName(arr: countries, searchString: searchString)
        }
    }
    
    var searchString: String? = nil { didSet { self.countryCollectionView.reloadData()} }
    
    private func loadData() {
        CountryAPIClient.manager.getCountries { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let CountriesFromOnline):
                    self.countries = CountriesFromOnline
                    dump(CountriesFromOnline)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let segueIdentifer = segue.identifier else {fatalError("No identifier in segue")}
//        switch segueIdentifer {
//            
//        case "collectionToDetailSegue":
//            if let cell = sender as? CountryCollectionViewCell, let indexPath = self.countryCollectionView.indexPath(for: cell) {
//                let destVC = segue.destination as! DetailViewController
//                destVC.currentCountry = filteredCountries[indexPath.row]
//            }
//            
//        default:
//            fatalError("unexpected segue identifier")
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredCountries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let specificCountry = filteredCountries[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as! CountryCollectionViewCell
        
        cell.configureCell(from: specificCountry)
        
        return cell
    }
}



extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200  , height: 200)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 20, left: 50, bottom: 20, right: 50)
//    }
}


extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let detailVC = mainStoryBoard.instantiateViewController(withIdentifier: "detailVC") as! DetailViewController
        
        let specificCountry = countries[indexPath.row]
        
        detailVC.currentCountry = specificCountry
        
        self.navigationController?
            .pushViewController(detailVC, animated: true)
    }
}
