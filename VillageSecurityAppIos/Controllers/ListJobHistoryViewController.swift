import UIKit

class ListJobHistoryViewController: UIViewController, ListJobHistoryDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var rootView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var mGuard: Guard?
    var mPKGuard: Int?
    var mDateSelect: String?
    var response: ListJobHistoryResponse?
    private let mViewControllerUtils : ViewControllerUtils = ViewControllerUtils()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getListJobHistory()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func getListJobHistory() {
        mViewControllerUtils.showActivityIndicator(uiView: rootView)
        ListJobHistoryAPI.requestListJobHistory(self, pkGuard: mPKGuard ?? 0, type: "oneday", date: mDateSelect ?? DateTimeUtils.getCurrentDate())
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return response?.mListGuardHistory?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ListJobHistoryTableViewCell"
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! ListJobHistoryTableViewCell
        let listGuardHistory = response?.mListGuardHistory![indexPath.row]
        let guardFirstName = listGuardHistory?.mGuard?.first_name ?? ""
        let guardLastName = listGuardHistory?.mGuard?.last_name ?? ""
        cell.nameLabel.text = guardFirstName + "   " + guardLastName
        cell.timeLabel.text = listGuardHistory?.timeShow ?? ""
        return cell
    }
    
    func onRequestListJobHistorySuccess(response: ListJobHistoryResponse) {
        print(response)
        mViewControllerUtils.hideActivityIndicator(uiView: rootView)
        self.response = response
        tableView.reloadData()
    }
    
    func onRequestListJobHistoryFail(response: ListJobHistoryResponse) {
        print(response)
        mViewControllerUtils.hideActivityIndicator(uiView: rootView)
    }
    
    func onRequestListJobHistoryError(title: String, message: String) {
        print(title+" "+message)
        mViewControllerUtils.hideActivityIndicator(uiView: rootView)
    }
}
