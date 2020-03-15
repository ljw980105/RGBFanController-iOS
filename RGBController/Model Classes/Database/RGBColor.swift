//
//  RGBColor.swift
//  RGBController
//
//  Created by Jing Wei Li on 3/14/20.
//  Copyright © 2020 Jing Wei Li. All rights reserved.
//

import CoreData
import UIKit

class RGBColor: NSManagedObject {
    static let fetchedResultsController: NSFetchedResultsController<RGBColor> = {
        let request: NSFetchRequest<RGBColor> = RGBColor.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "r", ascending: true)]
        let frc = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: DatabaseManager.context,
            sectionNameKeyPath: nil,
            cacheName: nil)
        return frc
    }()
    
    class func addColor(_ color: UIColor, context: NSManagedObjectContext = DatabaseManager.context) {
        let rgb = color.rgb()
        let rgbColor = RGBColor(context: context)
        rgbColor.b = Int64(rgb.b)
        rgbColor.r = Int64(rgb.r)
        rgbColor.g = Int64(rgb.g)
    }
    
    class func getAllColors(context: NSManagedObjectContext = DatabaseManager.context) -> [UIColor] {
        let fetchRequest: NSFetchRequest<RGBColor> = RGBColor.fetchRequest()
        fetchRequest.predicate = NSPredicate(value: true)
        if let colors = try? context.fetch(fetchRequest) {
            return colors.map { UIColor(red: CGFloat($0.r) / 255, green: CGFloat($0.g) / 255, blue: CGFloat($0.b) / 255, alpha: 0) }
        }
        return []
    }
}
