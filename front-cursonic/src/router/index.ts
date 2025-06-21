import { createRouter, createWebHistory } from 'vue-router';
import LoginView from '@/views/LoginView.vue';
import RegisterView from '@/views/RegisterView.vue';
import AuthLayout from '@/layouts/AuthLayout.vue';
import AppLayout from '@/layouts/AppLayout.vue';

import ListCourses from '@/views/Courses/ListCourses.vue';
import NewCourse from '@/views/Courses/NewCourse.vue';
import ShowCourse from '@/views/Courses/ShowCourse.vue';

import NewLesson from '@/views/Lessons/NewLesson.vue';
import ShowLesson from '@/views/Lessons/ShowLesson.vue';

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
				name: 'courses',
				component: ListCourses,
			},
			{
				path: 'cursos/novo',
				name: 'new-course',
				component: NewCourse,
			},
			{
				path: 'cursos/:course_id',
				name: 'show-course',
				component: ShowCourse,
			},
			{
				path: 'cursos/:course_id/aulas/nova',
				name: 'new-lesson',
				component: NewLesson,
			},
			{
				path: 'cursos/:course_id/aulas/:lesson_id',
				name: 'show-lesson',
				component: ShowLesson,
			},
		],
	},
];

const router = createRouter({
	history: createWebHistory(),
	routes,
});

export default router;
