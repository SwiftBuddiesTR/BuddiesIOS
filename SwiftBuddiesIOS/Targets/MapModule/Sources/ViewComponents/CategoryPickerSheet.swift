//
//  CategoryPickerSheet.swift
//  Map
//
//  Created by Oğuzhan Abuhanoğlu on 5.06.2024.
//

import SwiftUI
import SwiftData

struct CategoryPicker: View {
    @Environment(\.presentationMode) var presentationMode

    @Binding var selectedCategory: String
    @Query private var items: [EventModel]
    
    @State private var selectedItems: [EventModel] = []
    
    private let categories = [
        "Meeting",
        "Study Body",
        "Place to work",
        "Swift Buddies Event"
    ]
    
    var selectAction: () -> Void
    
    var body: some View {
        NavigationView {
            List {
                ForEach(categories, id: \.self) { category in
                    Button(action: {
                        print("all items count: \(items.count)")
                        selectedCategory = category
                        selectedItems.removeAll()
                        for item in items {
                            if selectedCategory == item.category {
                                selectedItems.append(item)
                                /*for si in selectedItems {
                                    print(si.name)
                                }*/
                            }
                        }
                      
                        print("selected items \(selectedItems.count)")
                    }) {
                        Text(category)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Select Category")
            .navigationBarItems(trailing: Button("Dismiss") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
