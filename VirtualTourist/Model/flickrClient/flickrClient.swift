//
//  flickrClient.swift
//  VirtualTourist
//
//  Created by Yuan Gao on 12/28/22.
//

import Foundation

class flickrClient{
    static var lat:String = ""
    static var long:String = ""
    struct Auth{
        static let apiKey = "e681a4ede82d0363446a1433daf668ce"
        static let secret = "c81ad7f2547fca38"
        static let methodSearch = "flickr.photos.search"
    }
    
    enum Endpoints{
        static let base = "https://api.flickr.com/services/rest"
        case getPhotosURL(Int)
        var stringValue: String{
            switch self{
            case .getPhotosURL(let page):
                return Endpoints.base + "?api_key=" + Auth.apiKey + "&format=json&nojsoncallback=1&radius=1.6&radius_units=km&method="+Auth.methodSearch+"&lat="+lat+"&lon="+long+"&page=" + "\(page)" + "&extras=url_m"
            }

        }
        var url:URL{
            return URL(string: stringValue)!
        }
    }
    
    class func getPhotosURL(page: Int, latitude: Double, longitude: Double, completion: @escaping (Bool, Error?) -> Void){
        lat = "\(latitude)"
        long = "\(longitude)"
        var request = URLRequest(url: flickrClient.Endpoints.getPhotosURL(page).url)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else{
                DispatchQueue.main.async {
                    completion(false, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do{
                let responseObject = try decoder.decode(getPhotosURLResponse.self, from: data)
                print(responseObject.photos.total)
            }
            catch{
                //print("json parsing fails")
                DispatchQueue.main.async {
                    completion(false,error)
                }
            }
            
        }
        task.resume()
    }
    
}
    

