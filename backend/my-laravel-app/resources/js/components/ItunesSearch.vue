<template>
    <div class="flex min-h-[calc(100vh-6rem)] items-start justify-center p-4 pt-10 md:min-h-[calc(100vh-3rem)]">
        <div class="win-window w-full" :class="windowClass">
            <div class="win-titlebar flex items-center justify-between">
                <span>{{ title }}</span>
                <router-link to="/desktop" class="win-btn px-2 py-0 text-black">X</router-link>
            </div>

            <div class="win-body text-sm">
                <form class="grid gap-2 md:grid-cols-6" @submit.prevent="search">
                    <div>
                        <label :for="`${media}-search`">Meklet:</label>
                        <input
                            :id="`${media}-search`"
                            v-model="term"
                            type="search"
                            maxlength="100"
                            class="win-input w-full"
                            :placeholder="placeholder"
                        >
                    </div>

                    <div>
                        <label :for="`${media}-genre`">Zanrs:</label>
                        <select :id="`${media}-genre`" v-model="genre" class="win-input w-full md:w-36">
                            <option value="">Visi</option>
                            <option
                                v-for="genreOption in genres"
                                :key="genreOption"
                                :value="genreOption"
                            >
                                {{ genreOption }}
                            </option>
                        </select>
                    </div>

                    <div>
                        <label :for="`${media}-year-from`">Gads no:</label>
                        <input
                            :id="`${media}-year-from`"
                            v-model="yearFrom"
                            type="number"
                            min="1900"
                            max="2100"
                            class="win-input w-full"
                        >
                    </div>

                    <div>
                        <label :for="`${media}-year-to`">Gads lidz:</label>
                        <input
                            :id="`${media}-year-to`"
                            v-model="yearTo"
                            type="number"
                            min="1900"
                            max="2100"
                            class="win-input w-full"
                        >
                    </div>

                    <div>
                        <label :for="`${media}-sort-by`">Kartot:</label>
                        <select :id="`${media}-sort-by`" v-model="sortBy" class="win-input w-full">
                            <option value="title">Nosaukums</option>
                            <option value="creator">{{ creatorLabel }}</option>
                            <option value="year">Gads</option>
                        </select>
                    </div>

                    <div>
                        <label :for="`${media}-sort-direction`">Seciba:</label>
                        <select :id="`${media}-sort-direction`" v-model="sortDirection" class="win-input w-full">
                            <option value="asc">Augosa</option>
                            <option value="desc">Dilstosa</option>
                        </select>
                    </div>

                    <div class="flex items-end">
                        <button type="submit" class="win-btn w-full md:w-auto" :disabled="loading">
                            {{ loading ? 'Mekle...' : 'Meklet' }}
                        </button>
                    </div>
                </form>

                <p v-if="errorMessage" class="text-red-700">{{ errorMessage }}</p>
                <p v-if="!loading && searched && results.length === 0">Nekas netika atrasts.</p>

                <div v-if="results.length > 0" class="grid gap-3" :class="resultsGridClass">
                    <article
                        v-for="item in results"
                        :key="item.id ?? `${item.title}-${item.artist}`"
                        class="border-2 border-t-white border-r-black border-b-black border-l-white bg-[#c0c0c0] p-2"
                    >
                        <div class="flex gap-3">
                            <img
                                v-if="item.artwork && !brokenImages[item.id]"
                                :src="item.artwork"
                                :alt="item.title"
                                class="shrink-0 border-2 border-t-black border-r-white border-b-white border-l-black object-cover"
                                :class="artworkClass"
                                @error="brokenImages[item.id] = true"
                            >
                            <div
                                v-else
                                class="flex shrink-0 items-center justify-center border-2 border-t-black border-r-white border-b-white border-l-black bg-[#008080] p-2 text-center text-xs font-bold text-white"
                                :class="artworkClass"
                            >
                                {{ item.title }}
                            </div>

                            <div class="min-w-0 flex-1">
                                <h2 class="truncate font-bold">{{ item.title }}</h2>
                                <p v-if="item.artist" class="truncate">{{ item.artist }}</p>
                                <p v-if="item.collection && item.collection !== item.title" class="truncate text-xs">
                                    {{ item.collection }}
                                </p>
                                <p class="text-xs">
                                    <span v-if="item.release_date">{{ item.release_date }}</span>
                                    <span v-if="item.release_date && item.genre"> - </span>
                                    <span v-if="item.genre">{{ item.genre }}</span>
                                </p>
                                <p v-if="formatPrice(item)" class="text-xs">{{ formatPrice(item) }}</p>
                            </div>
                        </div>

                        <p v-if="item.description" class="mt-2 line-clamp-3 text-xs">
                            {{ item.description }}
                        </p>

                        <div class="mt-2 flex flex-wrap items-center gap-2">
                            <audio
                                v-if="item.preview_url && media === 'music'"
                                :src="item.preview_url"
                                controls
                                preload="none"
                                class="h-9 w-full"
                            />

                            <a
                                v-if="item.preview_url && media === 'movie'"
                                :href="item.preview_url"
                                target="_blank"
                                rel="noreferrer"
                                class="win-btn inline-block"
                            >
                                Skatities trailer
                            </a>

                            <a
                                v-if="item.store_url"
                                :href="item.store_url"
                                target="_blank"
                                rel="noreferrer"
                                class="win-btn inline-block"
                            >
                                Atvert iTunes
                            </a>
                        </div>
                    </article>
                </div>

                <p class="text-xs">Dati no lokalas datubazes.</p>
            </div>
        </div>
    </div>
