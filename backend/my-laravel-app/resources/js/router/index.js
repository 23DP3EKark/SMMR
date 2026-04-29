import { createRouter, createWebHistory } from 'vue-router';
import Desktop from '../components/desktop.vue';
import Register from '../components/Register.vue';
import Login from '../components/Login.vue';
import Taskbar from '../components/taskbar.vue';

const routes = [
    { path: '/', component: Login },
    { path: '/register', component: Register },
    { path: '/login', component: Login },
    { path: '/desktop', component: Desktop, meta: { requiresAuth: true } },
    { path: '/:pathMatch(.*)*', redirect: '/login' },
    { path: '/taskbar', component: Taskbar }
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
