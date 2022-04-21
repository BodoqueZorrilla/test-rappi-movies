//
//  CoreDataManager.swift
//  test-rappi-movies
//
//  Created by Sergio Zorrilla Arellano on 19/04/22.
//

import Foundation
import CoreData

class CoreDataMovieManager: NSObject {

    static let shared = CoreDataMovieManager()
    
    func saveMovies(_ movies: [VOMovie]) {
        let moc = AppDelegate.appDelegate.managedObjectContext
        
        movies.forEach { movie in
            let coreDataMovie = MMovies(context: moc!)
            coreDataMovie.id = NSNumber(value: movie.id)
            coreDataMovie.title = movie.title
            coreDataMovie.overview = movie.overview
            coreDataMovie.genders = movie.genders
            coreDataMovie.date = movie.date
            coreDataMovie.vote_average = (movie.voteAverage) as NSNumber
            coreDataMovie.image = movie.image
            coreDataMovie.section = movie.section

            do {
                try moc!.save()
            } catch _ as NSError {
                print("Faile to save movie")
            }
        }
    }

    func getMovies() -> [VOMovie] {
        let moc = AppDelegate.appDelegate.managedObjectContext
        do {
            var arrayMovies = [VOMovie]()
            let fetchRequest: NSFetchRequest<MMovies> = MMovies.fetchRequest()
            let fetchedMovies = try moc!.fetch(fetchRequest)
            let mMovies = fetchedMovies
            if mMovies.count == 0 {
                return arrayMovies
            }
            mMovies.forEach { movie in
                let voMovie = VOMovie(id: movie.id as! Int64,
                                      title: movie.title!,
                                      overview: movie.overview!,
                                      date: movie.date!,
                                      voteAverage: Double(movie.vote_average!),
                                      genders: movie.genders!,
                                      image: movie.image!,
                                      section: movie.section!)
                arrayMovies.append(voMovie)
            }
            return arrayMovies
            
        } catch {
            fatalError("Failed to fetch user: \(error)")
        }
    }

    func getMovie(_ idMovie: Int) -> VOMovie {
        let moc = AppDelegate.appDelegate.managedObjectContext
        let movieFetchRequest: NSFetchRequest<MMovies> = MMovies.fetchRequest()
        movieFetchRequest.predicate = NSPredicate(format: "id = %@", NSNumber(value: Int(idMovie)))
        
        do {
            let fetchedMovie = try moc!.fetch(movieFetchRequest)
            let movie = fetchedMovie[0]
            return VOMovie(id: Int64(movie.id ?? 0),
                           title: movie.title ?? "",
                           overview: movie.overview ?? "",
                           date: movie.date ?? "",
                           voteAverage: Double(movie.vote_average ?? 0),
                           genders: movie.genders ?? "",
                           image: movie.image ?? "",
                           section: movie.section ?? "")
        } catch {
            fatalError("Failed to update Movie: \(error)")
        }
    }
    
    func updateMovie(_ movie: VOMovie) {
        let moc = AppDelegate.appDelegate.managedObjectContext
        let movieFetchRequest: NSFetchRequest<MMovies> = MMovies.fetchRequest()
        movieFetchRequest.predicate = NSPredicate(format: "id = %@", NSNumber(value: Int(movie.id)))
        
        do {
            let fetchedMovie = try moc!.fetch(movieFetchRequest)
            let coreDataMovie = fetchedMovie[0]
            coreDataMovie.overview = movie.overview
            coreDataMovie.genders = movie.genders
            coreDataMovie.date = movie.date
            coreDataMovie.vote_average = (movie.voteAverage) as NSNumber
            do {
                try moc!.save()
            } catch _ as NSError {
                
            }
        } catch {
            fatalError("Failed to update Movie: \(error)")
        }
    }

    func deleteAllData() {
        let moc = AppDelegate.appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = NSEntityDescription.entity(forEntityName: "MMovies", in: moc!)
        fetchRequest.includesPropertyValues = false
        do {
            if let results = try moc!.fetch(fetchRequest) as? [NSManagedObject] {
                
                moc?.performAndWait {
                    do {
                        for result in results {
                            moc!.delete(result)
                        }
                        
                        try moc!.save()
                    }catch {
                        print("deleteAllData", "Error in deleteAllData Movies")
                    }
                }
            }
        } catch {
            
        }
    }
}
