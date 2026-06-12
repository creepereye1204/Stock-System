#ifndef TRADING_ENGINE_HPP
#define TRADING_ENGINE_HPP

#include <string>
#include <vector>

struct Transaction {
    std::string userId;
    double amount;
    std::string currencyCode;
    std::string type;
};

class TradingDB;

#endif
