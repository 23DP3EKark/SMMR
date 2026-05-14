<style scoped>

</style>

<template>
    <div class="flex min-h-screen items-center justify-center bg-[#008080] px-4">
        <form class="w-full max-w-sm border-2 border-t-white border-r-black border-b-black border-l-white bg-[#c0c0c0] p-2">
            <div class="flex items-center">
                <h1 class="m-1 flex-1 bg-[#000080] px-2 py-1 text-sm font-bold text-white">
                    Iestatijumi
                </h1>

                <router-link to="/desktop" class="border-2 border-t-white border-r-black border-b-black border-l-white bg-[#c0c0c0] px-2 active:border-t-black active:border-r-white active:border-b-white active:border-l-black">X</router-link>
            </div>

            <div class="flex flex-col gap-3 p-3 text-sm">
                <p v-if="loading">Ielade...</p>
                <p v-if="errorMessage" class="text-red-700">{{ errorMessage }}</p>

                <h1 class="text-sm font-bold">
                    Lietotaja dati:
                </h1>

                <div v-if="user" class="flex flex-col gap-3">
                    <div>
                        <strong>Name: </strong>
                        <span>{{ user.first_name }}</span>
                    </div>

                    <div>
                        <strong>Last name: </strong>
                        <span>{{ user.last_name }}</span>
                    </div>

                    <div>
                        <strong>Email: </strong>
                        <span>{{ displayedEmail }}</span>
                    </div>

                    <button type="button" class="win-btn" @click="showEmail = !showEmail">
                        {{ showEmail ? 'Slept e-pastu' : 'Radit e-pastu' }}
                    </button>

                    <button type="button" class="win-btn" @click="logout">
                        Izrakstities
                    </button>
                </div>

                <h1 class="mt-5 text-sm font-bold">
                    Mainit paroli:
                </h1>

                <div class="flex flex-col gap-3">
                    <div>
                        <label for="current_password">Pasreizeja parole:</label>
                        <input type="password" id="current_password" v-model="currentPassword" class="w-full border-2 border-t-black border-r-white border-b-white border-l-black bg-white px-1 py-0.5 outline-none">
                    </div>

                    <div>
                        <label for="new_password">Jauna parole:</label>
                        <input type="password" id="new_password" v-model="newPassword" class="w-full border-2 border-t-black border-r-white border-b-white border-l-black bg-white px-1 py-0.5 outline-none">
                    </div>

                    <div>
                        <label for="confirm_password">Apstiprinat jauno paroli:</label>
                        <input type="password" id="confirm_password" v-model="confirmPassword" class="w-full border-2 border-t-black border-r-white border-b-white border-l-black bg-white px-1 py-0.5 outline-none">
                    </div>

                    <button type="button" class="win-btn" @click="changePassword">
                        Mainit paroli
                    </button>

                    <p v-if="passwordChangeMessage" :class="passwordChangeSuccess ? 'text-green-700' : 'text-red-700'">{{ passwordChangeMessage }}</p>
                </div>

                <h1 class="mt-5 text-sm font-bold">
                    Dzest kontu:
                </h1>

                <div class="flex flex-col gap-3">
                    <p>Si darbiba ir neatgriezeniska. <br> Ludzu, parliecinieties, ka tiesam velaties to darit.</p>
                    <p>Ievadiet kodu <strong>{{ deleteCode }}</strong>, lai dzestu kontu.</p>

                    <div>
                        <label for="delete_confirmation">Dzesanas kods:</label>
                        <input type="text" id="delete_confirmation" v-model="deleteConfirmation" class="w-full border-2 border-t-black border-r-white border-b-white border-l-black bg-white px-1 py-0.5 outline-none">
                    </div>

                    <button type="button" class="win-btn bg-red-600" @click="deleteAccount">
                        Dzest kontu
                    </button>

                    <p v-if="accountDeletionMessage" :class="accountDeletionSuccess ? 'text-green-700' : 'text-red-700'">{{ accountDeletionMessage }}</p>
                </div>
            </div>
        </form>
    </div>
</template>

<script setup>
import axios from 'axios';
import { computed, onMounted, ref } from 'vue';
import { useRouter } from 'vue-router';

const router = useRouter();

const user = ref(null);
const loading = ref(true);
const errorMessage = ref('');
const showEmail = ref(false);

const currentPassword = ref('');
const newPassword = ref('');
const confirmPassword = ref('');

const passwordChangeMessage = ref('');
const passwordChangeSuccess = ref(false);

const accountDeletionMessage = ref('');
const accountDeletionSuccess = ref(false);
const deleteCode = ref('');
const deleteConfirmation = ref('');

const logout = async () => {
    errorMessage.value = '';

    try {
        await axios.post('/logout');
        router.push('/login');
    } catch (error) {
        errorMessage.value = error.response?.data?.message ?? 'Could not sign out.';
    }
};

const changePassword = async () => {
    passwordChangeMessage.value = '';
    passwordChangeSuccess.value = false;

    try {
        const response = await axios.put('/password', {
            current_password: currentPassword.value,
            password: newPassword.value,
            password_confirmation: confirmPassword.value,
        });

        passwordChangeSuccess.value = true;
        passwordChangeMessage.value = response.data.message;

        currentPassword.value = '';
        newPassword.value = '';
        confirmPassword.value = '';
    } catch (error) {
        passwordChangeMessage.value = error.response?.data?.message ?? 'Could not change password.';
    }
};

const deleteAccount = async () => {
    accountDeletionMessage.value = '';
    accountDeletionSuccess.value = false;

    try {
        const response = await axios.delete('/account', {
            data: {
                verification_code: deleteCode.value,
                verification_input: deleteConfirmation.value,
            },
        });

        accountDeletionSuccess.value = true;
        accountDeletionMessage.value = response.data.message;
        deleteConfirmation.value = '';

        router.push('/login');
    } catch (error) {
        accountDeletionMessage.value = error.response?.data?.message ?? 'Could not delete account.';
    }
};

const displayedEmail = computed(() => {
    if (!user.value?.email) {
        return '';
    }

    if (showEmail.value) {
        return user.value.email;
    }

    return maskEmail(user.value.email);
});

const maskEmail = (email) => {
    const [name, domain] = email.split('@');

    if (!name || !domain) {
        return email;
    }

    const visiblePart = name.slice(0, 2);

    return `${visiblePart}***@${domain}`;
};

const loadUser = async () => {
    loading.value = true;
    errorMessage.value = '';

    try {
        const response = await axios.get('/me');
        user.value = response.data.user;
    } catch (error) {
        errorMessage.value = error.response?.data?.message ?? 'Could not load user information.';
    } finally {
        loading.value = false;
    }
};

onMounted(() => {
    deleteCode.value = Math.random().toString(36).slice(2, 8).toUpperCase();
    loadUser();
});
</script>
