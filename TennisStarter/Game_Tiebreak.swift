//
//  Game_Tiebreak.swift
//  TennisStarter
//
//  Created by Aaron Wolfenden on 10/05/2018.
//  Copyright © 2018 University of Chester. All rights reserved.
//

import Foundation
class Game_Tiebreak: Game{
    private var player_one_points: Int
    private var player_two_points: Int

    override init(){
        self.player_one_points = 0
        self.player_two_points = 0
    }
    override func addPointToPlayer1() {
        self.player_one_points += 1
    }
    override func addPointToPlayer2(){
        self.player_two_points += 1
    }
    
    override func player1Score() -> String {
        return String(self.player_one_points)
    }
    
    override func player2Score() -> String {
        return String(self.player_two_points)
    }
    
    override func player1Won() -> Bool{
        if self.player_one_points >= 7{
            if self.player_two_points <= (self.player_one_points - 2){
                return true
            }
        }
        return false
    }
    
    override func player2Won() -> Bool{
        if self.player_two_points >= 7{
            if self.player_one_points <= (self.player_two_points - 2){
            return true
            }
        }
    return false
    }
    
    override func gamePointsForPlayer1() -> Int {
        if self.player_one_points >= 6{
            if self.player_two_points <= (self.player_one_points - 1){
                return self.player_one_points - self.player_two_points
            }
        }
        return 0
    }

    override func gamePointsForPlayer2() -> Int {
        if self.player_two_points >= 6{
            if self.player_one_points <= (self.player_two_points - 1){
                return self.player_two_points - self.player_one_points
            }
        }
        return 0
    }
}
