//
//  QRCodeViewController.swift
//  QRCodeReader
//
//  Created by Kunasilan on 29/10/20.
//  Copyright © 2020 Kunasilan. All rights reserved.
//

import UIKit
import SafariServices
import CoreLocation

class QRCodeViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var label: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var signedIntoArray: [signedIn] = []
    
    var scanned: Bool = false
    
    let manager: CLLocationManager = CLLocationManager()
    var latitude: CLLocationDegrees = 0.0
    var longitude: CLLocationDegrees = 0.0
    var userCoordinate = CLLocation()
    
    var signedIntoLocation: String = ""
    
    private var notificationPublisher = NotificationPublisher()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let first = locations.first {
            userCoordinate = first
        }
        latitude = userCoordinate.coordinate.latitude
        longitude = userCoordinate.coordinate.longitude
        print("\(userCoordinate.coordinate.latitude),\(userCoordinate.coordinate.longitude)")
        self.manager.stopUpdatingLocation()
    }
    
    func checkDistanceBetweenPoints() {
        for entry in signedIntoArray {
            let coordinate = CLLocation(latitude: entry.latitude, longitude: entry.longitude)
            let distance = userCoordinate.distance(from: coordinate)
            
            if distance > 600 {
                print("Distance is more than 600")
                notificationPublisher.sendNotification(title: "Safe Entry", subtitle: "Did not sign out", body: "Did you sign out of \(entry.title)", badge: 1, delayInterval: nil)
            }
            
            print("\(entry.latitude),\(entry.longitude)")
            print("\(latitude),\(longitude)")
            print("The distance is \(distance)")
            print(signedIntoArray.count)
        }
    }
    
    var finalURL = " "
    override func viewDidLoad() {
        Timer.scheduledTimer(withTimeInterval: 1800, repeats: true) { (t) in
            self.checkDistanceBetweenPoints()
        }
//        Timer.scheduledTimer(timeInterval: 1800.0, target: self, selector: #selector(checkDistanceBetweenPoints), userInfo: nil, repeats: true)
        super.viewDidLoad()
        let nib = UINib(nibName: "SignedInViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "SignedInViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension

        
//        let controller = QRScannerController()
//        controller.delegate = self
//        label.text = finalURL

//        didTapWatchNow(url: finalURL)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func didTapWatchNow(url: String) {
//        if let testurl = URL(string: url) {
//            let videoURL = URL(string: url)!
//            let safariVC = SFSafariViewController(url: videoURL)
//            present(safariVC, animated: true, completion: nil)
//        }
//    }
    func createSignIntoArray(title: String, url: String) {
//        print("The location is \(self.signedIntoLocation)")
        if scanned == true {
            return
        }
        
        let signIn = signedIn(url: url, title: title, latitude: latitude, longitude: longitude)
        print("The latitude is \(latitude)")
        signedIntoArray.append(signIn)
        
        let indexPath = IndexPath(row: signedIntoArray.count - 1, section: 0)
        
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
        scanned = true
        print(signedIntoArray.count)
    }
    
    func launchWebKit() {
        let vc = WebController()
        let tempURL = URL(string: self.finalURL)
        vc.url = tempURL
        vc.completionHandler = {text in
            self.label.text = text
            self.signedIntoLocation = text!
            self.createSignIntoArray(title: self.label.text ?? "can't find location", url: self.finalURL)
        }
        present(vc, animated: true)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//            self.createSignIntoArray(title: self.signedIntoLocation ?? "cant find location", url: self.finalURL)
//        }
        
//        self.signedIntoLocation = vc.pageLocation
        
        
        
//        if scanned == true {
//            return
//        }
//        if let url = URL(string: decodedURL) {
////            let signIn = signedIn(url: decodedURL, title: "ToSentPage")
////            signedIntoArray.append(signIn)
//            let vc = WebViewController(url: url, title: "SentPage")
//            let navVC = UINavigationController(rootViewController: vc)
//            self.present(navVC, animated: true)
////            scanned = true
////            print(signedIntoArray.count)
//        }
        
    }
    
    @IBAction func presentMap(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "openMap") as! MapViewController
        vc.mapArray = signedIntoArray
        vc.userCoordinate = userCoordinate
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    // MARK: - Navigation
    
    @IBAction func scanQR(_ sender: Any) {
        scanned = false
        let vc = storyboard?.instantiateViewController(identifier: "scanQR") as! QRScannerController
        vc.modalPresentationStyle = .fullScreen
        vc.completionHandler = {text in
            self.label.text = text
            self.finalURL = text!
            self.launchWebKit()
            
        }
//        self.createSignIntoArray(title: self.signedIntoLocation, url: self.finalURL)
        present(vc, animated: true)
        
    }
    
//    @IBAction func unwindToHomeScreen(segue: UIStoryboardSegue) {
//        dismiss(animated: true, completion: nil)
//    }

}


// for each cell check out button function
extension QRCodeViewController: SignedInCellDelegate {

    func didTapCheckOut(url: String, sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        guard let indexPath = tableView.indexPathForRow(at: point) else {return}
        print(indexPath.row)
        tableView.beginUpdates()
        signedIntoArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
        
        if let tempURL = URL(string: url) {
            let vc = WebController()
            vc.url = tempURL
            self.present(vc, animated: true)
        }
        
//        if let decodedURL = URL(string: url) {
//            let vc = WebViewController(url: decodedURL, title: "SentPage")
//            let navVC = UINavigationController(rootViewController: vc)
//            self.present(navVC, animated: true)
//        }
    }
}

// for table view implementation
extension QRCodeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return signedIntoArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SignedInViewCell", for: indexPath) as! SignedInViewCell
        
//        print(indexPath.row)
        
        let signIn = signedIntoArray[indexPath.row]
//        cell.videoTitle.text = myData[indexPath.row]
        cell.setSignInTitle(signedIn: signIn)
        cell.delegate = self
        cell.textLabel?.numberOfLines = 0
//        cell.myImageView.backgroundColor = .red
        
//        cell.textLabel?.text = myData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            tableView.beginUpdates()
//            signedIntoArray.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//            tableView.endUpdates()
//        }
//    }

}


