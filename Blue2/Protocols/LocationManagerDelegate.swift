//
//  LocationManagerDelegate.swift
//  Blue2
//
//  Created by mac.bernanda on 15/07/24.
//

protocol LocationManagerDelegate: AnyObject {
    func didUpdateLocation(latitude: Double, longitude: Double, cityName: String)
    func didFailWithError(error: Error)
}
