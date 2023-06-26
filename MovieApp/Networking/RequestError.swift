//
//  RequestError.swift
//  Movie
//
//  Created by Cengizhan Tomak on 21.06.2023.
//

import Foundation

public enum RequestError: Error {
    case decode
    case invalidUrl
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unkown
}
