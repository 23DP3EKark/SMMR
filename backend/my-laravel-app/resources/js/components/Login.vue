<style scoped>

</style>

<template>
  <div class="flex min-h-screen items-center justify-center bg-[#008080] px-4">
    <form @submit.prevent="login" class="w-full max-w-sm border-2 border-t-white border-r-black border-b-black border-l-white bg-[#c0c0c0] p-2">
      <h1 class="bg-[#000080] px-2 py-1 text-sm font-bold text-white">Pierakstisanas</h1>

      <div class="flex flex-col gap-3 p-3 text-sm">
        <div>
          <label for="email" class="mb-1 block">Epasts:</label>
          <input v-model="form.email" type="email" class="w-full border-2 border-t-black border-r-white border-b-white border-l-black bg-white px-1 py-[2px] outline-none" required />
        </div>

        <div>
          <label for="password" class="mb-1 block">Parole:</label>
          <input v-model="form.password" type="password" class="w-full border-2 border-t-black border-r-white border-b-white border-l-black bg-white px-1 py-[2px] outline-none" required />
        </div>

        <button class="border-2 border-t-white border-r-black border-b-black border-l-white bg-[#c0c0c0] px-3 py-1 active:border-t-black active:border-r-white active:border-b-white active:border-l-black">
          Pierakstīties
        </button>

        <p v-if="successMessage" class="text-green-700">{{ successMessage }}</p>
        <p v-if="errorMessage" class="text-red-700">{{ errorMessage }}</p>

        <div class="text-xs">
          <p>Nav konta?</p>
          <a href="/register" class="text-blue-900 underline">Izveidot vienu.</a>
        </div>
      </div>
    </form>
  </div>
</template>

<script setup>
import axios from 'axios';
import { ref } from 'vue';

const form = ref({
  email: '',
  password: '',
});

const successMessage = ref('');
const errorMessage = ref('');

const login = async () => {
  successMessage.value = '';
  errorMessage.value = '';

  try {
    const response = await axios.post('/api/login', form.value);
    successMessage.value = response.data.message;
  } catch (error) {
    errorMessage.value = error.response?.data?.message ?? 'Login failed.';
  }
};
</script>