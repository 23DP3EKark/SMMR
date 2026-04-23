<style scoped>

</style>

<template>

    <div class="flex min-h-screen items-center justify-center bg-[#008080] px-4">
      <form action="login" class="w-full max-w-sm border-2 border-t-white border-r-black border-b-black border-l-white bg-[#c0c0c0] p-2">

        <h1 class="bg-[#000080] px-2 py-1 text-sm font-bold text-white">Reģistrācija</h1>

        <div class="flex flex-col gap-3 p-3 text-sm">
          <div>
            <label for="first_name" class="mb-1 block">vārds:</label>
            <input type="text" class="w-full border-2 border-t-black border-r-white border-b-white border-l-black bg-white px-1 py-[2px] outline-none" />
          </div>

          <div>
            <label for="last_name" class="mb-1 block">uzvārds:</label>
            <input type="text" class="w-full border-2 border-t-black border-r-white border-b-white border-l-black bg-white px-1 py-[2px] outline-none" />
          </div>

          <div>
            <label for="email" class="mb-1 block">epasts:</label>
            <input type="text" class="w-full border-2 border-t-black border-r-white border-b-white border-l-black bg-white px-1 py-[2px] outline-none" />
          </div>

          <div>
            <label for="password" class="mb-1 block">parole:</label>
            <input type="text" class="w-full border-2 border-t-black border-r-white border-b-white border-l-black bg-white px-1 py-[2px] outline-none" />
          </div>


          <div>
            <label for="password" class="mb-1 block">atkārtota parole:</label>
            <input type="password" class="w-full border-2 border-t-black border-r-white border-b-white border-l-black bg-white px-1 py-[2px] outline-none" />
          </div>

          <div class="flex items-center gap-1">
            <input type="checkbox" class="mr-2" />
            <label for="terms" class="text-xs">Es piekrītu </label>
            <a href="#" class="text-blue-900 underline text-xs">noteikumiem un nosacījumiem.</a>
          </div>


            <button class="border-2 border-t-white border-r-black border-b-black border-l-white bg-[#c0c0c0] px-3 py-1 active:border-t-black active:border-r-white active:border-b-white active:border-l-black">Pierakstīties</button>

          <div class="text-xs">
            <p>Jau esat reģistrējies?</p>
            <a href="/login" class="text-blue-900 underline">Pierakstīties.</a>
          </div>
        </div>
      </form>
    </div>

</template>

<script setup>

</script>
