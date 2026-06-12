# Digitied Project: Custom Pro*C Setup

이 프로젝트는 Oracle Linux 8 환경에서 Pro*C(`proc`) 패키지를 DNF로 설치할 수 없는 문제를 해결하기 위해, DB 컨테이너에서 SDK를 직접 추출하여 사용하도록 설정되었습니다.

## 🛠 현재 설정 요약
- **SDK 위치:** `./oracle_sdk/` (호스트의 프로젝트 루트)
- **Pro*C 컴파일러:** `/app/oracle_sdk/proc` (컨테이너 내부 경로)
- **DB 접속 정보:** `trading/trading_pass@FREE` (TNS 서비스명: `FREEPDB1`)

## 🚀 개발 워크플로우
코드를 수정하신 후, 다음 명령어로 즉시 결과를 확인하실 수 있습니다.

```bash
# 컨테이너 외부(호스트)에서 실행
docker compose exec app make clean run
```

## ⚠️ 주의사항
- `oracle_sdk` 디렉토리는 Pro*C 컴파일에 필수적이므로 삭제하지 마세요.
- 만약 이미지를 완전히 다시 빌드해야 한다면, `Dockerfile`이 이 SDK를 참조하도록 설정되어 있습니다.

## 📂 주요 파일
- `src/pc/TradingDB.pc`: Pro*C 소스 코드 (Batch Processing 로직 포함)
- `src/cpp/main.cpp`: 트래픽 시뮬레이션 및 메인 로직
- `Makefile`: 빌드 자동화 설정 (SDK 경로 반영됨)
