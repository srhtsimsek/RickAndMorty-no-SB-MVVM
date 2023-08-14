//
//  RickAndMortyViewModel.swift
//  RickAndMorty | no SB | MVVM
//
//  Created by Serhat  Şimşek  on 30.07.2023.
//

import Foundation
        
protocol IRickAndMortyViewModel {
    var rickAndMortyCharacters: [Result] { get set }
    var rickAndMortyService: IRickAndMortyService { get }
    var rickAndMortyOutput: RickAndMortyOutput? { get }
    
    func setDelegate(output: RickAndMortyOutput)
    func fetchItems()
    func changeLoading()
}

final class RickAndMortyViewModel: IRickAndMortyViewModel {
    var rickAndMortyOutput: RickAndMortyOutput?
    private var isLoading = false
    var rickAndMortyCharacters: [Result] = []
    var rickAndMortyService: IRickAndMortyService = RickyAndMortyService()
    
    init() {
        rickAndMortyService = RickyAndMortyService()
    }
    
    func setDelegate(output: RickAndMortyOutput) {
        rickAndMortyOutput = output
    }
    
    func fetchItems() {
        changeLoading()
        rickAndMortyService.fetchAllData { [weak self] response in
            self?.rickAndMortyCharacters = response ?? []
            self?.rickAndMortyOutput?.saveDatas(values: self?.rickAndMortyCharacters ?? [])
            self?.changeLoading()
        }
    }
    
    func changeLoading() {
        isLoading = !isLoading
        rickAndMortyOutput?.changeLoading(isLoad: isLoading)
    }
}
