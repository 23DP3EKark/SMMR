<style scoped>
    .off-screen-menu {
        background-color: rgb(35, 35, 35);
    }

</style>

<template>
    <header>
        <nav>
            <ul class = "off-screen-menu">
                <li><router-link to="/"><img src="" alt=""></router-link></li>
                <li><router-link to="/quests">Darbi</router-link></li>
                <li><router-link to="/travel">Ceļojumi</router-link></li>
                <li><router-link to="/planner">Plānotājs</router-link></li>
                <li><router-link to="/movies">Filmas</router-link></li>
                <li><router-link to="/music">Mūzika</router-link></li>
                <li><router-link to="/registration">Reģistrācija</router-link></li>
                <li><router-link to="/login">Pieteikšanās</router-link></li>
            </ul>
        </nav>
    </header>
</template>

<script setup>

</script>