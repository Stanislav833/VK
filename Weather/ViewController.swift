//
//  ViewController.swift
//  Weather
//
//  Created by Stanislav Vasilev on 03.03.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loadOne: UILabel!
    @IBOutlet weak var loadTwo: UILabel!
    @IBOutlet weak var loadThree: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         // отрисовка самих кружков
        settingLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
            // Второе — когда она пропадает
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }

    // Когда клавиатура появляется
        @objc func keyboardWasShown(notification: Notification) {
            
            // Получаем размер клавиатуры
            let info = notification.userInfo! as NSDictionary
            let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
            
            // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
            self.scrollView?.contentInset = contentInsets
            scrollView?.scrollIndicatorInsets = contentInsets
        }
        
        //Когда клавиатура исчезает
        @objc func keyboardWillBeHidden(notification: Notification) {
            // Устанавливаем отступ внизу UIScrollView, равный 0
            let contentInsets = UIEdgeInsets.zero
            scrollView?.contentInset = contentInsets
        }
    
    
    
    

    @IBAction func buttonTapped() {
        loadScreen()
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
            self.performSegue(withIdentifier: "to", sender: self)
        }
        if loginTextField.text == "admin",
           passwordTextField.text == "123456" {
            print("Password is correct")
        } else {
            showErrorAlert()
        }
    }
    

    func showErrorAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "Неверные данные пользователя", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    

    
    func loadScreen() {
        UIView.animate(withDuration: 0.5, delay: 0.2, options: [.autoreverse, .repeat]) {
            self.loadOne.alpha = 1
        } completion: { success in
            
        }
        UIView.animate(withDuration: 0.5, delay: 0.4, options: [.autoreverse, .repeat]) {
            self.loadTwo.alpha = 1
        } completion: { success in
            
        }
        UIView.animate(withDuration: 0.5, delay: 0.6, options: [.autoreverse, .repeat]) {
            self.loadThree.alpha = 1
        } completion: { success in
            
        }
    }
    
    
    
    func settingLoad() {
        loadOne.layer.masksToBounds = true
        loadOne.layer.cornerRadius = 10
        loadOne.alpha = 0
        loadTwo.layer.masksToBounds = true
        loadTwo.layer.cornerRadius = 10
        loadTwo.alpha = 0
        loadThree.layer.masksToBounds = true
        loadThree.layer.cornerRadius = 10
        loadThree.alpha = 0
    }
    
    
}
