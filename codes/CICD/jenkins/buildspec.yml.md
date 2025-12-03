### artifacts 사용 하여 원하는 파일 CI 
```
version: 0.2

phases:
  install:
    runtime-versions:
      nodejs: 22
    commands:
      - echo node version check
      - node -v 
      - npm -v 
  pre_build:
    commands:
      - echo Installing dependencies...
      - npm install
  build:
    commands:
      - echo Building...
      - npm run build
  post_build:
    commands:
      - echo post Building 

artifacts:
  files:
    - dist/**/*
    - appspec.yml
    - scripts/**/*
  discard-paths: no
```