#include <iostream>
#include <vector>
#include <thread>
#include <chrono>
#include "TradingDB.hpp"


void simulate_traffic() {
    std::vector<Transaction> batch;
    for (int i = 0; i < 50; ++i) {
        batch.push_back({"admin", 100.0 + i, "USD", "BUY"});
    }
    
    std::cout << "Starting batch processing..." << endl;
    TradingDB::process_batch(batch);
}

int main() {
    try {
        TradingDB::connect();
        
        
        std::cout << "Simulating high traffic..." << std::endl;
        for (int i = 0; i < 5; ++i) {
            simulate_traffic();
            std::this_thread::sleep_for(std::chrono::milliseconds(100));
        }
        
        std::cout << "Simulation completed." << std::endl;
    } catch (const std::exception& e) {
        std::cerr << "Error: " << e.what() << std::endl;
        return 1;
    }
    
    return 0;
}
