//
//  ViewController.swift
//  BullsEye
//
//  Created by cbd on 15/02/2017.
//  Copyright © 2017 icbd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentValue: Int = 0;
    var targetValue: Int = 0;
    var score: Int = 0;
    var round = 0;
    
    @IBOutlet weak var slider: UISlider! ;
    @IBOutlet weak var targetLabel: UILabel! ;
    @IBOutlet weak var scoreLabel: UILabel! ;
    @IBOutlet weak var roundLabel: UILabel! ;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable =
            trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable =
            trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        startNewGame();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func showAlert() {
        let difference = abs(targetValue - currentValue);
        var points = 100 - difference;
        
        let title: String;
        if difference == 0 {
            title = "Perfect!";
            points += 100;
        } else if difference < 5 {
            title = "You almost had it!";
            if difference == 1 {
                points += 50;
            }
        } else if difference < 10 {
            title = "Pretty good!";
        } else {
            title = "Not even close...";
        }
        score += points;
        let message = "You scored \(points) points";
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert);
        
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: { action in self.startNewRound(); });
        
        alert.addAction(action);
        present(alert, animated: true, completion: nil);
    }
    
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value);
    }

    
    func startNewRound() {
        targetValue = 1 + Int(arc4random_uniform(100));
        
        currentValue = 50;
        slider.value = Float(currentValue);
        round += 1;
        updateLabels();
    }
    
    @IBAction func startOver() {
        startNewGame();
    }
    
    func startNewGame() {
        round = 0;
        score = 0;
        startNewRound();
    }
    
    
    func updateLabels() {
        targetLabel.text = "\(targetValue)";
        scoreLabel.text = "\(score)";
        roundLabel.text = "\(round)";
    }
    
}

