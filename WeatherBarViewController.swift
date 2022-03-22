//
//  WeatherBarViewController.swift
//  weatherApp
//
//  Created by Ethan  Jin  on 8/3/2022.
//

import UIKit

class WeatherBarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        timeText.insertText(time)
        showEmoji(row: selectedRow)
        temperature.insertText(String(describing: emoji[selectedRow].temp)+"°")
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var timeText: UITextView!
    
    @IBOutlet weak var temperature: UITextView!
    @IBOutlet weak var emojiText: UITextView!
    
    var time: String{
        Date().description(with: .current)
    }
    
    func showEmoji(row: Int){
        emojiText.insertText(emoji[row].description)
        view.backgroundColor = UIColor(named: emoji[row].color)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
