# Linux 권한 관리 실습 문제
- 실습 환경 준비
- 실습을 진행하기 전에 다음 사용자와 그룹을 생성하세요:

# 그룹 생성
- sudo groupadd developers
- sudo groupadd testers
- sudo groupadd managers

# 사용자 생성 및 그룹 할당
- sudo useradd -m -g developers -s /bin/bash alice
- sudo useradd -m -g testers -s /bin/bash bob
- sudo useradd -m -g managers -s /bin/bash charlie
- sudo useradd -m -g developers -s /bin/bash david

# 사용자 패스워드 설정
- sudo passwd alice
- sudo passwd bob
- sudo passwd charlie
- sudo passwd david


# 문제 1: 기본 권한 확인 및 변경
- 상황
- 개발팀에서 프로젝트 파일을 관리하기 위한 디렉터리 구조를 만들어야 합니다.
## 실습 과제
- /home/project 디렉터리를 생성하고 alice 사용자의 소유로 설정하세요.
- 해당 디렉터리 내에 다음 파일들을 생성하세요:
- README.md
- config.conf
- deploy.sh

## 각 파일의 현재 권한을 확인하고 다음과 같이 설정하세요:
- README.md: 모든 사용자가 읽을 수 있지만 소유자만 수정 가능
- config.conf: 소유자와 그룹만 읽고 쓸 수 있음
- deploy.sh: 소유자는 모든 권한, 그룹은 읽기/실행, 기타는 실행만 가능

## 각 파일의 변경된 권한을 확인하는 명령어를 실행하세요.
 - 요구사항
- ls -l 명령어로 권한 확인
- chmod 명령어의 기호 표기법과 숫자 표기법 모두 사용

- 각 단계별로 권한 변경 전후를 비교


# 문제 2: 소유권 변경 및 그룹 관리

- 상황
- 프로젝트 진행 중 파일들의 소유권을 팀원들과 공유해야 하는 상황이 발생했습니다.
- 실습 과제

# 문제 1에서 생성한 /home/project 디렉터리의 소유권을 다음과 같이 변경하세요:
- 소유자: alice
- 그룹: developers
- 디렉터리 내 파일들의 소유권을 다음과 같이 각각 변경하세요:
- README.md: 소유자는 bob, 그룹은 developers
- config.conf: 소유자는 alice, 그룹은 testers
- deploy.sh: 소유자는 charlie, 그룹은 managers
- stat 명령어를 사용하여 각 파일의 상세한 권한 정보를 확인하세요.
- david 사용자가 각 파일에 대해 가진 권한을 분석하고 설명하세요.

- 요구사항
- chown과 chgrp 명령어 사용
- 각 파일별로 소유권 변경 전후 비교
- stat 명령어로 상세 정보 확인

# 문제 3: 특수 권한 - SetUID와 SetGID
- 상황
- 시스템 관리용 스크립트에 특수 권한을 설정해야 합니다.
- 실습 과제
- /usr/local/bin 디렉터리에 다음 스크립트 파일들을 생성하세요:
- system_check.sh: 시스템 상태 확인 스크립트
- backup_manager.sh: 백업 관리 스크립트
- 각 스크립트에 간단한 내용을 작성하세요 (예: echo "System Check Running...").
## 권한을 다음과 같이 설정하세요:
- system_check.sh: SetUID 권한 설정, 소유자는 root
- backup_manager.sh: SetGID 권한 설정, 그룹은 managers
- 설정 후 ls -l 명령어로 특수 권한이 올바르게 설정되었는지 확인하세요.
- 일반 사용자(alice)로 로그인하여 각 스크립트를 실행해보고 결과를 확인하세요.
- 요구사항
- SetUID(4000)와 SetGID(2000) 권한 설정
- 숫자 표기법과 기호 표기법 모두 사용
- 특수 권한이 ls -l 출력에서 어떻게 표시되는지 확인

# 문제 4: Sticky Bit과 공유 디렉터리
- 상황
- 여러 사용자가 공유할 수 있는 임시 작업 디렉터리를 만들어야 합니다.
- 실습 과제
- /tmp/shared_workspace 디렉터리를 생성하세요.
- 이 디렉터리에 대해 다음과 같이 설정하세요:
- 모든 사용자가 읽기, 쓰기, 실행 권한을 가짐
- Sticky Bit 설정으로 파일 소유자만 자신의 파일을 삭제할 수 있도록 함
- 각 사용자(alice, bob, charlie, david)로 로그인하여 해당 디렉터리에 자신의이름으로 파일을 생성하세요.
- alice 사용자로 로그인하여 다른 사용자들이 생성한 파일들을 삭제해보세요.
- 각 사용자가 자신의 파일만 삭제할 수 있는지 확인하세요.
- 요구사항
- Sticky Bit(1000) 권한 설정
- 여러 사용자 계정으로 테스트
- 파일 삭제 권한 테스트 결과 분석

# 문제 5: 종합 권한 관리 시나리오
- 상황
- 회사에서 새로운 프로젝트를 위한 디렉터리 구조와 권한 체계를 구축해야 합니다.
- 실습 과제
- 다음과 같은 디렉터리 구조를 /opt/newproject 아래에 생성하세요:

 /opt/newproject/
├── src/
├── docs/
├── config/
├── logs/
└── scripts/


## 각 디렉터리와 그 안의 파일들에 대한 권한을 다음과 같이 설정하세요:


- src/: developers 그룹 소유, 그룹원들은 읽기/쓰기/실행 가능, 기타는 읽기만
- docs/: 모든 사용자가 읽을 수 있지만 managers 그룹만 수정 가능
- config/: alice 소유, developers 그룹은 읽기만, 기타는 접근 불가
- logs/: 모든 사용자가 쓸 수 있지만 Sticky Bit 설정
- scripts/: charlie 소유, SetGID 설정으로 managers 그룹 권한으로 실행
- 각 디렉터리에 테스트 파일을 생성하고 적절한 권한을 설정하세요.


# 다음 명령어들을 사용하여 설정한 권한들을 확인하세요:


- ls -la (각 디렉터리별로)
- stat (주요 파일들에 대해)
- find /opt/newproject -ls (전체 구조 확인)
- 각 사용자별로 접근 권한을 테스트하고 결과를 정리하세요.


- 요구사항
- 모든 권한 설정 명령어 사용 (chmod, chown, chgrp)
- 특수 권한 (SetUID, SetGID, Sticky Bit) 모두 활용
- 권한 확인 명령어 다양하게 사용
- 사용자별 접근 권한 테스트 및 결과 분석

# 제출 요구사항
- 각 문제별로 다음 내용을 포함하여 제출하세요:
- 실행한 명령어들의 순서대로 나열
- 각 단계별 화면 캡처 또는 명령어 출력 결과
- 권한 변경 전후 비교
- 발생한 문제점과 해결 과정
- 최종 결과 확인

- 주의사항:
- 모든 실습은 테스트 환경에서 진행하세요
- root 권한이 필요한 작업은 sudo를 사용하세요
- 각 단계별로 권한을 확인하는 습관을 기르세요
- 실습 후 생성한 사용자와 파일들을 정리하세요

