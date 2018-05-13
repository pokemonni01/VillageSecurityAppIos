import Foundation
import SwiftyJSON

public struct Zone : Codable {
	let pk : Int?
	let name : String?
	let number : Int?
	let village : Int?
	let lat : String?
	let lon : String?

	enum CodingKeys: String, CodingKey {

		case pk = "pk"
		case name = "name"
		case number = "number"
		case village = "village"
		case lat = "lat"
		case lon = "lon"
	}

	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		pk = try values.decodeIfPresent(Int.self, forKey: .pk)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		number = try values.decodeIfPresent(Int.self, forKey: .number)
		village = try values.decodeIfPresent(Int.self, forKey: .village)
		lat = try values.decodeIfPresent(String.self, forKey: .lat)
		lon = try values.decodeIfPresent(String.self, forKey: .lon)
	}
    
    init(from json: JSON) {
        pk = json["pk"].intValue
        name = json["name"].stringValue
        number = json["number"].intValue
        village = json["village"].intValue
        lat = json["lat"].stringValue
        lon = json["lon"].stringValue
    }

}
