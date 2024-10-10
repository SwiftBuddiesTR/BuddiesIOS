//
//  NewEventViewViewModel.swift
//  Map
//
//  Created by Oğuzhan Abuhanoğlu on 18.07.2024.
//

import Foundation
import SwiftData

class LocationSelectionViewViewModel: ObservableObject {
    
    func addItem(modelContext: ModelContext, id: String, category: EventCategory.RawValue, name: String, about: String, startDate: String, dueDate: String, latitude: Double, longitude: Double) {
        let event = EventModel(category: category, name: name, aboutEvent: about, startDate: startDate, dueDate: dueDate, latitude: latitude, longitude: longitude)
        modelContext.insert(event)
    }
}
