<template>
  <TextFileWindow title="Izmantotie_avoti.txt" :content="sources" />
</template>

<script setup>
import sources from '../../content/Izmantotie_avoti.txt?raw';
import TextFileWindow from './TextFileWindow.vue';
</script>
