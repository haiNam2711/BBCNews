//
//  SignInViewController.swift
//  BBCNews
//
//  Created by Hai Nam on 17/10/2023.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInButtonClicked(_ sender: Any) {
        if let email = emailTextField.text, let password = passWordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in

              if let error = error {
                  print(email)
                  let alert = UIAlertController(title: "Sign In Failed", message: error.localizedDescription, preferredStyle: .alert)

                  let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                  }

                  alert.addAction(okAction)
                  self.present(alert, animated: true)
              } else {
                  let alert = UIAlertController(title: "Sign In Successfully", message: "", preferredStyle: .alert)
                  let navController = self.navigationController
                  let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                      navController?.popViewController(animated: true)
                  }

                  alert.addAction(okAction)
                  self.present(alert, animated: true)
              }

            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
