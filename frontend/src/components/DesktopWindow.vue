<template>
  <div class="flex min-h-[calc(100vh-6rem)] items-start justify-center p-4 pt-10 md:min-h-[calc(100vh-3rem)]">
    <div class="win-window w-full max-w-2xl">
      <div class="win-titlebar flex items-center justify-between">
        <span>{{ title }}</span>
        <router-link to="/desktop" class="win-btn px-2 py-0 text-black">X</router-link>
      </div>

      <div class="win-body min-h-64">
        <slot />
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue';
import { useRoute } from 'vue-router';

const route = useRoute();
const title = computed(() => route.meta.title ?? 'Window');
</script>
