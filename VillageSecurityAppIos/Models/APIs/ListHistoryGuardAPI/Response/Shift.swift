/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import SwiftyJSON

struct Shift : Codable {
	let pk : Int?
	let name : String?
	let start_time : String?
	let end_time : String?

	enum CodingKeys: String, CodingKey {

		case pk = "pk"
		case name = "name"
		case start_time = "start_time"
		case end_time = "end_time"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		pk = try values.decodeIfPresent(Int.self, forKey: .pk)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		start_time = try values.decodeIfPresent(String.self, forKey: .start_time)
		end_time = try values.decodeIfPresent(String.self, forKey: .end_time)
	}
    
    init(from json: JSON) {
        pk = json["pk"].intValue
        name = json["name"].stringValue
        start_time = json["start_time"].stringValue
        end_time = json["end_time"].stringValue
    }
}
