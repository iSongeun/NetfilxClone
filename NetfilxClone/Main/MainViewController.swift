//
//  ViewController.swift
//  NetfilxClone
//
//  Created by 이송은 on 2023/03/14.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let headerView = MainTableHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        headerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 600)
        tableView.tableHeaderView = headerView
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(UINib(nibName: "MainCell", bundle: nil), forCellReuseIdentifier: "MainCell")
//        NetworkLayer.request(type: .movie){ movieModel in
//            print(movieModel)
//        }
        tableView.register(MainTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: "MainTableViewHeaderView")
        registObserver()
        
    }
    func registObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(presentDetailVC), name: NSNotification.Name("presentDetailVC"), object: nil)
    }

    @objc func presentDetailVC(noti : Notification){
        if let hasResult = noti.object as? Result{
            let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
            detailVC.modelResult = hasResult
            self.present(detailVC, animated: true)
        }
        
    }
}


extension MainViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MainTableViewHeaderView") as! MainTableViewHeaderView
        headerView.title = MediaType(rawValue: section)?.title
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return MediaType.allCases.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as? MainCell else {
            return UITableViewCell()
        }
        cell.requestMediaAPI(type: MediaType(rawValue: indexPath.section))
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

extension MainViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let area : CGFloat = 100
        let alpha = scrollView.contentOffset.y / area
        
        if let mainNavi =  self.navigationController as? MainNaviViewController {
            mainNavi.visualEffectView.alpha = alpha
        }
    }
}
