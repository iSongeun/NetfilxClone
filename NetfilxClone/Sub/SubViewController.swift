//
//  SubViewController.swift
//  NetfilxClone
//
//  Created by 이송은 on 2023/03/14.
//

import UIKit

class SubViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var movieModel : MovieModel? {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SubCell.self, forCellReuseIdentifier: "SubCell")
        tableView.register(DateHeaderView.self, forHeaderFooterViewReuseIdentifier: "DateHeaderView")
        tableView.rowHeight = UITableView.automaticDimension
        NetworkLayer.request(type: .movie) { model in
            self.movieModel = model
        }
        
    
        /*
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
         */
        
    }
}

extension SubViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return movieModel?.resultCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SubCell", for: indexPath) as? SubCell else { return UITableViewCell()}
        let movieResult = self.movieModel?.results[indexPath.section]
        cell.movieResult = movieResult
        return cell
    }
    /*
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
   
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DateHeaderView") as? DateHeaderView else {return UIView() }
      
        if let dateString = movieModel?.results[section].releaseDate {
            let formatter = ISO8601DateFormatter()
            if let date = formatter.date(from: dateString){
                let myFormatter = DateFormatter()
                myFormatter.dateFormat = "M월\ndd"
                let dateString = myFormatter.string(from: date)
                let attributedString = NSMutableAttributedString(string: dateString)
                let monthRange = NSRange(location: 0, length: dateString.count - 2)
                let dayRange = NSRange(location: dateString.count - 2 , length: 2)
                attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 14), range: monthRange)
                attributedString.addAttribute(.foregroundColor, value: UIColor.lightGray, range: monthRange)
                attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 24), range: dayRange)
                attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: dayRange)
                headerView.dateAttributeString = attributedString
            }
        }
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let result = movieModel?.results[indexPath.section]
        let VC = DetailViewController(nibName: "DetailViewController", bundle: nil)
        self.present(VC, animated: true)
        VC.modelResult = result

        
    }
}

extension SubViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        guard let visibleCells = tableView.visibleCells as? [SubCell] else{
            return
        }
        
        guard let firstCell = visibleCells.first else {
            return
        }
        
        if visibleCells.count == 1 {
            return
        }
        
        let secondCell = visibleCells[1]
        
        let firstCellPositionY = tableView.convert(firstCell.frame.origin, to: self.view).y
        let secondCellPositionY = tableView.convert(secondCell.frame.origin, to: self.view).y

        if firstCellPositionY > 50 {
            firstCell.movieWPlay()
            //others pause
            var otherCells = visibleCells
            otherCells.removeFirst()
            
            otherCells.forEach { cell in
                //cell stop
                cell.moviewStop()
            }
            
        }else {
            secondCell.movieWPlay()
            var otherCells = visibleCells
            otherCells.remove(at: 1)
            otherCells.forEach { cell in
                //cell stop
                cell.moviewStop()
            }
        }
        
    }
}
