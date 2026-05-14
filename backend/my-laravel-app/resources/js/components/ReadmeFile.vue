<template>
  <TextFileWindow title="README.md" :content="readme" />
</template>

<script setup>
import readme from '../../content/README.md?raw';
import TextFileWindow from './TextFileWindow.vue';
</script>
