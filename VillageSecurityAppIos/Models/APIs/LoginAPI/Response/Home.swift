/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import SwiftyJSON

struct Home : Codable {
	let pk : Int?
	let number : String?
	let address : String?
	let zone : Int?
	let lat : String?
	let lon : String?

	enum CodingKeys: String, CodingKey {
		case pk = "pk"
		case number = "number"
		case address = "address"
		case zone = "zone"
		case lat = "lat"
		case lon = "lon"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		pk = try values.decodeIfPresent(Int.self, forKey: .pk)
		number = try values.decodeIfPresent(String.self, forKey: .number)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		zone = try values.decodeIfPresent(Int.self, forKey: .zone)
		lat = try values.decodeIfPresent(String.self, forKey: .lat)
		lon = try values.decodeIfPresent(String.self, forKey: .lon)
	}
    
    init(from json: JSON) {
        pk = json["pk"].intValue
        number = json["number"].stringValue
        address = json["address"].stringValue
        zone = json["name"].intValue
        lat = json["lat"].stringValue
        lon = json["lon"].stringValue
    }

}
