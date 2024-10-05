module MyModule::ParkingSpaceRental {

    use aptos_framework::signer;
    use std::vector;

    /// Struct representing a parking space listed for rental.
    struct ParkingSpace has store, key {
        owner: address,           // Address of the parking space owner
        location: vector<u8>,     // Location of the parking space
        rental_price: u64,        // Price for renting the parking space
        is_available: bool,       // Whether the parking space is available for rent
    }

    /// Function to list a parking space for rent.
    public fun list_space(owner: &signer, location: vector<u8>, rental_price: u64) {
        let space = ParkingSpace {
            owner: signer::address_of(owner),
            location,
            rental_price,
            is_available: true,
        };
        move_to(owner, space);
    }

    /// Function to rent a parking space, updating its status.
    public fun rent_space(renter: &signer, owner_address: address) acquires ParkingSpace {
        let space = borrow_global_mut<ParkingSpace>(owner_address);

        // Ensure the parking space is available for rent
        assert!(space.is_available, 1);

        // Mark the space as rented (not available)
        space.is_available = false;

        // Payment is assumed to be handled off-chain
    }
}
