import UIKit

class ListJobHistoryViewController: BaseViewController, ListJobHistoryDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var rootView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    
    var mGuard: Guard?
    var mPKGuard: Int?
    var mDateSelect: String?
    var response: ListJobHistoryResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "ดูประวัติการทำงานรายคน"
        tableView.delegate = self
        tableView.dataSource = self
        getListJobHistory()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func getListJobHistory() {
        showProgress()
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
        cell.selectionStyle = .none
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailHistoryViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailHistoryViewController") as! DetailHistoryViewController
        detailHistoryViewController.listGuardHistory = response?.mListGuardHistory![indexPath.row]
        self.navigationController?.pushViewController(detailHistoryViewController, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.backgroundColor = UIColor.lightGray
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.backgroundColor = UIColor.white
    }
    
    func onRequestListJobHistorySuccess(response: ListJobHistoryResponse) {
        print(response)
        hideProgress()
        self.response = response
        if (self.response?.mListGuardHistory?.count ?? 0 == 0) {
            onNoData()
        } else {
            onNotNoData()
        }
        tableView.reloadData()
    }
    
    func onRequestListJobHistoryFail(response: ListJobHistoryResponse) {
        print(response)
        showAlertDialog(title: response.title ?? "", message: response.message ?? "")
        hideProgress()
    }
    
    func onRequestListJobHistoryError(title: String, message: String) {
        print(title+" "+message)
        hideProgress()
        showDefaultErrorDialog()
    }
    
    private func onNoData() {
        tableView.isHidden = true
        noDataLabel.isEnabled = false
    }
    
    private func onNotNoData() {
        tableView.isHidden = false
        noDataLabel.isEnabled = true
    }
}
