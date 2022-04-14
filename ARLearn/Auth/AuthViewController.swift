//
//  AuthViewController.swift
//  ARLearn
//
//  Created by MERT on 23.10.2021.
//

import Foundation
import UIKit


class AuthViewController: UIViewController {
    
    //MARK: Outlets
    // Buton ve şifreyi girdiğimiz yerde eğer bir işlem yapılması gerekiyorsa onları kod satırına sürükleyip kullanılmak üzere tanımladığımız yer
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    //MARK: Properties
     
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTF.addDoneButtonOnKeyboard()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.prepareUI()
    }
    // eğer ekranımızın üzerindeki buton ve şifre girdiğimiz yerin görsel hatlarını değiştirmek için kodları bu fonksiyon içine yazıyoruz
    func prepareUI() {
        passwordTF.attributedPlaceholder = NSAttributedString(string: "Şifre", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        loginButton.addShadow(radius: 7)
        loginButton.alpha = 0.5
        loginButton.layer.cornerRadius = 10
        self.hideKeyboardWhenTappedAround()

        
    }
    
    // Eğer nesneye yönelik bir kodlama gerekiyorsa ozaman butonu kod ekranına sürükleyip daha sonra aksiyonunun ne olmasını istiyorsak onu seçiyoruz. Mesela burada şifreyi doğru girdiğimde butona basılabilinecek ve buton görünür hale gelicek aksi halde butona basılamıcak ve görülemiyecek
    @IBAction func passwordCheck(_ sender: Any) {
        if passwordTF.text == "123" {
            loginButton.alpha = 1.0
            loginButton.isEnabled = true
        }else {
            loginButton.alpha = 0.5
            loginButton.isEnabled = false
        }
    }
    // Bu kısımda eğer şifre doğru ise bizi ana ekrana yönlendirme kodunu görüyorsunuz
    @IBAction func loginBtnPressed(_ sender: Any) {
        if passwordTF.text == "123"  {
            
            self.performSegue(withIdentifier: "sendMain", sender: self)
        } else {
            
        }
    }
    
    }

    
