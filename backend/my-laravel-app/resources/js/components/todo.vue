<template>
    <div class="flex min-h-[calc(100vh-6rem)] items-start justify-center p-4 pt-10 md:min-h-[calc(100vh-3rem)]">
        <div class="win-window w-full max-w-2xl">
            <div class="win-titlebar flex items-center justify-between">
                <span>To-do</span>
                <router-link to="/desktop" class="win-btn px-2 py-0 text-black">X</router-link>
            </div>

            <div class="win-body min-h-64 text-sm">
                <form class="flex flex-col gap-3" @submit.prevent="createTodoItem">
                    <p v-if="loading">Ielade...</p>
                    <p v-if="errorMessage" class="text-red-700">{{ errorMessage }}</p>
                    <p v-if="successMessage" class="text-green-700">{{ successMessage }}</p>

                    <div>
                        <label for="title">Nosaukums:</label>
                        <input type="text" id="title" v-model="title" maxlength="100" class="win-input w-full">
                    </div>

                    <div>
                        <label for="description">Apraksts:</label>
                        <textarea id="description" v-model="description" rows="3" class="win-input w-full resize-none"></textarea>
                    </div>

                    <button type="submit" class="win-btn w-fit">
                        Pievienot
                    </button>
                </form>

                <div class="mt-3 flex flex-col gap-2">
                    <h1 class="text-sm font-bold">
                        Uzdevumi:
                    </h1>

                    <div class="grid gap-2 md:grid-cols-4">
                        <div class="border-2 border-t-black border-r-white border-b-white border-l-black bg-white p-2">
                            <p class="text-xs">Kopa</p>
                            <p class="font-bold">{{ todoStats.total }}</p>
                        </div>

                        <div class="border-2 border-t-black border-r-white border-b-white border-l-black bg-white p-2">
                            <p class="text-xs">Aktivi</p>
                            <p class="font-bold">{{ todoStats.active }}</p>
                        </div>

                        <div class="border-2 border-t-black border-r-white border-b-white border-l-black bg-white p-2">
                            <p class="text-xs">Pabeigti</p>
                            <p class="font-bold">{{ todoStats.completed }}</p>
                        </div>

                        <div class="border-2 border-t-black border-r-white border-b-white border-l-black bg-white p-2">
                            <p class="text-xs">Progress</p>
                            <p class="font-bold">{{ todoStats.percent }}%</p>
                        </div>
                    </div>

                    <div class="grid gap-2 md:grid-cols-4">
                        <div>
                            <label for="todo-search">Meklet:</label>
                            <input id="todo-search" v-model="searchTerm" type="search" maxlength="100" class="win-input w-full">
                        </div>

                        <div>
                            <label for="todo-status">Statuss:</label>
                            <select id="todo-status" v-model="statusFilter" class="win-input w-full">
                                <option value="all">Visi</option>
                                <option value="active">Aktivi</option>
                                <option value="completed">Pabeigti</option>
                            </select>
                        </div>

                        <div>
                            <label for="todo-sort">Kartot:</label>
                            <select id="todo-sort" v-model="sortBy" class="win-input w-full">
                                <option value="created_at">Izveides datums</option>
                                <option value="title">Nosaukums</option>
                                <option value="status">Statuss</option>
                            </select>
                        </div>

                        <div>
                            <label for="todo-sort-direction">Seciba:</label>
                            <select id="todo-sort-direction" v-model="sortDirection" class="win-input w-full">
                                <option value="desc">Dilstosa</option>
                                <option value="asc">Augosa</option>
                            </select>
                        </div>
                    </div>

                    <p v-if="!loading && filteredTodoItems.length === 0">
                        Nav uzdevumu.
                    </p>

                    <div v-for="todoItem in filteredTodoItems" :key="todoItem.id" class="border-2 border-t-white border-r-black border-b-black border-l-white bg-[#c0c0c0] p-2">
                        <div v-if="editingTodoId === todoItem.id" class="flex flex-col gap-2">
                            <div>
                                <label :for="`edit_title_${todoItem.id}`">Nosaukums:</label>
                                <input type="text" :id="`edit_title_${todoItem.id}`" v-model="editTitle" maxlength="100" class="win-input w-full">
                            </div>

                            <div>
                                <label :for="`edit_description_${todoItem.id}`">Apraksts:</label>
                                <textarea :id="`edit_description_${todoItem.id}`" v-model="editDescription" rows="3" class="win-input w-full resize-none"></textarea>
                            </div>

                            <div class="flex flex-wrap gap-2">
                                <button type="button" class="win-btn" @click="updateTodoItem(todoItem)">
                                    Saglabat
                                </button>

                                <button type="button" class="win-btn" @click="cancelEditing">
                                    Atcelt
                                </button>
                            </div>
                        </div>

                        <div v-else class="flex flex-col gap-2">
                            <div class="flex items-start gap-2">
                                <input type="checkbox" :checked="todoItem.is_completed" class="mt-1" @change="toggleTodoItem(todoItem)">

                                <div class="flex-1">
                                    <h2 :class="todoItem.is_completed ? 'font-bold line-through' : 'font-bold'">
                                        {{ todoItem.title }}
                                    </h2>

                                    <p v-if="todoItem.description" :class="todoItem.is_completed ? 'line-through' : ''">
                                        {{ todoItem.description }}
                                    </p>
                                </div>
                            </div>

                            <div class="flex flex-wrap gap-2">
                                <button type="button" class="win-btn" @click="startEditing(todoItem)">
                                    Labot
                                </button>

                                <button type="button" class="win-btn bg-red-600" @click="deleteTodoItem(todoItem.id)">
                                    Dzest
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import axios from 'axios';
import { computed, onMounted, ref } from 'vue';

