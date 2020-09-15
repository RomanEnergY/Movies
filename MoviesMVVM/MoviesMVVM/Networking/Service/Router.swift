//
//  Router.swift
//  MoviesMVVM
//
//  Created by 1234 on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

class Router<EndPoint: EndPointType>: NetworkRouter {
    private var task: URLSessionTask?
    
    func request(route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            if let request = try self.buildRequest(from: route) {
                task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                    completion(data, response, error)
                })
            }
            
        } catch {
            completion(nil, nil, error)
        }
        
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    private func buildRequest(from route: EndPoint) throws -> URLRequest? {
        if let url = URL(string: route.baseURL) {
            
            var request = URLRequest(url: url.appendingPathComponent(route.path),
                                     cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                     timeoutInterval: 10.0)
            
            request.httpMethod = route.httpMethod.rawValue
            
            do {
                switch route.task {
                case .request:
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    
                case .requestParameters(let bodyPatameters,
                                        let urlParameters):
                    try self.configureParameters(bodyPatameters: bodyPatameters,
                                                 urlParameters: urlParameters,
                                                 request: &request)
                    
                case .requestParametersAndHeaders(let bodyPatameters,
                                                  let urlParameters,
                                                  let additionHeaders):
                    self.addAdditionalHeaders(additionHeaders, request: &request)
                    try self.configureParameters(bodyPatameters: bodyPatameters,
                                                 urlParameters: urlParameters,
                                                 request: &request)
                }
                
                return request
                
            } catch {
                throw error
            }
        }
        
        return nil
    }
    
    private func configureParameters(bodyPatameters: Parameters?, urlParameters: Parameters?, request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyPatameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
            
        } catch {
            throw error
        }
    }
    
    private func addAdditionalHeaders(_ additionHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionHeaders else { return }
        headers.forEach({request.setValue($0.value, forHTTPHeaderField: $0.key)})
    }
}
