//
//  ViewController.swift
//  iTunesSearchAPI
//
//  Created by Struzinski, Mark - Mark on 2/18/19.
//  Copyright © 2019 Struzinski, Mark - Mark. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var dataTask: URLSessionDataTask? = nil
    var results: [SearchResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    func search<T>(for type: T.Type,
                   with term: String) where T: MediaType  {
        let components = AppleiTunesSearchURLComponents<T>(term: term)
        guard let url = components.url else {
            fatalError("Error creating url")
        }
        
        self.dataTask?.cancel()
        self.dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                error == nil else {
                    fatalError("Networking error: \(String(describing: error)) \(response)")
            }
            
            do {
                let decoder = JSONDecoder()
                let searchResponse = try decoder.decode(SearchResponse.self, from: data)
                self.results = searchResponse.nonExplicitResults
            } catch {
                fatalError("Error decoding Search Results: \(error)")
            }
            
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
        }
        
        self.dataTask?.resume()
    }
}

