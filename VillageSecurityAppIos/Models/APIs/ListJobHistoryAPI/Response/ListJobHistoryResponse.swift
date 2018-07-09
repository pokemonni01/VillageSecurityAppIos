import Foundation
import SwiftyJSON

struct ListJobHistoryResponse {
    let status : String?
    let mListGuardHistory : [ListGuardHistory]?
    let message : String?
    let title : String?
    
    init(from json: JSON) {
        status = json["status"].stringValue
        message = json["message"].stringValue
        title = json["title"].stringValue
        mListGuardHistory = [ListGuardHistory]()
        for guardHistory in json["list_guard_history"].arrayValue {
            mListGuardHistory?.append(ListGuardHistory(from: guardHistory))
        }
    }
}
