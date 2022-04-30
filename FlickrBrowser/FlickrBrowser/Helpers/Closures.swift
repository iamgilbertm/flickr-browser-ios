//
//  Closures.swift
//  FlickrBrowser
//
//  Created by Gilbert Mendoza on 4/30/22.
//

import Alamofire
import Foundation

// MARK: - Typealiases

// Empty Result + Void Return
typealias EmptyResult<ReturnType> = () -> ReturnType

// Custom Result + Custom Return
typealias SingleResultWithReturn<T, ReturnType> = ((T) -> ReturnType)

// Custom Result + Void Return
typealias SingleResult<T> = SingleResultWithReturn<T, Void>

// () -> Void
typealias VoidResult = EmptyResult<Void>

// (Error) -> Void
typealias ErrorResult = SingleResult<AFError>
