<template>
  <div class="flex min-h-[calc(100vh-6rem)] items-start justify-center p-4 pt-10 md:min-h-[calc(100vh-3rem)]">
    <div class="win-window w-full max-w-4xl">
      <div class="win-titlebar flex items-center justify-between">
        <span>{{ title }}</span>
        <router-link to="/desktop" class="win-btn px-2 py-0 text-black">X</router-link>
      </div>

      <div class="win-body">
        <pre class="max-h-[70vh] overflow-auto whitespace-pre-wrap border-2 border-t-black border-r-white border-b-white border-l-black bg-white p-3 font-mono text-sm text-black">{{ content }}</pre>
      </div>
    </div>
  </div>
</template>

<script setup>
defineProps({
  title: {
    type: String,
    required: true,
  },
  content: {
    type: String,
    required: true,
  },
});
</script>
