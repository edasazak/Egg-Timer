//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var eggTitle: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    var player: AVAudioPlayer?

    @IBAction func hardnessSelected(_ sender: UIButton) {

        
        timer.invalidate()
        let hardness = sender.currentTitle! // ! koyduk çünkü eggTimes kesin String tutuyor ancak hardness optional o yüzden onu unwrapped etmemiz lazım
        totalTime = eggTimes[hardness]!
        // time interval: 1.0 a ayarlı çünkü her 1 saniyede ilerlemesini istiyoruz.
        // repeats: true ilk saniyeden sonra durmuyor devam ediyor.
        // selector fonksiyon çağırmak için kullanılır.
        progressBar.progress = 0.0
        secondsPassed = 0
        eggTitle.text = hardness
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:
                    #selector(countUp), userInfo: nil, repeats: true)
            }
            @objc func countUp() {
                 if secondsPassed < totalTime {
                     secondsPassed += 1
                     progressBar.progress = Float(secondsPassed) / Float(totalTime)
                     print(Float(secondsPassed) / Float(totalTime))
                 } else {
                     timer.invalidate()
                     self.eggTitle.text = "Done!"
                     playSound()
                 }
      
            }
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    }

