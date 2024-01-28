import SwiftUI
import MapKit
import Design

public struct MapView: View {
//    @State private var selectedCategory: String? = nil
    @State private var locations: [Location] = [
        Location(name: "Boga Heykeli", coordinate: CLLocationCoordinate2D(latitude: 40.990467, longitude: 29.029162)),
        Location(name: "Coffee Shop 1", coordinate: CLLocationCoordinate2D(latitude: 41.043544, longitude: 29.004255)),
        Location(name: "Coffee Shop 1", coordinate: CLLocationCoordinate2D(latitude: 41.06, longitude: 29)),
    ]

    @State private var categoryModalShown = false
    @State private var selectedCategory: String = "Select Location"
    @State private var selectedDetent: PresentationDetent = .fraction(0.2)
    @State private var dismissableMessage: Bool = false
    
    public init() {}
    
    public var body: some View {
        ZStack {
            MapLocationsView(locations: locations)
                .edgesIgnoringSafeArea([.top, .leading, .trailing])
                .bottomSheet(
                    presentationDetents: [.large, .fraction(0.2), .fraction(0.4), .fraction(0.5), .medium],
                    detentSelection: $selectedDetent,
                    isPresented: $categoryModalShown,
                    sheetCornerRadius: 12, 
                    interactiveDismissDisabled: false) {
                        CategoryPicker(selectedCategory: $selectedCategory) {
                            selectedDetent = .fraction(0.2)
                            dismissableMessage.toggle()
                        }
                    } onDismiss: {
                        
                    }
            if !categoryModalShown {
                VStack {
                    Spacer()
                    Button(action: {
                        categoryModalShown.toggle()
                    }) {
                        Text("See Locations")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()
                }
            }
            
            DismissableMessage(displayMessage: $dismissableMessage, delay: 3.0) {
                Text("Selected: \(selectedCategory)")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.black.opacity(0.75))
                    .cornerRadius(5)
                    .padding(.top, 80) // Adjust this to properly place on the screen
            }
        }
    }
}

#Preview {
    MapView()
}

// Define a simple model for location
struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let image: Image? = nil
    let backgroundColor: Color? = nil
}

// Map view
struct MapLocationsView: View {
    var locations: [Location]

    var body: some View {
        VStack {
            Map(position: .constant(.automatic)) {
                ForEach(locations) { location in
                    Annotation(coordinate: location.coordinate) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(location.backgroundColor ?? Color.teal)
                            if let image = location.image {
                                image
                                    .frame(width: 12, height: 12)
                                    .padding(5)
                            } else {
                                Image(systemName: "house")
                                    .frame(width: 24, height: 24)
                                    .padding(5)
                            }
                        }
                    } label: {
                        Text(location.name)
                    }

                }
//                Annotation("Columbia University", coordinate: .columbiaUniversity) {
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 5)
//                            .fill(Color.teal)
//                        Text("🎓")
//                            .padding(5)
//                    }
//                }
            }
            
//            Map(
//                coordinateRegion: .constant(
//                    MKCoordinateRegion(
//                        center: CLLocationCoordinate2D(latitude: 41.04, longitude: 29),
//                        latitudinalMeters: 10000,
//                        longitudinalMeters: 10000
//                    )
//                ),
//                annotationItems: locations
//            ) { location in
//                MapPin(coordinate: location.coordinate, tint: Color.orange)
//            }
        }
    }
}

struct CategoryPicker: View {
    @Environment(\.presentationMode) var presentationMode

    @Binding var selectedCategory: String
    let categories = ["Coffee Shops", "Where to Work", "Meeting Points"]
    var selectAction: () -> Void
    
    var body: some View {
        NavigationView {
            List {
                ForEach(categories, id: \.self) { category in
                    Button(action: {
                        selectedCategory = category
                        selectAction()
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