</template>

<script setup>
import axios from 'axios';
import { computed, onMounted, ref } from 'vue';

const props = defineProps({
    media: {
        type: String,
        required: true,
        validator: (value) => ['music', 'movie'].includes(value),
    },
    title: {
        type: String,
        required: true,
    },
    defaultTerm: {
        type: String,
        required: true,
    },
    placeholder: {
        type: String,
        required: true,
    },
    genres: {
        type: Array,
        default: () => [],
    },
});

const term = ref(props.defaultTerm);
const genre = ref('');
const results = ref([]);
const loading = ref(false);
const searched = ref(false);
const errorMessage = ref('');
const brokenImages = ref({});
const yearFrom = ref('');
const yearTo = ref('');
const sortBy = ref('title');
const sortDirection = ref('asc');

const windowClass = computed(() => props.media === 'movie' ? 'max-w-6xl' : 'max-w-4xl');
const resultsGridClass = computed(() => props.media === 'movie' ? 'md:grid-cols-2 xl:grid-cols-3' : 'md:grid-cols-2');
const artworkClass = computed(() => props.media === 'movie' ? 'h-40 w-28' : 'h-24 w-24');
const creatorLabel = computed(() => props.media === 'movie' ? 'Studija' : 'Makslinieks');

const search = async () => {
    loading.value = true;
    searched.value = true;
    errorMessage.value = '';
    brokenImages.value = {};

    try {
        const response = await axios.get('/itunes/search', {
            params: {
                term: term.value,
                media: props.media,
                genre: genre.value,
                year_from: yearFrom.value,
                year_to: yearTo.value,
                sort_by: sortBy.value,
                sort_direction: sortDirection.value,
                limit: 12,
            },
        });

        results.value = response.data.results ?? [];
    } catch (error) {
        errorMessage.value = error.response?.data?.message ?? 'Neizdevas ieladet rezultatus.';
        results.value = [];
    } finally {
        loading.value = false;
    }
};

const formatPrice = (item) => {
    if (item.price === null || item.price === undefined || item.price < 0) {
        return '';
    }

    return `${item.price} ${item.currency}`.trim();
};

onMounted(() => {
    search();
});
</script>
