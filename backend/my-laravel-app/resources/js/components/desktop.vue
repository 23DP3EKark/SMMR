<style scoped>

</style>

<template>
  <div class="grid min-h-[calc(100vh-6rem)] w-full grid-cols-1 md:min-h-[calc(100vh-3rem)] md:grid-cols-[1fr_2fr] lg:grid-cols-[1fr_3fr]">
    <div class="grid grid-cols-2">
      <div class="mt-10 flex flex-col items-center gap-5">
        <router-link to="/desktop/todo" class="desktop-icon">
          <img class="icon-drop-shadow" src="/resources/images/Folder-Icon-PNG.png" alt="">
          <span class="text-shadow">To-do</span>
        </router-link>

        <router-link to="/desktop/travel" class="desktop-icon">
          <img class="icon-drop-shadow" src="/resources/images/Folder-Icon-PNG.png" alt="">
          <span class="text-shadow">Celojumi</span>
        </router-link>

        <router-link to="/desktop/music" class="desktop-icon">
          <img class="icon-drop-shadow" src="/resources/images/Folder-Icon-PNG.png" alt="">
          <span class="text-shadow">Muzika</span>
        </router-link>

        <router-link to="/desktop/movies" class="desktop-icon">
          <img class="icon-drop-shadow" src="/resources/images/Folder-Icon-PNG.png" alt="">
          <span class="text-shadow">Filmas</span>
        </router-link>
      </div>

      <div class="mt-10 flex flex-col items-center gap-5">
        <router-link to="/desktop/readme" class="desktop-icon">
          <img class="icon-drop-shadow" src="/resources/images/Folder-Icon-PNG.png" alt="">
          <span class="text-shadow">README.md</span>
        </router-link>

        <router-link to="/desktop/sources" class="desktop-icon">
          <img class="icon-drop-shadow" src="/resources/images/Folder-Icon-PNG.png" alt="">
          <span class="text-shadow">Izmantotie_avoti.txt</span>
        </router-link>

        <router-link to="/desktop/surprise" class="desktop-icon">
          <img class="icon-drop-shadow" src="/resources/images/Folder-Icon-PNG.png" alt="">
          <span class="text-shadow">Parsteigums.exe</span>
        </router-link>
      </div>
    </div>

    <div></div>
  </div>
</template>
