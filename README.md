# WLNetwork

## Example
```swift
API.getStockTW {
  switch $0 {
  case .success(let response):
      print(response)
  case .failure(let error):
      print(error)
  }
}
```

```swift
Task {
    let result = await API.getStockTW()
    switch result {
    case .success(let response):
        print(response)
    case .failure(let error):
        print(error)
    }
}
```

```swift
extension WLRequest {
    func send() async throws -> Self.Response? {
        try await WLClient(session: .shared).trySend(self)
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
```
