//
//  DraughtsMoveTests.swift
//  PGNParser
//
//  Created by Liam on 11/04/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

import XCTest
@testable import PGNParser

// swiftlint:disable type_body_length
class DraughtsMoveTests: XCTestCase {

    func testSingleValidMoveWhiteOnly() {

        // White moves one piece from position 9 to position 14 to open the game.
        let sinlgeMoveWhitePlayer = "1. 9-14"

        switch DraughtsMove.parse(fromPortableGameNotation: sinlgeMoveWhitePlayer) {
        case .success(let moves, let tail):

            XCTAssertEqual(1, moves.count)
            XCTAssertEqual("", String(tail))

            if let firstMove = moves.first {
                XCTAssertEqual(9, firstMove.white.origin)
                XCTAssertEqual(14, firstMove.white.destination)
                XCTAssertEqual(false, firstMove.white.isCapture)
                XCTAssertEqual([], firstMove.white.intermediatePositions)

                XCTAssertNil(firstMove.black)
            }

        case .failure(_):
            XCTFail()
        }
    }

    func testSingleValidMoveBothPlayers() {

        // White moves one piece from position 9 to position 14 to open the game.
        // Black responds by moving the piece at position 23 to position 18. 
        // No pieces are captured.
        let sinlgeMoveTwoPlayers = "1. 9-14 23-18"

        switch DraughtsMove.parse(fromPortableGameNotation: sinlgeMoveTwoPlayers) {
        case .success(let moves, let tail):

            XCTAssertEqual(1, moves.count)
            XCTAssertEqual("", String(tail))

            if let firstMove = moves.first {
                XCTAssertEqual(9, firstMove.white.origin)
                XCTAssertEqual(14, firstMove.white.destination)
                XCTAssertEqual(false, firstMove.white.isCapture)
                XCTAssertEqual([], firstMove.white.intermediatePositions)

                XCTAssertEqual(23, firstMove.black?.origin)
                XCTAssertEqual(18, firstMove.black?.destination)
                XCTAssertEqual(false, firstMove.black?.isCapture)
                XCTAssertEqual([], firstMove.black?.intermediatePositions ?? [0])
            }

        case .failure(_):
            XCTFail()
        }
    }

    func testSingleValidMoveBothPlayersWithAdditionalData() {

        let sinlgeMoveTwoPlayersWithNote = "1. 9-14 23-18 //A Note"

        switch DraughtsMove.parse(fromPortableGameNotation: sinlgeMoveTwoPlayersWithNote) {
        case .success(let moves, let tail):

            XCTAssertEqual(1, moves.count)
            XCTAssertEqual(" //A Note", String(tail))

            if let firstMove = moves.first {
                XCTAssertEqual(9, firstMove.white.origin)
                XCTAssertEqual(14, firstMove.white.destination)
                XCTAssertEqual(false, firstMove.white.isCapture)
                XCTAssertEqual([], firstMove.white.intermediatePositions)

                XCTAssertEqual(23, firstMove.black?.origin)
                XCTAssertEqual(18, firstMove.black?.destination)
                XCTAssertEqual(false, firstMove.black?.isCapture)
                XCTAssertEqual([], firstMove.black?.intermediatePositions ?? [0])
            }

        case .failure(_):
            XCTFail()
        }
    }

    func testMultipleValidMovesBothPlayers() {

        let multipleMoves = "1. 9-14 23-18 2. 14-17 18-15"

        switch DraughtsMove.parse(fromPortableGameNotation: multipleMoves) {
        case .success(let moves, let tail):

            XCTAssertEqual(2, moves.count)
            XCTAssertEqual("", String(tail))

            if let firstMove = moves.first {
                XCTAssertEqual(9, firstMove.white.origin)
                XCTAssertEqual(14, firstMove.white.destination)
                XCTAssertEqual(false, firstMove.white.isCapture)
                XCTAssertEqual([], firstMove.white.intermediatePositions)

                XCTAssertEqual(23, firstMove.black?.origin)
                XCTAssertEqual(18, firstMove.black?.destination)
                XCTAssertEqual(false, firstMove.black?.isCapture)
                XCTAssertEqual([], firstMove.black?.intermediatePositions ?? [0])
            }

            if let lastMove = moves.last {
                XCTAssertEqual(14, lastMove.white.origin)
                XCTAssertEqual(17, lastMove.white.destination)
                XCTAssertEqual(false, lastMove.white.isCapture)
                XCTAssertEqual([], lastMove.white.intermediatePositions)

                XCTAssertEqual(18, lastMove.black?.origin)
                XCTAssertEqual(15, lastMove.black?.destination)
                XCTAssertEqual(false, lastMove.black?.isCapture)
                XCTAssertEqual([], lastMove.black?.intermediatePositions ?? [0])
            }

        case .failure(_):
            XCTFail()
        }
    }

