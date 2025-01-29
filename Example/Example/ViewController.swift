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
        
        let req = StockTWRequest(parameters: .init(
            period1: "1626969600",
            period2: "1627277400",
            interval: "1d",
            events: "history")
        )
        Task {
            do {
                let resp = try await req.send()
                print(resp)
            }
            catch {
                print(error)
            }
    
        }

    }
}

