import { createRouter, createWebHistory } from 'vue-router';
import LoginView from '@/views/LoginView.vue';
import RegisterView from '@/views/RegisterView.vue';
import AuthLayout from '@/layouts/AuthLayout.vue';
import AppLayout from '@/layouts/AppLayout.vue';

import ListCourses from '@/views/Courses/ListCourses.vue';
import NewCourse from '@/views/Courses/NewCourse.vue';

const routes = [
	{
		path: '/login',
		component: AuthLayout,
		children: [{ path: '', component: LoginView }],
	},
	{
		path: '/register',
		component: AuthLayout,
		children: [{ path: '', component: RegisterView }],
	},
	{
		path: '',
		component: AppLayout,
		children: [
			{
				path: 'cursos',
				name: 'cursos',
				component: ListCourses,
			},
			{
				path: 'cursos/novo',
				name: 'novo-curso',
				component: NewCourse,
			},
		],
	},
];

const router = createRouter({
	history: createWebHistory(),
	routes,
});

export default router;