    func testMultipleValidMovesLastTurnWhite() {

        let multipleMoves = "1. 9-14 23-18 2. 14-17"

        switch DraughtsMove.parse(fromPortableGameNotation: multipleMoves) {
        case .success(let moves, let tail):

            XCTAssertEqual(2, moves.count)
            XCTAssertEqual("", String(tail))

            if let firstMove = moves.first {
                XCTAssertEqual(9, firstMove.white.origin)
                XCTAssertEqual(14, firstMove.white.destination)
                XCTAssertEqual(false, firstMove.white.isCapture)
                XCTAssertEqual([], firstMove.white.intermediatePositions)

                XCTAssertEqual(23, firstMove.black?.origin)
                XCTAssertEqual(18, firstMove.black?.destination)
                XCTAssertEqual(false, firstMove.black?.isCapture)
                XCTAssertEqual([], firstMove.black?.intermediatePositions ?? [0])
            }

            if let lastMove = moves.last {
                XCTAssertEqual(14, lastMove.white.origin)
                XCTAssertEqual(17, lastMove.white.destination)
                XCTAssertEqual(false, lastMove.white.isCapture)
                XCTAssertEqual([], lastMove.white.intermediatePositions)

                XCTAssertNil(lastMove.black)
            }

        case .failure(_):
            XCTFail()
        }
    }

    func testValidMovesWithCaptures() {

        // Both players move and as they do they capture another piece. 
        // This is an impossible move in the standard game of draughts.
        let multipleMoves = "1. 9x14 23x18"

        switch DraughtsMove.parse(fromPortableGameNotation: multipleMoves) {
        case .success(let moves, let tail):

            XCTAssertEqual(1, moves.count)
            XCTAssertEqual("", String(tail))

            if let firstMove = moves.first {
                XCTAssertEqual(9, firstMove.white.origin)
                XCTAssertEqual(14, firstMove.white.destination)
                XCTAssertEqual(true, firstMove.white.isCapture)
                XCTAssertEqual([], firstMove.white.intermediatePositions)

                XCTAssertEqual(23, firstMove.black?.origin)
                XCTAssertEqual(18, firstMove.black?.destination)
                XCTAssertEqual(true, firstMove.black?.isCapture)
                XCTAssertEqual([], firstMove.black?.intermediatePositions ?? [0])
            }

        case .failure(_):
            XCTFail()
        }
    }

    func testValidMovesWithMultipleCaptures() {

        // Both players move and as they do they capture other pieces.
        let multipleMoves = "1. 9x14x17 23x18x12"

        switch DraughtsMove.parse(fromPortableGameNotation: multipleMoves) {
        case .success(let moves, let tail):

            XCTAssertEqual(1, moves.count)
            XCTAssertEqual("", String(tail))

            if let firstMove = moves.first {
                XCTAssertEqual(9, firstMove.white.origin)
                XCTAssertEqual(17, firstMove.white.destination)
                XCTAssertEqual(true, firstMove.white.isCapture)
                XCTAssertEqual([14], firstMove.white.intermediatePositions)

                XCTAssertEqual(23, firstMove.black?.origin)
                XCTAssertEqual(12, firstMove.black?.destination)
                XCTAssertEqual(true, firstMove.black?.isCapture)
                XCTAssertEqual([18], firstMove.black?.intermediatePositions ?? [])
            }

        case .failure(_):
            XCTFail()
        }
    }

    func testValidMovesWithManyCaptures() {

        // Both players move and as they do they capture another pieces.
        let multipleMoves = "1. 9x14x17x21 23x18x12x9x6"

        switch DraughtsMove.parse(fromPortableGameNotation: multipleMoves) {
        case .success(let moves, let tail):

            XCTAssertEqual(1, moves.count)
            XCTAssertEqual("", String(tail))

            if let firstMove = moves.first {
                XCTAssertEqual(9, firstMove.white.origin)
                XCTAssertEqual(21, firstMove.white.destination)
                XCTAssertEqual(true, firstMove.white.isCapture)
                XCTAssertEqual([14, 17], firstMove.white.intermediatePositions)

                XCTAssertEqual(23, firstMove.black?.origin)
                XCTAssertEqual(6, firstMove.black?.destination)
                XCTAssertEqual(true, firstMove.black?.isCapture)
                XCTAssertEqual([18, 12, 9], firstMove.black?.intermediatePositions ?? [])
            }

        case .failure(_):
            XCTFail()
        }
    }

