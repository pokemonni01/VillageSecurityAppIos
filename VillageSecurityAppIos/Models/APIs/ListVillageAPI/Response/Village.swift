import Foundation
public struct Village : Codable {
	let pk : Int?
	let name : String?
	let address : String?
	let company : Int?

	enum CodingKeys: String, CodingKey {

		case pk = "pk"
		case name = "name"
		case address = "address"
		case company = "company"
	}

	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		pk = try values.decodeIfPresent(Int.self, forKey: .pk)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		company = try values.decodeIfPresent(Int.self, forKey: .company)
	}

}
