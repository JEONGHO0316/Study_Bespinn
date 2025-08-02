✅ 문제 : 간단한 서버 관리 스크립트 작성
🔧 요구사항
- start: 포트 8000에서 http.server를 백그라운드로 실행 (nohup, 로그는 server.log)
- stop: 실행 중인 프로세스를 찾아 종료
- status: 프로세스가 실행 중인지 확인하여 출력
- restart: 중지 후 다시 실행

```
🎯 실행 예시
$ ./webserver.sh start
서버가 백그라운드에서 시작되었습니다.

$ ./webserver.sh status
서버 실행 중입니다. PID: 13579

$ ./webserver.sh stop
서버가 종료되었습니다.

$ ./webserver.sh tail_log
… log message 확인

문제 모두 조건에 따라:
if [ "$1" == "start" ] 식으로 흐름 제어


변수 PORT, PID, LOGFILE 등을 정의해 구성 가능
```
```
[jeongho@192.168.0.47 ~/Downloads]$ source webserver.sh start
서버가 백그라운드에서 시작되었습니다.
[jeongho@192.168.0.47 ~/Downloads]$ source webserver.sh status
서버 실행 중입니다. PID:9571 
[jeongho@192.168.0.47 ~/Downloads]$ source webserver.sh tail_log
  File "/usr/lib64/python3.9/http/server.py", line 137, in server_bind
    socketserver.TCPServer.server_bind(self)
  File "/usr/lib64/python3.9/socketserver.py", line 466, in server_bind
    self.socket.bind(self.server_address)
OSError: [Errno 98] Address already in use
127.0.0.1 - - [28/Jul/2025 15:36:51] "GET / HTTP/1.1" 200 -
127.0.0.1 - - [28/Jul/2025 15:37:11] "GET / HTTP/1.1" 200 -
127.0.0.1 - - [28/Jul/2025 15:37:23] "GET / HTTP/1.1" 200 -
nohup: ignoring input
nohup: ignoring input
^C
[jeongho@192.168.0.47 ~/Downloads]$ source webserver.sh stop
[1]+  Killed                  nohup python3 -m http.server 8000 --bind 0.0.0.0 &>> server.log
[jeongho@192.168.0.47 ~/Downloads]$ 

```
```
#!/bin/bash
ip="$1"
log_log="cat ./server.log"

if [ "$1" == "start" ]; then
        nohup python3 -m http.server 8000 --bind 0.0.0.0 &>> server.log &
        echo "서버가 백그라운드에서 시작되었습니다."
elif [ "$1" == "stop" ]; then
        PID_STOP=$(ps aux | grep "http.server 8000 --bind" | cut -d" " -f6 | head -n 1)
        kill -9 $PID_STOP 
elif [ "$1" == "status" ]; then
        PID_NAME=$(ps aux | grep "http.server 8000 --bind" | cut -d" " -f6 | head -1)

        echo "서버 실행 중입니다. PID:$PID_NAME "
elif [ "$1" == "tail_log" ]; then
        tail -f ./server.log
#cat server.log
fi
```