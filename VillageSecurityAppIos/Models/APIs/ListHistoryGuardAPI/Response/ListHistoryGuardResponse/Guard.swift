/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import SwiftyJSON

struct Guard : Codable {
	let pk : Int?
	let first_name : String?
	let last_name : String?
	let company : Company?
	let shift : Shift?
	let type_guard : Type_guard?
	let zone : Zone?
	let status : String?

	enum CodingKeys: String, CodingKey {

		case pk = "pk"
		case first_name = "first_name"
		case last_name = "last_name"
		case company
		case shift
		case type_guard
		case zone
		case status = "status"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		pk = try values.decodeIfPresent(Int.self, forKey: .pk)
		first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
		last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
		company = try Company(from: decoder)
		shift = try Shift(from: decoder)
		type_guard = try Type_guard(from: decoder)
		zone = try Zone(from: decoder)
		status = try values.decodeIfPresent(String.self, forKey: .status)
	}
    
    init(from json: JSON) {
        pk = json["pk"].intValue
        first_name = json["first_name"].stringValue
        last_name = json["last_name"].stringValue
        company = Company(from: json["company"])
        shift = Shift(from: json["shift"])
        type_guard = Type_guard(from: json["type_guard"])
        zone = Zone(from: json["zone"])
        status = json["status"].stringValue
    }

}
