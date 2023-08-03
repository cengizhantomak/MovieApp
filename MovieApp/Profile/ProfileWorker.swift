//
//  ProfileWorker.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 8.07.2023.
//

import Foundation
import UIKit
import CoreData

protocol ProfileWorkingLogic: AnyObject {
    func getProfile(_ completion: @escaping (Result<MoviesResponse.Profile, RequestError>) -> Void)
    func deleteAllData(entity: String, completion: @escaping (Result<Void, Error>) -> Void)
}

final class ProfileWorker: ProfileWorkingLogic, HTTPClient {
    func getProfile(_ completion: @escaping (Result<MoviesResponse.Profile, RequestError>) -> Void) {
        sendRequest(endpoint: MoviesEndpoint.profile, responseModel: MoviesResponse.Profile.self, completion: completion)
    }
    
    func deleteAllData(entity: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else { continue }
                context.delete(objectData)
            }
            try context.save()
            completion(.success(()))
        } catch let error {
            completion(.failure(error))
        }
    }
}
