//
//  MainViewController.swift
//  ARLearn
//
//  Created by MERT on 31.10.2021.
//

import Foundation
import UIKit
import Lottie

class MainViewController: UIViewController {
    
    //MARK: Outlets
    // Buton, Sayfa kontrolü ve Collection Vıew da eğer bir işlem yapılması gerekiyorsa onları kod satırına sürükleyip kullanılmak üzere tanımladığımız yer
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var skipButton: UIButton!
    //MARK: Properties
    var animationList = [AnimationModel]()
    var selectedRowIndex = -1
    
    // Burada eklediğimiz collection view un kullanılabilmesi için izinlerini alıyoruz
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        self.createAnimationsList()
        
    }
    // Bu kısımda ana ekrana geldiğimizde butonların görüntüsünün nasıl olması gerektiğini ve collection viewun yenilenmesi için gerekli kodun olduğunu görüyoruz
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        skipButton.addShadow(radius: 7)
        skipButton.alpha = 0.5
        skipButton.layer.cornerRadius = 12
        skipButton.isEnabled = false
        collectionView.reloadData()
        
    }
    // Animasyonların çalısması için gerekli fonsiyonun olduğu satır. Burada yüklediğimiz animasyonların isimleri ile ana ekrana basımı ve neler yazıcağını yazıyoruz
    func createAnimationsList() {
        self.animationList = [ AnimationModel(animationName: "AR", descriptionName: "Arttırılmış gerçeklik sayesinde sizde evinizi düzenleyebilir veya istediğiniz bir ürünün nerede nasıl duracağına karar verebilirsiniz"),AnimationModel(animationName: "navigation", descriptionName: "AR sayesinde bir yerden bir yere gitmek artık daha kolay"), AnimationModel(animationName: "question", descriptionName: "Kafanızdaki soruları gidermek için haydi uygulamalara göz atalım") ]
        collectionView.reloadData()
    }
    // Butona bastığımızda bizi kamera ekranına atmasını sağlayan kod satırı
    @IBAction func skipBtnPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "showApps", sender: self)
    }
}
// Bu kısımda classın dışına çıkıp collection view da lazım olan kodların eklendiği yer ilk kısım collection viewda kaçtane olması gerekiyorsa onu listede sayıp ekrana basıyoruz
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.animationList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let onboardingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as! MainCollectionViewCell
        let selectedItem = self.animationList[indexPath.item]
        onboardingCell.prepareCell(item: selectedItem)
        return onboardingCell
    }
    // Bu kısımda aşağıdaki sayfa kontrol çubuğunun kodları yer almaktadır
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let witdh = scrollView.frame.width - (scrollView.contentInset.left*2)
        let index = scrollView.contentOffset.x / witdh
        let roundedIndex = round(index)
        self.pageControl?.currentPage = Int(roundedIndex)
        
        if self.pageControl?.currentPage == 0 {
            skipButton.alpha = 0.5
            skipButton.isEnabled = false
            
        } else if self.pageControl?.currentPage == 1 {
            skipButton.alpha = 0.5
            skipButton.isEnabled = false
        }else if self.pageControl?.currentPage == 2 {
            skipButton.alpha = 1.0
            skipButton.isEnabled = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height: collectionView.frame.height)
    }
    
    
}
