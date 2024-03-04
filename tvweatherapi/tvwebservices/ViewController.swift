import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var currentSummary: UILabel!


    @IBOutlet weak var currentHumidity: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
    }

    func fetchData() {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Chicago,us&APPID=da8eb2d8e10fb0e865adeb0d137cf7c8") else {
            print("Invalid URL")
            return
        }

        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let parsed = try JSONSerialization.jsonObject(with: data) as! [String:Any]
                
                DispatchQueue.main.async {
                    self.updateUI(with: parsed)
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }
        
        session.resume()
    }

    func updateUI(with data: [String:Any]) {
        if let main = data["main"] as? [String:Any],
           let tempKelvin = main["temp"] as? Double {
            let tempCelsius = tempKelvin - 273.15
            let tempFahrenheit = (tempCelsius * 9/5) + 32
            self.currentTemp.text = "\(tempFahrenheit)°F"
        }

        if let weatherArray = data["weather"] as? [[String:Any]],
           let weather = weatherArray.first,
           let summary = weather["description"] as? String {
            self.currentSummary.text = summary
        }
        
        
        if let main = data["main"] as? [String:Any],
           let humidity = main["humidity"] as? Int {
            self.currentHumidity.text = "\(humidity)%"
            }
    }
}
