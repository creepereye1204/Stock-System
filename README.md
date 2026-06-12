# Digitied: High-Traffic Virtual Trading System

C++와 Pro*C를 활용하여 대용량 트래픽을 처리할 수 있는 가상 외화 트레이딩 시스템 프로젝트입니다. Docker를 통해 독립적인 개발 환경을 제공합니다.

## 🚀 주요 특징
- **Pro*C Bulk Operations:** 대량의 데이터를 한 번에 처리하여 DB I/O 성능 극대화 (Batch Processing).
- **Dockerized Environment:** Oracle XE 21c와 C++ 빌드 환경이 완벽하게 분리되어 제공됩니다.
- **C++11/14/17 지원:** 최신 C++ 문법과 Pro*C를 혼합하여 강력한 비즈니스 로직 구현 가능.

## 📂 프로젝트 구조
```text
.
├── docker-compose.yml       # 서비스 오케스트레이션 (DB + App)
├── docker/
│   ├── app/Dockerfile       # C++/Pro*C 개발 환경 (Oracle Instant Client 포함)
│   └── oracle/
│       ├── scripts/init.sql # 초기 테이블 스키마 및 데이터 정의
│       └── network/admin/   # Oracle TNS 설정
├── src/
│   ├── pc/                  # Pro*C (*.pc) 소스 코드
│   └── cpp/                 # C++ (*.cpp) 소스 코드
├── include/                 # 공용 헤더 파일
├── Makefile                 # 빌드 자동화 스크립트
└── README.md                # 프로젝트 가이드
```

## 🛠 시작하기

### 1. 사전 요구 사항
- [Docker](https://www.docker.com/) 및 [Docker Compose](https://docs.docker.com/compose/)가 설치되어 있어야 합니다.

### 2. 컨테이너 실행
프로젝트 루트 디렉토리에서 다음 명령어를 실행합니다.
```bash
docker-compose up -d --build
```
*참고: 오라클 DB 컨테이너가 완전히 부팅되고 데이터베이스가 준비될 때까지 약 1~2분 정도 소요됩니다.*

### 3. 개발 컨테이너 접속
컴파일 및 실행을 위해 앱 컨테이너 내부로 접속합니다.
```bash
docker-compose exec app bash
```

### 4. 프로젝트 빌드
컨테이너 내부에서 `make` 명령어를 사용하여 빌드합니다.
```bash
make
```
이 과정에서 `.pc` 파일이 `.cpp`로 프리컴파일된 후, 최종 실행 파일인 `trading_app`이 생성됩니다.

### 5. 애플리케이션 실행
```bash
./trading_app
```

## 💡 주요 구현 설명

### 데이터베이스 스키마
- `users`: 사용자 잔액 관리
- `currencies`: 외화 환율 정보
- `transactions`: 거래 내역 (고성능 삽입을 위해 최적화됨)

### Pro*C 대량 처리 (Bulk Operations)
`src/pc/TradingDB.pc` 파일 내의 `process_batch` 함수는 호스트 배열(Host Arrays)을 사용하여 여러 트랜잭션을 단일 SQL문으로 삽입합니다. 이는 대용량 트래픽 상황에서 컨텍스트 스위칭과 네트워크 비용을 획기적으로 줄여줍니다.

```cpp
// 예시: 100개의 데이터를 한 번에 INSERT
EXEC SQL FOR :h_batch_size
INSERT INTO transactions (user_id, amount, currency_code, tx_type)
VALUES (:b_user_id, :b_amount, :b_currency_code, :b_tx_type);
```

## 🛠 문제 해결 (Troubleshooting)
- **DB 연결 실패:** DB 컨테이너가 아직 초기화 중일 수 있습니다. `docker-compose logs -f db`로 로그를 확인하여 "DATABASE IS READY TO USE" 메시지가 떴는지 확인하세요.
- **TNS Error:** `docker/oracle/network/admin/tnsnames.ora` 설정의 호스트명이 `db`로 되어 있는지 확인하세요.
