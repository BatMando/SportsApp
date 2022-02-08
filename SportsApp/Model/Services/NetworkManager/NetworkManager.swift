//
//  NetworkManager.swift
//  SportsApp
//
//  Created by admin on 1/28/22.
//  Copyright © 2022 admin. All rights reserved.
//
import Foundation
import Alamofire
//https://www.thesportsdb.com/api/v1/json/2/all_sports.php
//https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php?s=Field Hockey
//https://www.thesportsdb.com/api/v1/json/2/search_all_teams.php?l=English Premier League
//https://www.thesportsdb.com/api/v1/json/2/searchfilename.php?e=English_Premier_League_2022-02-08
class NetworkManager {
    //MARK: - properties
    private let baseURL = "https://www.thesportsdb.com/api/v1/json/2/"
//    private let key     = "/k_gfvq4g4f"
    
    //To Do inject parameters
    
    
    
    
    //MARK: - HttpMethod
    func request<T: Decodable>(fromEndpoint: EndPoint, httpMethod: HTTPMethod = .get, parameters: Parameters? ,completion: @escaping (Swift.Result<T, Error>) -> Void) {
        
        let completionOnMain: (Swift.Result<T, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        guard let url = URL(string: "\(baseURL)\(fromEndpoint.rawValue)") else {
            completionOnMain(.failure(Errors.invalidUrl))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
    
        
        Alamofire.request(url, method: httpMethod, parameters: parameters, encoding: URLEncoding(destination: .queryString), headers: nil).responseJSON { (response) in
            print(parameters)
            print(response.response?.url)
            if let error = response.error {
                completionOnMain(.failure(error))
                return
            }
          
            guard let urlResponse = response.response else {
                return completionOnMain(.failure(Errors.invalidResponse))
            }
            if !(200..<300).contains(urlResponse.statusCode) {
                return completionOnMain(.failure(Errors.invalidStatusCode))
            }
//            print(response.response?.url)
            guard let data = response.data else { return }
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                completionOnMain(.success(response))
            } catch {
                debugPrint("Could not translate the data to the requested type. Reason: \(error.localizedDescription)")
                completionOnMain(.failure(error))
            }
        }
    }
}
