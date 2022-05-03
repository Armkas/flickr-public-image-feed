//
//  Api.swift
//  flickrFeed
//
//  Created by Pu Yue - PU YUE on 2022/05/02.
//

import Foundation

final class Api {
    static let shared = Api()
}

extension Api {

    func getData(_ text: String?, completion: @escaping ([Item]?, Error?) -> Void)  {
        let keyword = text ?? ""
        guard let url = URL(string: "https://www.flickr.com/services/feeds/photos_public.gne?format=json&tags=\(keyword)&nojsoncallback=1") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("API Error =", error.localizedDescription)
                completion(nil, error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            switch response.statusCode {
            case 200:
                print("API OK, status: ", response.statusCode)
                guard let data = data else {
                    print("API Get NO Data")
                    return
                }
                do {
                    let data = try JSONDecoder().decode(DataModel.self, from: data)
                    print("API Get Data successful")
                    completion(data.items, nil)
                } catch {
                    print("Error", error.localizedDescription)
                    completion(nil, error)
                }
            default:
                print("API Fail, status: ", response.statusCode)
            }
        }.resume()
    }
}
