//
//  Router.swift
//  Movies
//
//  Created by Roman Zverik on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol: class {
	associatedtype EndPoint: EndPointProtocol
	func request(endPoint: EndPoint, completion: @escaping (_ data: Data?,_ response: URLResponse?,_ error: Error?) -> ())
	func cancel()
}

final class NetworkService<EndPoint: EndPointProtocol>: NetworkServiceProtocol {
	private var urlSessionTask: URLSessionTask?
	
	public func request(endPoint: EndPoint, completion: @escaping (_ data: Data?,_ response: URLResponse?,_ error: Error?) -> ()) {
//		let session = URLSession.shared
//		do {
//			if let request = try self.buildRequest(from: endPoint) {
//				print("endPoint", endPoint)
//				urlSessionTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
//					completion(data, response, error)
//				})
//			}
//
//		} catch {
//			completion(nil, nil, error)
//		}
		
//		self.urlSessionTask?.resume()
		
		// TODO: Использование Stub объекта
		if let file = Bundle.main.url(forResource: "DataMoviesStub", withExtension: "json") {
			let data = try! Data(contentsOf: file)
			completion(data, nil, nil)
		}
	}
	
	public func cancel() {
		self.urlSessionTask?.cancel()
	}
	
	private func buildRequest(from endPoint: EndPoint) throws -> URLRequest? {
		if let url = URL(string: endPoint.baseURL) {
			
			var request = URLRequest(url: url.appendingPathComponent(endPoint.path),
									 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
									 timeoutInterval: 10.0)
			
			request.httpMethod = endPoint.httpMethod.rawValue
			
			do {
				switch endPoint.task {
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
