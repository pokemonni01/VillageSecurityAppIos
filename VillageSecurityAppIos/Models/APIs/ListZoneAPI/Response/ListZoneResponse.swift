import Foundation
public struct ListZoneResponse : Codable {
	let status : String?
	let message : String?
	let title : String?
	let zone : [Zone]?
	let if1 : String?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case message = "message"
		case title = "title"
		case zone = "zone"
		case if1 = "if"
	}

	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		zone = try values.decodeIfPresent([Zone].self, forKey: .zone)
		if1 = try values.decodeIfPresent(String.self, forKey: .if1)
	}

}
