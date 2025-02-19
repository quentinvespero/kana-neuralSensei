import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Alternatively, if creating buttons programmatically:
        option1Button.addTarget(self, action: #selector(handleOption1), for: .touchUpInside)
        option2Button.addTarget(self, action: #selector(handleOption2), for: .touchUpInside)
    }
    
    @objc func handleOption1() {
        // Insert Option 1 logic here
        print("Option 1 tapped!")
    }
    
    @objc func handleOption2() {
        // Insert Option 2 logic here
        print("Option 2 tapped!")
    }
} 