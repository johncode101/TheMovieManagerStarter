//
//  LoginViewController.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginViaWebsiteButton: UIButton!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        emailTextField.text = ""
        passwordTextField.text = ""
    }

    @IBAction func loginTapped(_ sender: UIButton) {
        TMDBClient.getRequestToken(completion: handleRequestTokenResponse(success:error:))
    }

    @IBAction func loginViaWebsiteTapped() {
        performSegue(withIdentifier: "completeLogin", sender: nil)
    }

    func handleRequestTokenResponse(success: Bool, error: Error?) {
        if success {
        print(TMDBClient.Auth.requestToken)
            DispatchQueue.main.async {
                TMDBClient.login(username: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "", completion: self.handleLogingResponse(success:error:))
            }
        }
    }
    
    func handleLogingResponse(success: Bool, error: Error?) {
        if success {
            print(TMDBClient.Auth.requestToken)
            TMDBClient.createSession(completion: handleSessionResponse(success:error:))
            
        }
    }
    
    func handleSessionResponse(success: Bool, error: Error?) {
        if success {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "completeLogin", sender: nil)
            }
        }
    }
}



//import Foundation
//import CoreFoundation
//
//// create a Codable struct called "POST" with the correct properties
//struct Post: Codable {
//    let userId: Int
//    let title: String
//    let body: String
//}
//
//// create an instance of the Post struct with your own values
//let post = Post(userId: 1, title: "udacity", body: "udacious")
//
//// create a URLRequest by passing in the URL
//var request = URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
//// set the HTTP method to POST
//request.httpMethod = "POST"
//// set the HTTP body to the encoded "Post" struct
//request.httpBody = try! JSONEncoder().encode(post)
//// set the appropriate HTTP header fields
//request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//// HACK: this line allows the workspace or an Xcode playground to execute the request, but is not needed in a real app
//let runLoop = CFRunLoopGetCurrent()
//// task for making the request
//let task = URLSession.shared.dataTask(with: request) {data, response, error in
//    print(String(data: data!, encoding: .utf8))
//    // also not necessary in a real app
//    CFRunLoopStop(runLoop)
//}
//task.resume()
//// not necessary
//CFRunLoopRun()
