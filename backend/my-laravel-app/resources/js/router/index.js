import { createRouter, createWebHistory } from 'vue-router';
import DesktopLayout from '../components/DesktopLayout.vue';
import Desktop from '../components/desktop.vue';
import DesktopWindow from '../components/DesktopWindow.vue';
import Register from '../components/Register.vue';
import Login from '../components/Login.vue';
import Settings from '../components/Settings.vue';

const routes = [
    { path: '/', component: Login },
    { path: '/register', component: Register },
    { path: '/login', component: Login },
    {
        path: '/desktop',
        component: DesktopLayout,
        meta: { requiresAuth: true },
        children: [
            { path: '', component: Desktop },
            { path: 'todo', component: DesktopWindow, meta: { title: 'To-do' } },
            { path: 'travel', component: DesktopWindow, meta: { title: 'Celojumi' } },
            { path: 'music', component: DesktopWindow, meta: { title: 'Muzika' } },
            { path: 'movies', component: DesktopWindow, meta: { title: 'Filmas' } },
            { path: 'readme', component: DesktopWindow, meta: { title: 'README.md' } },
            { path: 'sources', component: DesktopWindow, meta: { title: 'Izmantotie_avoti.txt' } },
            { path: 'surprise', component: DesktopWindow, meta: { title: 'Parsteigums.exe' } },
            { path: 'settings', component: Settings }
        ],
    },
    { path: '/:pathMatch(.*)*', redirect: '/login' },
];

const router = createRouter({
    history: createWebHistory(),
    routes,
});

router.beforeEach(async (to, from, next) => {
  if (!to.meta.requiresAuth) {
    return next();
  }

  try {
    await window.axios.get('/me');
    next();
  } catch {
    next('/login');
  }
});

export default router;
