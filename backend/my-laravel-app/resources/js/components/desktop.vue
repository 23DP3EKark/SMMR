<style scoped>

</style>

<template>
    <div class="grid grid-cols-1 md:grid-cols-[1fr_2fr] lg:grid-cols-[1fr_3fr] bg-[#008080] w-screen h-screen">
        <div class="grid grid-cols-2">
            <div class="flex flex-col items-center gap-5 mt-10">
                <router-link to="/todo" class="desktop-icon">
                    <img  class="icon-drop-shadow" src="/resources/images/Folder-Icon-PNG.png" alt="">
                    <span class="text-shadow">To-do</span>
                </router-link>

                <router-link to="/travel" class="desktop-icon">
                    <img class="icon-drop-shadow" src="/resources/images/Folder-Icon-PNG.png" alt="">
                    <span class="text-shadow">Ceļojumi</span>
                </router-link>

                <router-link to="/music" class="desktop-icon">
                    <img class="icon-drop-shadow" src="/resources/images/Folder-Icon-PNG.png" alt="">
                    <span class="text-shadow">Mūzika</span>
                </router-link>

                <router-link to="/movies" class="desktop-icon">
                    <img class="icon-drop-shadow" src="/resources/images/Folder-Icon-PNG.png" alt="">
                    <span class="text-shadow">Filmas</span>
                </router-link>
            </div>

            <div class="flex flex-col items-center gap-5 mt-10">
                <router-link to="/readme" class="desktop-icon">
                    <img class="icon-drop-shadow" src="/resources/images/Folder-Icon-PNG.png" alt="">
                    <span class="text-shadow">README.md</span>
                </router-link>

                <router-link to="/sources" class="desktop-icon">
                    <img class="icon-drop-shadow" src="/resources/images/Folder-Icon-PNG.png" alt="">
                    <span class="text-shadow">Izmantotie_avoti.txt</span>
                </router-link>

                <router-link to="/surprise" class="desktop-icon">
                    <img class="icon-drop-shadow" src="/resources/images/Folder-Icon-PNG.png" alt="">
                    <span class="text-shadow">Pārsteigums.exe</span>
                </router-link>
            </div>
        </div>

        <div class="">

        </div>
    </div>

    <Taskbar />
</template>

<script setup>
    import Taskbar from './Taskbar.vue';
</script>