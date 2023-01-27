//
//  AdviceLoad.swift
//  ToDoPomodoros
//
//  Created by Ahmed Shaban on 25/01/2023.
//
import Foundation

class ViewModel {
    static var viewModel = ViewModel()
    public var advice: String = ""
    func loadData() {
        guard let url = URL(string: "https://api.adviceslip.com/advice") else { return }
        let request = URLRequest(url: url)
        var result: Result?
        DispatchQueue.main.async {
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let response = try? JSONDecoder().decode(Result.self, from: data) {
                        result = response
                        if let result = result {
                            self.advice = result.slip.advice
                            print(self.advice)
                        }
                    }
                    return
                }
            }.resume()
        }
    }
}









