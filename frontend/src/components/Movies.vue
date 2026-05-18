<template>
    <ItunesSearch
        media="movie"
        title="Filmas"
        default-term=""
        placeholder="Filma vai rezisors"
        :genres="genres"
    />
</template>

<script setup>
import ItunesSearch from './ItunesSearch.vue';

const genres = [
    'Action',
    'Comedy',
    'Drama',
    'Sci-Fi',
    'Animation',
    'Thriller',
];
</script>
