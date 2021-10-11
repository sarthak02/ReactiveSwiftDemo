import UIKit
class ViewController: UIViewController {
    var viewModel: ViewModel!
    //MARK: Properties
    @IBOutlet weak var pingLabel: UILabel!
    @IBOutlet weak var dingLabel: UILabel!
    @IBAction func ping(_ sender: UIButton) {
        // Send a trigger to start use case execution
        viewModel.onPing.value = ()
    }
    @IBAction func ding(_ sender: Any) {
        // Send a trigger to start use case execution
        viewModel.onDing.value = ()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Observe the ping count and display
        viewModel.pingLabelCount.observeValues { (text) in
            self.pingLabel.text = text
        }
        // Observe the dong count and display
        viewModel.dingLabelCount.observeValues { (text) in
            self.dingLabel.text = text
        }
    }
}

