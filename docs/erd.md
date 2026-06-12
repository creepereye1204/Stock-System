# Entity Relationship Diagram (ERD)

Digitied 프로젝트의 데이터베이스 스키마 구조와 관계를 설명합니다.

## 1. ER 다이어그램

```mermaid
erDiagram
    USERS ||--o{ TRANSACTIONS : "makes"
    CURRENCIES ||--o{ TRANSACTIONS : "is used in"

    USERS {
        VARCHAR2(20) user_id PK "사용자 식별자"
        NUMBER(20,2) balance "현재 잔액"
    }

    CURRENCIES {
        VARCHAR2(3) currency_code PK "통화 코드 (USD, KRW 등)"
        NUMBER(20,6) exchange_rate "환율 정보"
    }

    TRANSACTIONS {
        NUMBER tx_id PK "거래 고유 번호 (IDENTITY)"
        VARCHAR2(20) user_id FK "사용자 식별자"
        VARCHAR2(3) currency_code FK "통화 코드"
        NUMBER(20,2) amount "거래 금액"
        VARCHAR2(10) tx_type "거래 타입 (BUY, SELL)"
        TIMESTAMP tx_time "거래 발생 시간"
    }
```

## 2. 테이블 상세 설명

### 2.1 USERS (사용자 테이블)
- 시스템을 이용하는 사용자의 정보를 관리합니다.
- `balance`는 소수점 2자리까지 관리하며 고성능 트래픽 환경에서 빈번한 업데이트가 발생할 수 있습니다.

### 2.2 CURRENCIES (통화 및 환율 테이블)
- 지원하는 외화 종류와 기준 환율을 관리합니다.
- 트레이딩 엔진은 이 테이블을 참조하여 거래 금액을 계산합니다.

### 2.3 TRANSACTIONS (거래 내역 테이블)
- 이 프로젝트의 핵심 테이블로, 모든 구매/판매 로그가 기록됩니다.
- **성능 최적화:** Pro*C의 Batch Insert 기능을 통해 초당 수천 건의 데이터가 대량으로 삽입되도록 설계되었습니다.
- `user_id`와 `currency_code`는 각각 USERS와 CURRENCIES 테이블을 참조하는 외래키(Foreign Key)입니다.

---

## 3. 인덱스 및 성능 고려사항
- `TRANSACTIONS` 테이블은 대량 삽입이 위주이므로, 삽입 성능 저하를 막기 위해 최소한의 인덱스만 유지합니다.
- `tx_id`는 오라클의 `GENERATED ALWAYS AS IDENTITY`를 사용하여 순차적으로 자동 생성됩니다.
