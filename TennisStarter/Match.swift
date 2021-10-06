//
//  Match.swift
//  TennisStarter
//
//  Created by Aaron Wolfenden on 09/05/2018.
//  Copyright © 2018 University of Chester. All rights reserved.
//

import Foundation
import AVFoundation

class Match{
    private var player_one_set_points: Int
    private var player_two_set_points: Int
    private var total_games_played: Int
    private var first_pass: Bool
    private var set: Sets
    private var total_sets: Int
    private var current_server: Int
    private var tiebreaker_counter: Int
    
    init(){
        self.player_one_set_points = 0
        self.player_two_set_points = 0
        self.set = Sets()
        self.total_games_played = 0
        self.first_pass = true
        self.total_sets = 0
        self.current_server = 1
        self.tiebreaker_counter = 2
    }
    
    func add_set_point_p1(){
        self.player_one_set_points += 1
        
    }
    
    func add_set_point_p2(){
        self.player_two_set_points += 1
    }
    
    func player1WonMatch() -> Bool {
        if player_one_set_points == 3{
            return true
            }
        return false
    }
    
    func player2WonMatch() -> Bool{
        if player_two_set_points == 3{
                return true
        }
        return false
    }
    
    func matchComplete() -> Bool{
        if player1WonMatch() || player2WonMatch(){
            return true
        }
        return false
    }
    
    func callForNewBalls(){
        total_games_played += 1
        let new_balls_please = "New Balls Please"
        let utterance = AVFoundation.AVSpeechUtterance(string: new_balls_please)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        let synthesizer = AVFoundation.AVSpeechSynthesizer()
        
        if total_games_played == 7 && self.first_pass{
            synthesizer.speak(utterance)
            total_games_played = 0
            self.first_pass = false
        }
        else if total_games_played == 9{
            synthesizer.speak(utterance)
            total_games_played = 0
        }
    }

    func serverNotification(){
        let system_sound_ID: SystemSoundID = 1016
        AudioServicesPlaySystemSound(system_sound_ID)
    }
    
    func rotateServer(){
            serverNotification()
            if self.current_server == 1{
                self.current_server = 2
            }
            else{
                current_server = 1
            }
    }
    
    
    func tieBreakerServer(){
        if tiebreaker_counter == 2{
            tiebreaker_counter = 0
            rotateServer()
        }
        tiebreaker_counter += 1
    }
    
    func resetCounter(){
        self.tiebreaker_counter = 2
    }
    
    func getCurrentServer() -> Int{
        return self.current_server
    }
    
    func getSetPlayedAmount() -> Int{
        total_sets = self.player_one_set_points + self.player_two_set_points
        return total_sets
    }
    
    func get_set_p1_points() -> String{
        return String(self.player_one_set_points)
    }
    
    func get_set_p2_points() -> String{
        return String(self.player_two_set_points)
    }
}
