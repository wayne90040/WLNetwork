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
