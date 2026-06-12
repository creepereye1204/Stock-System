#ifndef TRADING_DB_HPP
#define TRADING_DB_HPP

#include "TradingEngine.hpp"
#include <vector>

class TradingDB {
public:
    static void connect();
    static void process_batch(const std::vector<Transaction>& txs);
};

#endif
