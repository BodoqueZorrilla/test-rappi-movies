//
//  MMoview+CoreDataClass.swift
//  test-rappi-movies
//
//  Created by Sergio Zorrilla Arellano on 19/04/22.
//

import Foundation
import CoreData

public class MMovies: NSManagedObject {

}

extension MMovies {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MMovies> {
        return NSFetchRequest<MMovies>(entityName: "MMovies")
    }

    @NSManaged public var id: NSNumber?
    @NSManaged public var title: String?
    @NSManaged public var overview: String?
    @NSManaged public var vote_average: NSNumber?
    @NSManaged public var genders: String?
    @NSManaged public var date: String?
    @NSManaged public var image: String?
    @NSManaged public var section: String?

}

class VOMovie: NSObject {
    
    var id: Int64 = 0
    var title: String = ""
    var overview: String = ""
    var date: String = ""
    var voteAverage: Double = 0.0
    var genders: String = ""
    var image: String = ""
    var section: String = ""
    
    init(id: Int64,
         title: String,
         overview: String,
         date: String,
         voteAverage: Double,
         genders:String,
         image: String,
         section: String) {
        
        self.id = id
        self.title = title
        self.overview = overview
        self.date = date
        self.voteAverage = voteAverage
        self.genders = genders
        self.image = image
        self.section = section
    }
    
}
