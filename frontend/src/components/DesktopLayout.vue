<template>
  <div class="min-h-screen bg-[#008080] pb-24 md:pb-12">
    <router-view />
    <Taskbar />
  </div>
</template>

<script setup>
import Taskbar from './taskbar.vue';
</script>