const todoItems = ref([]);
const loading = ref(true);
const errorMessage = ref('');
const successMessage = ref('');

const title = ref('');
const description = ref('');

const editingTodoId = ref(null);
const editTitle = ref('');
const editDescription = ref('');
const searchTerm = ref('');
const statusFilter = ref('all');
const sortBy = ref('created_at');
const sortDirection = ref('desc');

const todoStats = computed(() => {
    const total = todoItems.value.length;
    const completed = todoItems.value.filter((todoItem) => todoItem.is_completed).length;
    const active = total - completed;
    const percent = total === 0 ? 0 : Math.round((completed / total) * 100);

    return {
        total,
        completed,
        active,
        percent,
    };
});

const filteredTodoItems = computed(() => {
    const search = searchTerm.value.trim().toLowerCase();
    const direction = sortDirection.value === 'desc' ? -1 : 1;

    return todoItems.value
        .filter((todoItem) => {
            if (statusFilter.value === 'active' && todoItem.is_completed) {
                return false;
            }

            if (statusFilter.value === 'completed' && !todoItem.is_completed) {
                return false;
            }

            if (search === '') {
                return true;
            }

            return `${todoItem.title} ${todoItem.description ?? ''}`.toLowerCase().includes(search);
        })
        .sort((a, b) => {
            if (sortBy.value === 'title') {
                return a.title.localeCompare(b.title) * direction;
            }

            if (sortBy.value === 'status') {
                return (Number(a.is_completed) - Number(b.is_completed)) * direction;
            }

            return (new Date(a.created_at) - new Date(b.created_at)) * direction;
        });
});

const loadTodoItems = async () => {
    loading.value = true;
    errorMessage.value = '';

    try {
        const response = await axios.get('/todo-items');
        todoItems.value = response.data.todo_items;
    } catch (error) {
        errorMessage.value = error.response?.data?.message ?? 'Could not load todo items.';
    } finally {
        loading.value = false;
    }
};

const createTodoItem = async () => {
    errorMessage.value = '';
    successMessage.value = '';

    try {
        const response = await axios.post('/todo-items', {
            title: title.value,
            description: description.value,
        });

        todoItems.value.unshift(response.data.todo_item);
        title.value = '';
        description.value = '';
        successMessage.value = response.data.message;
    } catch (error) {
        errorMessage.value = error.response?.data?.message ?? 'Could not create todo item.';
    }
};

const startEditing = (todoItem) => {
    editingTodoId.value = todoItem.id;
    editTitle.value = todoItem.title;
    editDescription.value = todoItem.description ?? '';
};

const cancelEditing = () => {
    editingTodoId.value = null;
    editTitle.value = '';
    editDescription.value = '';
};

const updateTodoItem = async (todoItem) => {
    errorMessage.value = '';
    successMessage.value = '';

    try {
        const response = await axios.put(`/todo-items/${todoItem.id}`, {
            title: editTitle.value,
            description: editDescription.value,
        });

        replaceTodoItem(response.data.todo_item);
        cancelEditing();
        successMessage.value = response.data.message;
    } catch (error) {
        errorMessage.value = error.response?.data?.message ?? 'Could not update todo item.';
    }
};

const toggleTodoItem = async (todoItem) => {
    errorMessage.value = '';
    successMessage.value = '';

    try {
        const response = await axios.put(`/todo-items/${todoItem.id}`, {
            is_completed: !todoItem.is_completed,
        });

        replaceTodoItem(response.data.todo_item);
    } catch (error) {
        errorMessage.value = error.response?.data?.message ?? 'Could not update todo item.';
    }
};

const deleteTodoItem = async (id) => {
    errorMessage.value = '';
    successMessage.value = '';

    try {
        const response = await axios.delete(`/todo-items/${id}`);
        todoItems.value = todoItems.value.filter((todoItem) => todoItem.id !== id);
        successMessage.value = response.data.message;
    } catch (error) {
        errorMessage.value = error.response?.data?.message ?? 'Could not delete todo item.';
    }
};

const replaceTodoItem = (updatedTodoItem) => {
    todoItems.value = todoItems.value.map((todoItem) => {
        if (todoItem.id === updatedTodoItem.id) {
            return updatedTodoItem;
        }

        return todoItem;
    });
};

onMounted(() => {
    loadTodoItems();
});
</script>
