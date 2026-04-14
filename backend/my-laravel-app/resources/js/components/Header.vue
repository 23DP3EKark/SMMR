<style scoped>
.navbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: #FFFFFF;
    padding: 10px 20px;
    border-bottom: 1px solid #DADADA;
}

.navbar .logo a {
    font-size: 30px;
    color: #000000;
    text-decoration: none;
    font-family: 'Pixelify Sans', sans-serif;
    font-weight: 600;
}

.navbar .nav-links a {
    margin: 0 15px;
    color: #000000;
    text-decoration: none;
    font-size: 18px;
    font-family: 'nunito', sans-serif;
}

.navbar .profile-link {
    text-decoration: none;
}

.navbar .profile-circle {
    width: 50px;
    height: 50px;
    background-image: linear-gradient(to bottom, #9D0208, #D00000);
    color: #FFFFFF;
    border-radius: 50%;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 18px;
    font-family: 'sono', sans-serif;
}


</style>

<template>
    <header>
        <nav class="navbar">
            <div class="logo">
                <router-link to="/">SMMR</router-link>
            </div>

            <div class="nav-links">
                <router-link to="/">Sākums</router-link>
                <router-link to="/quests">Plānotājs</router-link>
                <router-link to="/travel">Ceļojumi</router-link>
                <router-link to="/movies">Filmas</router-link>
                <router-link to="/music">Mūzika</router-link>
            </div>

            <router-link to="/profile" class="profile-link">
                <div class="profile-circle">
                    {{ userInitials }}
                </div>
            </router-link>
        </nav>
    </header>
</template>

<script setup>
    
</script>
