import UIKit

extension UILabel {
    
    //This method, in essence, changes the height of this label to be equal to the minimum possible height of the label (without changing or rearranging its contents).
    func heightToContent() {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = self.font
        label.text = self.text
     
        label.sizeToFit()
        self.frame.size.height = label.frame.height
    }
    
    func widthToContent() {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: self.frame.height))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = self.font
        label.text = self.text
        
        label.sizeToFit()
        self.frame.size.width = label.frame.width
    }
    
}
