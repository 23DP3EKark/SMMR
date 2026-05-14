<template>
    <div class="flex min-h-[calc(100vh-6rem)] items-start justify-center p-4 pt-10 md:min-h-[calc(100vh-3rem)]">
        <div class="win-window w-full max-w-5xl">
            <div class="win-titlebar flex items-center justify-between">
                <span>Celojumi</span>
                <router-link to="/desktop" class="win-btn px-2 py-0 text-black">X</router-link>
            </div>

            <div class="win-body text-sm">
                <form class="mb-3 grid gap-2 md:grid-cols-6" @submit.prevent="loadDestinations">
                    <div>
                        <label for="travel-search">Meklet:</label>
                        <input id="travel-search" v-model="term" type="search" maxlength="100" class="win-input w-full">
                    </div>

                    <div>
                        <label for="travel-attraction">Apskates vieta:</label>
                        <input id="travel-attraction" v-model="attraction" type="search" maxlength="100" class="win-input w-full">
                    </div>

                    <div>
                        <label for="travel-max-price">Cena lidz:</label>
                        <input id="travel-max-price" v-model="maxPrice" type="number" min="0" class="win-input w-full">
                    </div>

                    <div>
                        <label for="travel-sort">Kartot:</label>
                        <select id="travel-sort" v-model="sortMode" class="win-input w-full">
                            <option value="price">Cena</option>
                            <option value="name">Nosaukums</option>
                        </select>
                    </div>

                    <div>
                        <label for="travel-sort-direction">Seciba:</label>
                        <select id="travel-sort-direction" v-model="sortDirection" class="win-input w-full">
                            <option value="asc">Augosa</option>
                            <option value="desc">Dilstosa</option>
                        </select>
                    </div>

                    <div class="flex items-end">
                        <button type="submit" class="win-btn w-full" :disabled="loading">
                            {{ loading ? 'Ielade...' : 'Meklet' }}
                        </button>
                    </div>
                </form>

                <p v-if="errorMessage" class="text-red-700">{{ errorMessage }}</p>
                <p v-if="!loading && destinations.length === 0">Nav celojumu datu.</p>

                <div v-if="destinations.length > 0" class="mb-3 grid gap-2 md:grid-cols-3">
                    <div class="border-2 border-t-black border-r-white border-b-white border-l-black bg-white p-2">
                        <p class="text-xs">Videja cena</p>
                        <p class="font-bold">${{ formatMoney(travelStats.average) }}</p>
                    </div>

                    <div class="border-2 border-t-black border-r-white border-b-white border-l-black bg-white p-2">
                        <p class="text-xs">Letakais</p>
                        <p class="font-bold">{{ travelStats.cheapest.name }} - ${{ formatMoney(travelStats.cheapest.weekly_cost_estimate) }}</p>
                    </div>

                    <div class="border-2 border-t-black border-r-white border-b-white border-l-black bg-white p-2">
                        <p class="text-xs">Dargakais</p>
                        <p class="font-bold">{{ travelStats.mostExpensive.name }} - ${{ formatMoney(travelStats.mostExpensive.weekly_cost_estimate) }}</p>
                    </div>
                </div>

                <div class="grid gap-3 md:grid-cols-2">
                    <article
                        v-for="destination in sortedDestinations"
                        :key="destination.id"
                        class="border-2 border-t-white border-r-black border-b-black border-l-white bg-[#c0c0c0]"
                    >
                        <div class="flex min-h-24 items-end border-2 border-t-black border-r-white border-b-white border-l-black bg-[#008080] p-3 text-white">
                            <div>
                                <h2 class="text-lg font-bold">{{ destination.name }}</h2>
                                <p class="text-xs">Aptuveni ${{ formatMoney(destination.weekly_cost_estimate) }} / 7 dienas</p>
                            </div>
                        </div>

                        <div class="p-3">
                            <p>{{ destination.description }}</p>

                            <div v-if="destination.attractions.length" class="mt-3">
                                <h3 class="font-bold">Ko apskatit:</h3>
                                <ul class="list-inside list-disc">
                                    <li v-for="attraction in destination.attractions" :key="attraction">
                                        {{ attraction }}
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </article>
                </div>

                <p class="mt-3 text-xs">
                    Izmaksas ir mid-range estimates vienai personai bez lidojumiem.
                </p>
            </div>
        </div>
    </div>
</template>

<script setup>
import axios from 'axios';
import { computed, onMounted, ref } from 'vue';

const destinations = ref([]);
const loading = ref(false);
const errorMessage = ref('');
const sortMode = ref('price');
const sortDirection = ref('asc');
const term = ref('');
const attraction = ref('');
const maxPrice = ref('');

const travelStats = computed(() => {
    const prices = destinations.value.map((destination) => destination.weekly_cost_estimate);
    const total = prices.reduce((sum, price) => sum + price, 0);
    const average = total / prices.length;
    const cheapest = destinations.value.reduce((best, destination) => {
        return destination.weekly_cost_estimate < best.weekly_cost_estimate ? destination : best;
    }, destinations.value[0]);
    const mostExpensive = destinations.value.reduce((best, destination) => {
        return destination.weekly_cost_estimate > best.weekly_cost_estimate ? destination : best;
    }, destinations.value[0]);

    return {
        average,
        cheapest,
        mostExpensive,
    };
});

const sortedDestinations = computed(() => {
    return [...destinations.value].sort((a, b) => {
        const direction = sortDirection.value === 'desc' ? -1 : 1;

        if (sortMode.value === 'name') {
            return a.name.localeCompare(b.name) * direction;
        }

        return (a.weekly_cost_estimate - b.weekly_cost_estimate) * direction;
    });
});

const loadDestinations = async () => {
    loading.value = true;
    errorMessage.value = '';

    try {
        const response = await axios.get('/travel/destinations', {
            params: {
                term: term.value,
                attraction: attraction.value,
                max_price: maxPrice.value,
                sort_by: sortMode.value,
                sort_direction: sortDirection.value,
            },
        });
        destinations.value = response.data.destinations ?? [];
    } catch (error) {
        errorMessage.value = error.response?.data?.message ?? 'Neizdevas ieladet celojumus.';
        destinations.value = [];
    } finally {
        loading.value = false;
    }
};

const formatMoney = (amount) => {
    return Number(amount).toLocaleString('en-US', {
        maximumFractionDigits: 0,
    });
};

onMounted(() => {
    loadDestinations();
});
</script>
