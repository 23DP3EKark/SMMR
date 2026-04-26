import { createRouter, createWebHistory } from 'vue-router';
import Desktop from '../components/desktop.vue';
import Register from '../components/Register.vue';
import Login from '../components/Login.vue';

const routes = [
    { path: '/', component: Login },
    { path: '/register', component: Register },
    { path: '/login', component: Login },
    { path: '/desktop', component: Desktop, meta: { requiresAuth: true } },
    { path: '/:pathMatch(.*)*', redirect: '/login' },
];

const router = createRouter({
    history: createWebHistory(),
    routes,
});

router.beforeEach((to, from, next) => {
  const isLoggedIn = localStorage.getItem('user');

  if (to.meta.requiresAuth && !isLoggedIn) {
    next('/login');
  } else {
    next();
  }
});

export default router;
