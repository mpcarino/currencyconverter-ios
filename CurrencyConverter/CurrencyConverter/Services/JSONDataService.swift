//
//  JSONDataService.swift
//  CurrencyConverter
//
//  Created by Marwin Carino on 10/11/22.
//

import Foundation

class JSONDataService<T: Decodable>: LocalDataServiceProtocol {
  // MARK: - Properties
  
  let decoder: JSONDecoder

  // MARK: - Init
  
  init(decoder: JSONDecoder = JSONDecoder()) {
    self.decoder = decoder
  }
  
  // MARK: - Methods
  
  func load(fileName: String) -> T? {
    guard let path = Bundle.main.path(forResource: fileName, ofType: fileExtension) else {
      return nil
    }

    let url = URL(fileURLWithPath: path)

    if let data = try? Data(contentsOf: url),
       let decodedData = try? decoder.decode(T.self, from: data) {
      return decodedData
    }

    return nil
  }
}

// MARK: - Getters

extension JSONDataService {
  var fileExtension: String {
    "json"
  }
}
