<style scoped>

</style>

<template>
    <div class="flex min-h-screen items-center justify-center bg-[#008080] px-4">
      <form action="login" class="w-full max-w-sm border-2 border-t-white border-r-black border-b-black border-l-white bg-[#c0c0c0] p-2">

        <h1 class="bg-[#000080] px-2 py-1 text-sm font-bold text-white">Pierakstīšanās</h1>

        <div class="flex flex-col gap-3 p-3 text-sm">
          <div>
            <label for="email" class="mb-1 block">epasts:</label>
            <input type="text" class="w-full border-2 border-t-black border-r-white border-b-white border-l-black bg-white px-1 py-[2px] outline-none" />
          </div>

          <div>
            <label for="password" class="mb-1 block">parole:</label>
            <input type="password" class="w-full border-2 border-t-black border-r-white border-b-white border-l-black bg-white px-1 py-[2px] outline-none" />
          </div>

          <button class="border-2 border-t-white border-r-black border-b-black border-l-white bg-[#c0c0c0] px-3 py-1 active:border-t-black active:border-r-white active:border-b-white active:border-l-black">Pierakstīties</button>

          <div class="text-xs">
            <p>Nav konta?</p>
            <a href="/register" class="text-blue-900 underline">Izveidot vienu.</a>
          </div>
        </div>
      </form>
    </div>
</template>

<script setup>

</script>