//
//  AppState.swift
//  Worker
//
//  Created by John Siracusa on 6/26/25.
//

@MainActor
final class AppState {
    let worker = Worker()
    var products : [WorkProduct] = []

    var numProducts : Int {
        products.count
    }

    func generateProducts() async {
        self.products = await worker.generateProducts()
    }

    func processProducts() async -> Int {
        // How can I send this array of non-sendable WorkProduct
        // objects over to the Worker actor for processing and then
        // have it transfer them back here, all without making any
        // "real" (i.e., memory-consuming) copies?

        // Approach 1:
        //
        // ERROR: Non-sendable result type '[WorkProduct]' cannot be sent from
        // actor-isolated context in call to instance method 'processProducts'
        //self.products = await worker.processProducts(self.products)

        // Approach 2:
        //
        // Trying to "un-own" the products array also doesn't work:
        let localProducts = self.products

        // Now only localProducts references what was once self.products, right?
        self.products = []

        // ERROR: Non-sendable result type '[WorkProduct]' cannot be sent from
        // actor-isolated context in call to instance method 'processProducts'
        self.products = await worker.processProducts(localProducts)

        return self.products.count
    }
}
