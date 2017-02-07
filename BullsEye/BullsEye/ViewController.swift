//
//  ViewController.swift
//  BullsEye
//
//  Created by FengHaomin on 02/01/2017.
//  Copyright © 2017 HaoMin Feng. All rights reserved.
//

import UIKit
import QuartzCore

/* This is the main screen for this game
 */
class ViewController: UIViewController {
    
    var currentValue = 0
    var targetValue = 0
    var totalScore = 0
    var round = 0
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!

    // this method is called when user opens the app and create the main view controller
    // (this is used to set up the game and initilazie all the values of the variables)
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewRound()
        updateLabels()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable =
            trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable =
            trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // This method is used for the Alert popup when user clicks on the "Hit me" button
    @IBAction func showAlert() {
        let diff: Int = abs(currentValue - targetValue)
        var score: Int = 100 - diff
        let title: String
        
        if diff == 0 {
            title = "OMG Perfect!"
            score += 100
        } else if diff < 5 {
            title = "Wow it's so close!"
            if score == 1 {
                score += 50
            }
        } else if diff < 10 {
            title = "Good!"
        } else if diff < 20 {
            title = "Hmmm Okay!"
        } else {
            title = "Uhhh not even close 🙄"
        }
        
        totalScore += score
        
        let message = "You moved the slider to: \(currentValue)" +
                      "\nThe target value is: \(targetValue)" +
                      "\nYOUR SCORE IS: \(score)!"
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default,
                                   handler: { action in self.startNewRound()   // start new round and update the labels
                                                        self.updateLabels()    // after the user taps "OK"
                                            })
        alert.addAction(action)
    
        present(alert, animated: true, completion: nil)
        
    }
    
    // This method is used to obtain the roundoff value of the slider
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
    // This is method is to start a new game when the users presses the restart button
    @IBAction func startNewGame(_ button: UIButton) {
        totalScore = 0
        round = 0
        startNewRound()
        updateLabels()
    }
    
    // This method is to start a new round
    func startNewRound() {
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        round += 1
        
        // Create a Core Animation transition
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 0.8
        transition.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseOut)
        view.layer.add(transition, forKey: nil)
    }

    // This method is to keep track of the labels' values (update the values)
    func updateLabels() {
        targetLabel.text = String(targetValue) // or write as in "\(targetValue)"
        scoreLabel.text = String(totalScore)
        roundLabel.text = String(round)
    }

}

 
