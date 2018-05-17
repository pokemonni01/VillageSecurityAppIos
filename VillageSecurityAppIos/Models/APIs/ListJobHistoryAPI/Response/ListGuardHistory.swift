import Foundation
import SwiftyJSON

struct ListGuardHistory {
    let pk : Int?
    let zone : Int?
    let time : String?
    let timeShow : String?
    let mGuard : Guard?
    
    init(from json: JSON) {
        pk = json["pk"].intValue
        zone = json["zone"].intValue
        time = json["time"].stringValue
        timeShow = json["time_show"].stringValue
        mGuard = Guard(from: json["guard"])
    }
}
