<template>
	<div class="p-6 max-w-4xl mx-auto">
		<div v-if="loading" class="text-center">Carregando...</div>
		<div v-else>
			<h1 class="text-3xl font-bold mb-2">{{ course.title }}</h1>
			<p class="text-gray-700 mb-4">{{ course.description }}</p>
			<RouterLink :to="`/cursos/${course.id}/aulas/nova`" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 inline-block mb-6">
				Nova Aula
			</RouterLink>

			<!-- <button v-if="!course.enrolled" @click="enroll" class="mb-6 bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded">Inscrever-se</button> -->

			<LessonList :lessons="course.lessons" />
		</div>
	</div>
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import axios from 'axios';
import { useAuthStore } from '@/stores/auth';

import LessonList from '@/components/LessonList.vue';

const route = useRoute();
const router = useRouter();
const auth = useAuthStore();

const course = ref<any>(null);
const loading = ref(true);

const fetchCourse = async () => {
	try {
		const res = await axios.get(`http://localhost:3000/api/v1/courses/${route.params.course_id}`, {
			headers: {
				Authorization: `Bearer ${auth.token}`,
			},
		});
		course.value = res.data;
	} catch (e) {
		console.error(e);
	} finally {
		loading.value = false;
	}
};

const enroll = async () => {
	try {
		await axios.post(
			'http://localhost:3000/api/v1/enrollments',
			{ course_id: course.value.id },
			{
				headers: {
					Authorization: `Bearer ${auth.token}`,
				},
			},
		);
		await fetchCourse(); // atualiza o estado para marcar como inscrito
	} catch (e) {
		console.error(e);
	}
};

const goToLesson = (lessonId: number) => {
	router.push(`/aulas/${lessonId}`);
};

onMounted(fetchCourse);
</script>
