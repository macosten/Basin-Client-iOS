import UIKit

extension UIViewController {
    
    /**
     Calling this function will set up the View Controller in such a way that it will dismiss the keyboard when the view (not the keyboard) is tapped.
     */
    func hideKeyboardOnTap(){
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    /**
     Calling this function dismisses the keyboard. It is called by hideKeyboardOnTap(), but can also be called manually.
     */
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    /**
     This is just a lazy way to present a simple dialog box not meant to ask for input in any way.
     */
    
    func presentDialogBox(withTitle: String, withMessage: String){
        let alert = UIAlertController(title: withTitle, message: withMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { (_) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
