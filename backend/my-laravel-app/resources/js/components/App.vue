<style>
    body {
        margin: 0;
        padding: 0;
    }
</style>

<template>
    <div>
        <Header v-if="isLoggedIn" />

        

        <router-view></router-view>
    </div>
</template>

<script>
    import Header from './Header.vue';

    export default {
        computed: {
            isLoggedIn() {
                return localStorage.getItem('user');
            }
        },

        components: {
            Header
        }
    }
</script>