    func testValidMovesForWholeGame() {

        // Data for a full game.

        // Sourced from .......

        // swiftlint:disable line_length
        let fullGame = "1. 9-14 23-18 2. 14x23 27x18 3. 5-9 26-23 4. 12-16 30-26 5. 16-19 24x15 6. 10x19 23x16 7. 11x20 22-17 8. 7-11 18-15 9. 11x18 28-24 10. 20x27 32x5 11. 8-11 26-23 12. 4-8 25-22 13. 11-15 17-13 14. 8-11 21-17 15. 11-16 23-18 16. 15-19 17-14 17. 19-24 14-10 18. 6x15 18x11 19. 24-28 22-17 20. 28-32 17-14 21. 32-28 31-27 22. 16-19 27-24 23. 19-23 24-20 24. 23-26 29-25 25. 26-30 25-21 26. 30-26 14-9 27. 26-23 20-16 28. 23-18 16-12 29. 18-14 11-8 30. 28-24 8-4 31. 24-19 4-8 32. 19-16 9-6 33. 1x10 5-1 34. 10-15 1-6 35. 2x9 13x6 36. 16-11 8-4 37. 15-18 6-1 38. 18-22 1-6 39. 22-26 6-1 40. 26-30 1-6 41. 30-26 6-1 42. 26-22 1-6 43. 22-18 6-1 44. 14-9 1-5 45. 9-6 21-17 46. 18-22"
        // swiftlint:enable line_length

        switch DraughtsMove.parse(fromPortableGameNotation: fullGame) {
        case .success(let moves, let tail):

            XCTAssertEqual(46, moves.count)
            XCTAssertEqual("", String(tail))

            if let firstMove = moves.first {
                XCTAssertEqual(9, firstMove.white.origin)
                XCTAssertEqual(14, firstMove.white.destination)
                XCTAssertEqual(false, firstMove.white.isCapture)
                XCTAssertEqual([], firstMove.white.intermediatePositions)

                XCTAssertEqual(23, firstMove.black?.origin)
                XCTAssertEqual(18, firstMove.black?.destination)
                XCTAssertEqual(false, firstMove.black?.isCapture)
                XCTAssertEqual([], firstMove.black?.intermediatePositions ?? [0])
            } else {
                XCTFail()
            }

            let moveWithCapture = moves[5]
            XCTAssertEqual(10, moveWithCapture.white.origin)
            XCTAssertEqual(19, moveWithCapture.white.destination)
            XCTAssertEqual(true, moveWithCapture.white.isCapture)
            XCTAssertEqual([], moveWithCapture.white.intermediatePositions)

            XCTAssertEqual(23, moveWithCapture.black?.origin)
            XCTAssertEqual(16, moveWithCapture.black?.destination)
            XCTAssertEqual(true, moveWithCapture.black?.isCapture)
            XCTAssertEqual([], moveWithCapture.black?.intermediatePositions ?? [0])

            if let lastMove = moves.last {
                XCTAssertEqual(18, lastMove.white.origin)
                XCTAssertEqual(22, lastMove.white.destination)
                XCTAssertEqual(false, lastMove.white.isCapture)
                XCTAssertEqual([], lastMove.white.intermediatePositions)

                XCTAssertNil(lastMove.black)
            } else {
                XCTFail()
            }

        case .failure(_):
            XCTFail()
        }
    }

    func testNoMoves() {

        switch DraughtsMove.parse(fromPortableGameNotation:"") {
        case .success(_, _):
            XCTFail()

        case .failure(let reason):
            if case .insufficiantTokens = reason {
                return
            }
            XCTFail()
        }
    }

    func testInvalidMovesWithMiscInput() {

        // Enter completely different input just to check that it handles the error gracefully.
        let invalidAlphanumbericInput = "1n jkfuf ufjf jnkf  j1j2 8485ui5j 4"

        switch DraughtsMove.parse(fromPortableGameNotation: invalidAlphanumbericInput) {

        case .failure(let reason):
            if case .unexpectedToken(let token, let tail) = reason {
                XCTAssertEqual("n", String(token))
                XCTAssertEqual(" jkfuf ufjf jnkf  j1j2 8485ui5j 4", String(tail))
            } else {
                XCTFail()
            }

        case .success(_, _):
            XCTFail()
        }
    }

    func testInvalidMovesWithMissingNumber() {

        // Miss out the number as a possible common error.
        let missingRoundNumber = "1. 9-14 23-18 14x23 27x18"

        switch DraughtsMove.parse(fromPortableGameNotation: missingRoundNumber) {
        case .success(let moves, let tail):

            // NOTE: This succeeds because there are valid results at the start of the input sting.
            // It may be deemed as unexpected and it may be better to find a way to make this fail.
            XCTAssertEqual(1, moves.count)
            XCTAssertEqual(" 14x23 27x18", String(tail))

            if let firstMove = moves.first {
                XCTAssertEqual(9, firstMove.white.origin)
                XCTAssertEqual(14, firstMove.white.destination)
                XCTAssertEqual(false, firstMove.white.isCapture)
                XCTAssertEqual([], firstMove.white.intermediatePositions)

                XCTAssertEqual(23, firstMove.black?.origin)
                XCTAssertEqual(18, firstMove.black?.destination)
                XCTAssertEqual(false, firstMove.black?.isCapture)
                XCTAssertEqual([], firstMove.black?.intermediatePositions ?? [0])
            }

        case .failure(_):
            XCTFail()
        }
    }

}
// swiftlint:enable type_body_length
