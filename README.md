# APIConnectionSample
A sample to handle API connection by Alamofire

## How to test 
- Run good case: change userName to `nguyentruongky` or your user name 
  -> Worker returns success response
- Run bad case: change userName to `nguyentruongky3390` or random string
  -> Worker returns fail response 
  
## How it works 

### ServiceConnector
`ServiceConnector` is a wrapper to use Alamofire in the back. Your code doesn't which library is running to connect to server. 

- `ServiceConnector` handles the authentication, any headers needed from server. You can send customer headers by pass the headers parameters in your request. I will show you later. 

```
static private func getHeader() -> [String: String]? {
    return ["Content-Type": "application/json",
            "X-Device-Id": "mobile_app"]
}
```
<br/>


- `ServiceConnector` also handles convert your endpoint to real url. 

```
private static func getUrl(from api: String) -> URL? {
    let baseUrl = "your_root_url" 
    let apiUrl = api.contains("http") ? api : baseUrl + api
    return URL(string: apiUrl)
}
```

> `baseUrl` should be in app setting, I write it here for instance.

<br/>

### Sample request function 

```
static func get(_ api: String,
                params: [String: Any]? = nil,
                headers: [String: String]?,
                success: @escaping (_ result: AnyObject, _ data: Data?) -> Void,
                fail: ((_ error: Error) -> Void)? = nil) {
    request(api, method: .get, params: params, header: header, success: success, fail: fail)
}
```

- If you want to send custom headers, in your worker, get the default headers, customize the headers and pass to request as parameter. 
- If you need to call other server API (not your main server), you need to pass a full path url (http://your_custom_url.com). The function ignores full path url. 

### AlamofireConnector

```
func response(response: DataResponse<Any>,
              withSuccessAction success: @escaping (_ result: AnyObject, _ data: Data?) -> Void,
              failAction fail: ((_ error: Error) -> Void)?) {
    let url = response.request?.url?.absoluteString ?? ""
    print(url)

    if let statusCode = response.response?.statusCode {
        // handle status code here: 401 -> show logout; 500 -> server error
    }

    if let error = response.result.error {
        fail?(error)
        return
    }

    guard let result = response.result.value else {
        // handle unknown error
        return
    }

    // handle special error convention from server
    // ...

    success(result as AnyObject, response.data)
}
```

You can easily handle general errors here. Special errors for different APIs will be handled in every worker. 

New support: return a `Data` to support `Codable` JSON decode. 

### Worker 

View `GetMyGithubWorker` struct 

### Data model 

View `MyGithub` file. I write 2 ways I used to decode JSON to model. 


