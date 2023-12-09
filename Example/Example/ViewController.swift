import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        API.getStockTW {
            switch $0 {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        }

        Task {
            let result = await API.getStockTW()
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        }

    }
}

