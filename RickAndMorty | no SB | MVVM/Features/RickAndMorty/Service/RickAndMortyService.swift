//
//  RickAndMortyService.swift
//  RickAndMorty | no SB | MVVM
//
//  Created by Serhat  Şimşek  on 30.07.2023.
//

import Alamofire

enum RickyAndMortyServiceEndPoint: String {
    case BASE_URL = "https://rickandmortyapi.com/api"
    case PATH =  "/character"
    
    static func characterPath() -> String {
        return "\(BASE_URL.rawValue)\(PATH.rawValue)"
    }
}

protocol IRickAndMortyService {
    func fetchAllData(response:@escaping ([Result]?) -> Void)
}

struct RickyAndMortyService {
    
}

extension RickyAndMortyService: IRickAndMortyService {
    func fetchAllData(response:@escaping ([Result]?) -> Void) {
        AF.request(RickyAndMortyServiceEndPoint.characterPath()).responseDecodable(of: PostModel.self) { (model) in
            guard let data = model.value else {
                response(nil)
                return
            }
            
            response(data.results)
            
        }
    }
    
    
}
