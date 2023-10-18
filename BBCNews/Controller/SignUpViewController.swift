//
//  SignUpViewController.swift
//  BBCNews
//
//  Created by Hai Nam on 17/10/2023.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var rePassWordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func signUpClicked(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text, let rePassword = rePassWordTextField.text {
            if (password != rePassword) {
                let alert = UIAlertController(title: "Sign Up Failed", message: "Password is not equal.", preferredStyle: .alert)

                let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                }

                alert.addAction(okAction)
                self.present(alert, animated: true)
            }
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
                if let error = error {
                    let alert = UIAlertController(title: "Sign Up Failed", message: error.localizedDescription, preferredStyle: .alert)

                    let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                    }

                    alert.addAction(okAction)
                    self.present(alert, animated: true)
                } else {
                    let alert = UIAlertController(title: "Sign Up Successfully", message: "", preferredStyle: .alert)
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
