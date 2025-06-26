//
//  Worker.swift
//  Worker
//
//  Created by John Siracusa on 6/26/25.
//

import Foundation

fileprivate let numProducts = 1_000_000

actor Worker {
    var someSetting = false

    func generateProducts() -> sending [WorkProduct] {
        var products : [WorkProduct] = []

        products.reserveCapacity(numProducts)

        for _ in 0..<numProducts {
            products.append(WorkProduct())
        }

        // Successfully returning an array of non-Sendable
        // WorkProduct objects from this actor to the caller,
        // which may be on another actor (e.g., MainActor)
        return products
    }

    func processProducts(_ products: sending [WorkProduct]) -> [WorkProduct] {
        for product in products {
            processProduct(product)
        }

        return products
    }

    func processProduct(_ product: WorkProduct) {
        if self.someSetting {
            product.name = "abc"
        }
        else {
            product.name = generateRandomString(length: 5)
        }
    }
}

fileprivate let characters = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
fileprivate let characterCount = UInt32(characters.count)

func generateRandomString(length: Int) -> String {
    assert(length > 0, "Length passed to generateRandomString() must be greater than 0")

    var randomCharacters = [Character]()
    randomCharacters.reserveCapacity(length)

    for _ in 0..<length {
        let randomIndex = Int(arc4random_uniform(characterCount))
        randomCharacters.append(characters[randomIndex])
    }

    return String(randomCharacters)
}
