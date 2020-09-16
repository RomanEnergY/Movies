//
//  HTTPTask.swift
//  MoviesMVVM
//
//  Created by 1234 on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

/// enum HTTPTask конфигурацию параметров запроса.
///
/// Вы можете добавить в него столько различных вариантов запросов, сколько потребуется

public enum HTTPTask {
    case requesNotParameters
    case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
    case requestParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionHeaders: HTTPHeaders?)
}
