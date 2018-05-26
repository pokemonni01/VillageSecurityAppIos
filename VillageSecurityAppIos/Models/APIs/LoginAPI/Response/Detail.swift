/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import SwiftyJSON

struct Detail : Codable {
	let pk : Int?
	let firstName : String?
	let lastName : String?
	let typeUser : TypeUser?
    let home : [Home]?

	enum CodingKeys: String, CodingKey {
		case pk = "pk"
		case firstName = "first_name"
		case lastName = "last_name"
		case typeUser = "type_user"
        case home = "home"
	}

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
		pk = try values.decodeIfPresent(Int.self, forKey: .pk)
		firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
		lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        typeUser = try values.decodeIfPresent(TypeUser.self, forKey: .typeUser)
        home = try values.decodeIfPresent([Home].self, forKey: .home)
	}
    
    init(from json: JSON) {
        pk = json["pk"].intValue
        firstName = json["first_name"].stringValue
        lastName = json["last_name"].stringValue
        typeUser = TypeUser(from: json["type_user"])
        home = [Home]()
        for oneHome in json["home"].arrayValue {
            home?.append(Home(from: oneHome))
        }
    }

}
