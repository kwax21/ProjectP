//
//  ViewController.swift
//  ProjectP
//
//  Created by Ben FRISSON on 24/05/2020.
//  Copyright © 2020 Ben FRISSON. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet var picker: UIPickerView!
    @IBOutlet var button: UIButton!
    @IBOutlet var logo: UIImageView!
    
    var playing: Bool = false
    var pickerCases: [String] = [String]()
    let mediaPlayer = VLCMediaPlayer()
    var streamURL: URL!
    var player: VLCMedia!
    
    
    @IBAction func playpause(_ sender: UIButton) {
        if !playing{
            button.setImage(UIImage(named: "pause128"), for: .normal)
            playing = true
            mediaPlayer.play()
        }
        else{
            button.setImage(UIImage(named: "play128"), for: .normal)
            playing = false
            mediaPlayer.pause()
        }
    }
    
    func initPicker(){
        pickerCases = ["Patrick Radio", "NRJ", "Fun Radio", "Virgin Radio", "RFM"]
        picker.delegate = self
        picker.dataSource = self
    }
    
    func initViews(){
        logo.image = UIImage(named: "téléchargement")
        button.setImage(UIImage(named: "play128"), for: .normal)
    }
    
    func initStream(){
        
        streamURL = URL(string: "http://188.165.215.158:9181/stream")!
        var player = VLCMedia(url: streamURL)
        
        mediaPlayer.media = player
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        //Setters des vues
        initViews()
        //Setter du stream audio
        initStream()
        //Setter de la roue
        initPicker()
        
    }
    
    //PICKER METHODS
    //
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerCases[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        mediaPlayer.stop()
        playing = false
        button.setImage(UIImage(named: "play128"), for: .normal)
        var select = pickerCases[row]
        if select == "Patrick Radio"{
            streamURL = URL(string: "http://188.165.215.158:9181/stream")!
        }
        else if select == "NRJ"{
            streamURL = URL(string: "http://cdn.nrjaudio.fm/audio1/fr/30001/mp3_128.mp3?origine=fluxradios")!
        }
        else if select == "Fun Radio"{
            streamURL = URL(string: "http://streaming.radio.funradio.fr/fun-1-48-192")!
        }
        else if select == "Virgin Radio"{
            streamURL = URL(string: "http://ais-live.cloud-services.paris:8000/virgin.mp3")!
        }
        else if select == "RFM"{
            streamURL = URL(string: "https://ais-live.cloud-services.paris:8443/rfm.mp3")!
        }
        player = VLCMedia(url: streamURL)
        mediaPlayer.media = player
    }
    //
}
