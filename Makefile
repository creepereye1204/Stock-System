ORACLE_HOME=/usr/lib/oracle/21/client64
PROC=/app/oracle_sdk/proc
CC=g++
CFLAGS=-I$(ORACLE_HOME)/precomp/public -I/app/oracle_sdk/include -I./include -Wall -Wno-write-strings -Wno-unused-variable -pthread
LDFLAGS=-L$(ORACLE_HOME)/lib -lclntsh -lpthread

PROCFLAGS=code=cpp cpp_suffix=cpp parse=partial include=./include include=/app/oracle_sdk/include

# Object files
OBJS = src/pc/TradingDB.o src/cpp/main.o

all: trading_app

# Pro*C precompilation
src/pc/%.cpp: src/pc/%.pc
	$(PROC) $(PROCFLAGS) iname=$< oname=$@

# Compile .cpp to .o
%.o: %.cpp
	$(CC) $(CFLAGS) -c $< -o $@

trading_app: src/pc/TradingDB.o src/cpp/main.o
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

run: trading_app
	./trading_app

clean:
	rm -f src/pc/*.cpp src/pc/*.o src/cpp/*.o trading_app
