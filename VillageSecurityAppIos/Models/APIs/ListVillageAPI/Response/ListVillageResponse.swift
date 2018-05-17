import Foundation
public struct ListVillageResponse : Codable {
	let status : String?
	let message : String?
	let title : String?
	let village : [Village]?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case message = "message"
		case title = "title"
		case village = "village"
	}

	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		village = try values.decodeIfPresent([Village].self, forKey: .village)
	}

}
