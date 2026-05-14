import { createRouter, createWebHistory } from 'vue-router';
import DesktopLayout from '../components/DesktopLayout.vue';
import Desktop from '../components/desktop.vue';
import Register from '../components/Register.vue';
import Login from '../components/Login.vue';
import Settings from '../components/Settings.vue';
import Todo from '../components/todo.vue';
import Music from '../components/Music.vue';
import Movies from '../components/Movies.vue';
import Travel from '../components/Travel.vue';
import ReadmeFile from '../components/ReadmeFile.vue';
import SourcesFile from '../components/SourcesFile.vue';

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
            { path: 'todo', component: Todo, meta: { title: 'To-do' } },
            { path: 'travel', component: Travel, meta: { title: 'Celojumi' } },
            { path: 'music', component: Music, meta: { title: 'Muzika' } },
            { path: 'movies', component: Movies, meta: { title: 'Filmas' } },
            { path: 'readme', component: ReadmeFile, meta: { title: 'README.md' } },
            { path: 'sources', component: SourcesFile, meta: { title: 'Izmantotie_avoti.txt' } },
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
