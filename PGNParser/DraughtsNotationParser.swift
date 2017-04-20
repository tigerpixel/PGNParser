//
//  DraughtsNotationParser.swift
//  PGNParser
//
//  Created by Liam on 11/04/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

import ParserCombinator
import Currier

/**
 Creates a parser to parse a description a draughts game in portable game notation to DraughtsMove objects.
 */
struct DraughtsNotationParser {
    
    /**
     Create a parser which performs the parseing of portable game notation for draughts.
     
     Once created the parser can be called multiple times for multiple input game strings.
     
     - returns: A parser which creates a list of draughts moves from a string in the correct type.
     */
    static func portableGameNotation() -> Parser<[DraughtsMove]> {
        
        let singlePieceMove = curry(DraughtsPieceMove.init) <^> integerNumber
                                                            <*> lowercaseXIsTrue <|> hyphenIsFalse
                                                            <*> integerNumber
        
        let moveRound = numberWithPoint *> twoPlayerTurn(singlePieceMove)
        
        return moveRound.oneOrMany
    }
    
    /// A parser which resolves lowercase x to a boolean true and fails on all other input strings.
    private static let lowercaseXIsTrue = character(isEqualTo: "x").map() { _ in return true }
    
    /// A parser which resolves a hyphen to a boolean false and fails on all other input strings.
    private static let hyphenIsFalse = character(isEqualTo: "-").map() { _ in return false }
    
    /// A parser which resolves a full stop to a success and fails on all other input strings.
    private static let fullStop = character(isEqualTo: ".")
    
    /// A parser which resolves numbers followed by a fullStop and fails on all other input strings.
    private static let numberWithPoint = whitespace.zeroOneOrMany *> digit.oneOrMany *> fullStop
    
    /**
     Combine a description of a single player turn into a full move with up to two player turns.
     
     - parameter turn: A parser for a single turn performed by one player.
     
     - returns: A parser for a draughts move object describing both playes turn for a move.
     */
    private static func twoPlayerTurn(_ turn: Parser<DraughtsPieceMove>) -> Parser<DraughtsMove> {
        
        let singleMove = whitespace.zeroOneOrMany *> turn
        
        return curry(DraughtsMove.init) <^> singleMove <*> singleMove.optional
    }
    
}
