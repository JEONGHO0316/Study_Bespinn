<script setup lang="ts">
import HelloWorld from './components/HelloWorld.vue'
// 이미지 경로를 본인 파일 위치에 맞게 수정하세요.
// (현재 App.vue와 같은 폴더에 wr-home-top.jpg가 있다고 가정)
import bgImage from '../src/wr-home-top.jpg' 
</script>

<template>
  <div class="container">
    
    <div class="image-wrapper">
      <img :src="bgImage" alt="Top Image" class="top-image" />
    </div>

    <div class="content-wrapper">
      <div class="logos">
        <a href="https://vite.dev" target="_blank">
          <img src="/vite.svg" class="logo" alt="Vite logo" />
        </a>
        <a href="https://vuejs.org/" target="_blank">
          <img src="./assets/vue.svg" class="logo vue" alt="Vue logo" />
        </a>
      </div>
      
      <HelloWorld msg="you Pipeline auto test 2 !" />
    </div>

  </div>
</template>

<style scoped>
/* 전체 레이아웃 */
.container {
  width: 100%;
  min-height: 100vh; /* 내용이 적어도 화면 꽉 차게 */
  display: flex;
  flex-direction: column; /* 위에서 아래로 배치 */
  align-items: center; /* 가로 중앙 정렬 */
  background-color: #242424; /* 전체 배경색 */
}

/* 이미지 영역 */
.image-wrapper {
  width: 100%;
  display: flex;
  justify-content: center;
  background-color: #000; /* 이미지 빈공간 검게 */
}

.top-image {
  max-width: 100%; /* 화면보다 크면 줄어들게 */
  height: auto;    /* 비율 유지 */
  display: block;
  /* 너무 커지는게 싫으면 아래 주석을 푸세요 (예: 최대 600px) */
  /* max-width: 600px; */
}

/* 콘텐츠 영역 */
.content-wrapper {
  padding: 2rem;
  text-align: center;
}

/* 로고 스타일 (기존 유지) */
.logos {
  margin-bottom: 2rem;
}

.logo {
  height: 6em;
  padding: 1.5em;
  will-change: filter;
  transition: filter 300ms;
}
.logo:hover {
  filter: drop-shadow(0 0 2em #646cffaa);
}
.logo.vue:hover {
  filter: drop-shadow(0 0 2em #42b883aa);
}
</style>