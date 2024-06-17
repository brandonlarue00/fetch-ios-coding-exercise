import Foundation

struct RecipeDetails: Identifiable, Codable, Equatable {
    let id: String
    let name: String
    let instructions: String
    let thumbnailURL: String?
    let area: String?
    let category: String?
    let source: String?
    let youtube: String?
    let ingredients: [String?]
    let measures: [String?]

    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case instructions = "strInstructions"
        case thumbnailURL = "strMealThumb"
        case area = "strArea"
        case category = "strCategory"
        case source = "strSource"
        case youtube = "strYoutube"
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5
        case strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10
        case strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15
        case strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5
        case strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10
        case strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15
        case strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
    }
    
    init(
            id: String,
            name: String,
            instructions: String,
            thumbnailURL: String? = nil,
            area: String? = nil,
            category: String? = nil,
            source: String? = nil,
            youtube: String? = nil,
            ingredients: [String?],
            measures: [String?]
        ) {
            self.id = id
            self.name = name
            self.instructions = instructions
            self.thumbnailURL = thumbnailURL
            self.area = area
            self.category = category
            self.source = source
            self.youtube = youtube
            self.ingredients = ingredients
            self.measures = measures
        }

    // Custom initializer for decoding
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        instructions = try container.decode(String.self, forKey: .instructions)
        thumbnailURL = try? container.decode(String.self, forKey: .thumbnailURL)
        area = try? container.decode(String.self, forKey: .area)
        category = try? container.decode(String.self, forKey: .category)
        source = try? container.decode(String.self, forKey: .source)
        youtube = try? container.decode(String.self, forKey: .youtube)
        
        ingredients = [
            try? container.decodeIfPresent(String.self, forKey: .strIngredient1),
            try? container.decodeIfPresent(String.self, forKey: .strIngredient2),
            try? container.decodeIfPresent(String.self, forKey: .strIngredient3),
            try? container.decodeIfPresent(String.self, forKey: .strIngredient4),
            try? container.decodeIfPresent(String.self, forKey: .strIngredient5),
            try? container.decodeIfPresent(String.self, forKey: .strIngredient6),
            try? container.decodeIfPresent(String.self, forKey: .strIngredient7),
            try? container.decodeIfPresent(String.self, forKey: .strIngredient8),
            try? container.decodeIfPresent(String.self, forKey: .strIngredient9),
            try? container.decodeIfPresent(String.self, forKey: .strIngredient10),
            try? container.decodeIfPresent(String.self, forKey: .strIngredient11),
            try? container.decodeIfPresent(String.self, forKey: .strIngredient12),
            try? container.decodeIfPresent(String.self, forKey: .strIngredient13),
            try? container.decodeIfPresent(String.self, forKey: .strIngredient14),
            try? container.decodeIfPresent(String.self, forKey: .strIngredient15),
            try? container.decodeIfPresent(String.self, forKey: .strIngredient16),
            try? container.decodeIfPresent(String.self, forKey: .strIngredient17),
            try? container.decodeIfPresent(String.self, forKey: .strIngredient18),
            try? container.decodeIfPresent(String.self, forKey: .strIngredient19),
            try? container.decodeIfPresent(String.self, forKey: .strIngredient20)
        ]
        
        measures = [
            try? container.decodeIfPresent(String.self, forKey: .strMeasure1),
            try? container.decodeIfPresent(String.self, forKey: .strMeasure2),
            try? container.decodeIfPresent(String.self, forKey: .strMeasure3),
            try? container.decodeIfPresent(String.self, forKey: .strMeasure4),
            try? container.decodeIfPresent(String.self, forKey: .strMeasure5),
            try? container.decodeIfPresent(String.self, forKey: .strMeasure6),
            try? container.decodeIfPresent(String.self, forKey: .strMeasure7),
            try? container.decodeIfPresent(String.self, forKey: .strMeasure8),
            try? container.decodeIfPresent(String.self, forKey: .strMeasure9),
            try? container.decodeIfPresent(String.self, forKey: .strMeasure10),
            try? container.decodeIfPresent(String.self, forKey: .strMeasure11),
            try? container.decodeIfPresent(String.self, forKey: .strMeasure12),
            try? container.decodeIfPresent(String.self, forKey: .strMeasure13),
            try? container.decodeIfPresent(String.self, forKey: .strMeasure14),
            try? container.decodeIfPresent(String.self, forKey: .strMeasure15),
            try? container.decodeIfPresent(String.self, forKey: .strMeasure16),
            try? container.decodeIfPresent(String.self, forKey: .strMeasure17),
            try? container.decodeIfPresent(String.self, forKey: .strMeasure18),
            try? container.decodeIfPresent(String.self, forKey: .strMeasure19),
            try? container.decodeIfPresent(String.self, forKey: .strMeasure20)
        ]
    }
    
    // Implement encoding
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(instructions, forKey: .instructions)
        try container.encode(thumbnailURL, forKey: .thumbnailURL)
        try container.encode(area, forKey: .area)
        try container.encode(category, forKey: .category)
        try container.encode(source, forKey: .source)
        try container.encode(youtube, forKey: .youtube)
        
        // Encode ingredients
        try container.encode(ingredients[safe: 0], forKey: .strIngredient1)
        try container.encode(ingredients[safe: 1], forKey: .strIngredient2)
        try container.encode(ingredients[safe: 2], forKey: .strIngredient3)
        try container.encode(ingredients[safe: 3], forKey: .strIngredient4)
        try container.encode(ingredients[safe: 4], forKey: .strIngredient5)
        try container.encode(ingredients[safe: 5], forKey: .strIngredient6)
        try container.encode(ingredients[safe: 6], forKey: .strIngredient7)
        try container.encode(ingredients[safe: 7], forKey: .strIngredient8)
        try container.encode(ingredients[safe: 8], forKey: .strIngredient9)
        try container.encode(ingredients[safe: 9], forKey: .strIngredient10)
        try container.encode(ingredients[safe: 10], forKey: .strIngredient11)
        try container.encode(ingredients[safe: 11], forKey: .strIngredient12)
        try container.encode(ingredients[safe: 12], forKey: .strIngredient13)
        try container.encode(ingredients[safe: 13], forKey: .strIngredient14)
        try container.encode(ingredients[safe: 14], forKey: .strIngredient15)
        try container.encode(ingredients[safe: 15], forKey: .strIngredient16)
        try container.encode(ingredients[safe: 16], forKey: .strIngredient17)
        try container.encode(ingredients[safe: 17], forKey: .strIngredient18)
        try container.encode(ingredients[safe: 18], forKey: .strIngredient19)
        try container.encode(ingredients[safe: 19], forKey: .strIngredient20)
        
        // Encode measures
        try container.encode(measures[safe: 0], forKey: .strMeasure1)
        try container.encode(measures[safe: 1], forKey: .strMeasure2)
        try container.encode(measures[safe: 2], forKey: .strMeasure3)
        try container.encode(measures[safe: 3], forKey: .strMeasure4)
        try container.encode(measures[safe: 4], forKey: .strMeasure5)
        try container.encode(measures[safe: 5], forKey: .strMeasure6)
        try container.encode(measures[safe: 6], forKey: .strMeasure7)
        try container.encode(measures[safe: 7], forKey: .strMeasure8)
        try container.encode(measures[safe: 8], forKey: .strMeasure9)
        try container.encode(measures[safe: 9], forKey: .strMeasure10)
        try container.encode(measures[safe: 10], forKey: .strMeasure11)
        try container.encode(measures[safe: 11], forKey: .strMeasure12)
        try container.encode(measures[safe: 12], forKey: .strMeasure13)
        try container.encode(measures[safe: 13], forKey: .strMeasure14)
        try container.encode(measures[safe: 14], forKey: .strMeasure15)
        try container.encode(measures[safe: 15], forKey: .strMeasure16)
        try container.encode(measures[safe: 16], forKey: .strMeasure17)
        try container.encode(measures[safe: 17], forKey: .strMeasure18)
        try container.encode(measures[safe: 18], forKey: .strMeasure19)
        try container.encode(measures[safe: 19], forKey: .strMeasure20)
    }
}

// Safe indexing for arrays
extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
