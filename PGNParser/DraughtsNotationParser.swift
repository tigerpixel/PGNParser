//
//  DraughtsNotationParser.swift
//  PGNParser
//
//  Created by Liam on 11/04/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

import ParserCombinator
import Currier

/** */
struct DraughtsNotationParser {
    
    /** A function to create a parser which handles the parseing of portable game notation for draughts. */
    static func portableGameNotation() -> Parser<[DraughtsMove]> {
        
        let lowercaseXIsTrue = character(isEqualTo: "x").map() { _ in return true }
        let hyphenIsFalse = character(isEqualTo: "-").map() { _ in return false }
        let fullStop = character(isEqualTo: ".")
        
        let numberWithPoint = whitespace.zeroOneOrMany *> digit.oneOrMany *> fullStop
        
        let singlePieceMove = curry(DraughtsPieceMove.init) <^> integerNumber
                                                            <*> lowercaseXIsTrue <|> hyphenIsFalse
                                                            <*> integerNumber
        
        let moveRound = numberWithPoint *> twoPlayerTurn(singlePieceMove)
        
        return moveRound.oneOrMany
    }
    
    /** */
    private static func twoPlayerTurn(_ turn: Parser<DraughtsPieceMove>) -> Parser<DraughtsMove> {
        
        let singleMove = whitespace.zeroOneOrMany *> turn
        
        return curry(DraughtsMove.init) <^> singleMove <*> singleMove.optional
    }
    
}
