//
//  Page1TableViewController.swift
//  NewsApp
//
//  Created by koki on 2022/01/30.
//

import UIKit
import SegementSlide

class Page6TableViewController: UITableViewController {
    
    private let imageview = UIImageView()
    private var newsItems = [NewsItems]()
    private let cellId = "cellId"
    private var currentElementName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupimageView()
       setupParser()
        
    }
    
    private func setupParser(){
        let urlString = "https://news.yahoo.co.jp/rss/topics/sports.xml"
        guard let url:URL = URL(string: urlString) else {return}
        guard let parser = XMLParser(contentsOf: url) else {return}
        parser.delegate = self
        parser.parse()
    }
    
    private func setupimageView(){
        tableView.backgroundColor = .clear
        
        let image = UIImage(named: "6")
        imageview.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: self.tableView.frame.size.height)
        imageview.image = image
        self.tableView.backgroundView = imageview
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        cell.backgroundColor = .clear
        let newsItem = self.newsItems[indexPath.row]
        cell.textLabel?.text = newsItem.title
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        cell.textLabel?.textColor = .white
        cell.textLabel?.numberOfLines = 3
        
        cell.detailTextLabel?.text = newsItem.url
        cell.detailTextLabel?.textColor = .white
        
        return cell
    }
    
   
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webviewController = WebViewController()
        webviewController.modalTransitionStyle = .crossDissolve
        let newsItem = newsItems[indexPath.row]
        UserDefaults.standard.set(newsItem.url, forKey: "url")
        present(webviewController, animated: true, completion: nil)
    }
}

extension Page6TableViewController: SegementSlideContentScrollViewDelegate {
    
    @objc var scrollView: UIScrollView{
        return tableView
    }
    
}

extension Page6TableViewController: XMLParserDelegate{
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
       currentElementName = nil
        if elementName == "item"{
            
            self.newsItems.append(NewsItems())
            
            
        }else{
            currentElementName = elementName
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if self.newsItems.count > 0 {
            
            let lastItem = self.newsItems[self.newsItems.count - 1]
            
            switch self.currentElementName{
            
            case "title":
                lastItem.title = string
            case "link":
                lastItem.url = string
            case "pubDate":
                lastItem.pubDate = string
                
            default:break
         }
      }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        self.currentElementName = nil
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        self.tableView.reloadData()
    }
 
}
