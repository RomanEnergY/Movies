//
//  Router.swift
//  MoviesMVVM
//
//  Created by 1234 on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol: class {
    associatedtype EndPoint: EndPointProtocol
    func request(route: EndPoint, completion: @escaping (_ data: Data?,_ response: URLResponse?,_ error: Error?) -> ())
    func cancel()
}

final class NetworkService<EndPoint: EndPointProtocol>: NetworkServiceProtocol {
    private var urlSessionTask: URLSessionTask?
    
    public func request(route: EndPoint, completion: @escaping (_ data: Data?,_ response: URLResponse?,_ error: Error?) -> ()) {
        let session = URLSession.shared
        do {
            if let request = try self.buildRequest(from: route) {
                urlSessionTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
                    completion(data, response, error)
                })
            }
            
        } catch {
            completion(nil, nil, error)
        }
        
        self.urlSessionTask?.resume()
    }
    
    public func cancel() {
        self.urlSessionTask?.cancel()
    }
    
    private func buildRequest(from route: EndPoint) throws -> URLRequest? {
        if let url = URL(string: route.baseURL) {
            
            var request = URLRequest(url: url.appendingPathComponent(route.path),
                                     cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                     timeoutInterval: 10.0)
            
            request.httpMethod = route.httpMethod.rawValue
            
            do {
                switch route.task {
                case .requesNotParameters:
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    
                case .requestParameters(let bodyPatameters, let urlParameters):
                    try self.configureParameters(bodyPatameters: bodyPatameters, urlParameters: urlParameters, request: &request)
                    
                case .requestParametersAndHeaders(let bodyPatameters, let urlParameters, let additionHeaders):
                    self.addAdditionalHeaders(additionHeaders, request: &request)
                    try self.configureParameters(bodyPatameters: bodyPatameters, urlParameters: urlParameters, request: &request)
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
