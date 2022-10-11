import Foundation

class FileStream {


func write()-> String? {
let apiResponse = "
                  [
                      {
                          "title": "Easy Reading and Writing String to and from file in Swift",
                          "date": "2021-05-11"
                      },
                      {
                          "title": "Post 2",
                          "date": "2021-05-04"
                      }
                  ]"

let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("api_response.json")
try apiResponse.write(to: filePath, atomically: true, encoding: .utf8)

return "";
}
func read() -> String?
{
let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("api_response.json")
try result = String(contentsOf: filePath, encoding: .utf8)
return result


}
}


