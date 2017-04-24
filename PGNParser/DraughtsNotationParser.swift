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
 Creates a parser to parse a description of a draughts game in portable game notation to DraughtsMove objects.
 */
struct DraughtsNotationParser {

    /**
     Create a parser which performs the parsing of portable game notation for draughts.
     
     Once created the parser can be called multiple times for multiple input game strings.
     
     - returns: A parser which creates a list of draughts moves from a string in the correct type.
     */
    static func portableGameNotation() -> Parser<[DraughtsMove]> {

        let origin = integerNumber
        let isCapture = lowercaseXIsTrue <|> hyphenIsFalse
        let intermediates = (integerNumber <* lowercaseX).zeroOneOrMany
        let destination = integerNumber

        let singlePieceMove = curry(DraughtsPieceMove.init) <^> origin
                                                            <*> isCapture
                                                            <*> intermediates
                                                            <*> destination

        let moveRound = numberWithPoint *> twoPlayerTurn(singlePieceMove)

        return moveRound.oneOrMany
    }

    /// A parser which will succeed on a lowercase 'x' and fail on any other input token.
    private static let lowercaseX = character(isEqualTo: "x")

    /// A parser which resolves lowercase x to a boolean true and fails on all other input strings.
    private static let lowercaseXIsTrue = lowercaseX.map { _ in return true }

    /// A parser which resolves a hyphen to a boolean false and fails on all other input strings.
    private static let hyphenIsFalse = character(isEqualTo: "-").map { _ in return false }

    /// A parser which resolves a full stop to a success and fails on all other input strings.
    private static let fullStop = character(isEqualTo: ".")

    /// A parser which resolves numbers followed by a fullStop and fails on all other input strings.
    private static let numberWithPoint = whitespace.zeroOneOrMany *> digit.oneOrMany *> fullStop

    /// A parser which will succeed on an open curly bracket and fail on any other input token.
    private static let openCurlyBracket = character(isEqualTo: "{")

    /// A parser which will succeed on a close curly bracket and fail on any other input token.
    private static let closeCurlyBracket = character { $0 == "}" }

    /// A parser which will fail on a close curly bracket and succeed on any other input token.
    private static let notCloseCurlyBracket = character { $0 != "}" }

    /// A parser which will continue parsing upto but not including the next close curly bracket.
    private static let untilCloseCurlyBracket: Parser<String> = notCloseCurlyBracket.zeroOneOrMany.map { String($0) }

    /// A parser which will parse a comment between and open and close curly bracket, keeping only the comment.
    private static let comment: Parser<String> = openCurlyBracket *> untilCloseCurlyBracket <* closeCurlyBracket

    /// A Parser which will parse a comment with whitespace before it and if the comment exists, keep only the comment.
    private static let optionalCommentAfterWhitespace: Parser<String?> = whitespace.zeroOneOrMany *> comment.optional

    /**
     Combine a description of a single player turn into a full move with up to two player turns.
     
     - parameter turn: A parser for a single turn performed by one player.
     
     - returns: A parser for a draughts move object describing both player's turns for a move.
     */
    private static func twoPlayerTurn(_ turn: Parser<DraughtsPieceMove>) -> Parser<DraughtsMove> {

        let singleMove = whitespace.zeroOneOrMany *> turn

        let whiteMove = singleMove
        let blackMove = singleMove.optional
        let comment = optionalCommentAfterWhitespace

        return curry(DraughtsMove.init) <^> whiteMove
                                        <*> blackMove
                                        <*> comment
    }

}
