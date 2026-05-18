<template>
    <ItunesSearch
        media="music"
        title="Muzika"
        default-term=""
        placeholder="Dziesma vai makslinieks"
        :genres="genres"
    />
</template>

<script setup>
import ItunesSearch from './ItunesSearch.vue';

const genres = [
    'Pop',
    'Rock',
    'Hip-Hop',
    'Electronic',
    'R&B',
    'Jazz',
];
</script>
