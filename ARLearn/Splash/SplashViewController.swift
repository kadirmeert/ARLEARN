//
//  SplashViewController.swift
//  ARLearn
//
//  Created by MERT on 23.10.2021.
//

import Foundation
import UIKit // UI komutlu kodları kullanmak için eklediğim uzantı

// Splash ekranı ve her ekran kod satırlarının başında açmış olduğum class lardan bir tanesi bu classı açarken bu ekranın adı ile aynı olmalıdır aksi halde hata alırız
class SplashViewController: UIViewController {
    
    // Uygulamayı çalıştırdıktan sonra uygulama içinde ilk yapılacakları komut ettiğim yer
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // Üstteki komut ile aynı olup bazı yerlerde üstteki komutun yetişemediği yerlerde devreye giren komut satırı
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    // Splash ekranının süresi dolduktan sonra Şifre giriş ekranına gitmesini komut ettiğim kod satırı
        self.performSegue(withIdentifier: "sendAuth", sender: self)
    }
    
    
}
