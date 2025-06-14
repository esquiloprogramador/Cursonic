<!-- src/views/Courses.vue -->
<template>
	<div>
		<div class="flex justify-between items-center mb-4">
			<h1 class="text-2xl font-bold">Cursos</h1>
			<RouterLink to="/cursos/novo" class="bg-green-600 hover:bg-green-700 text-white py-2 px-4 rounded"> Novo Curso </RouterLink>
		</div>

		<div v-if="loading">Carregando...</div>
		<div v-else-if="error" class="text-red-600">{{ error }}</div>
		<div v-else>
			<ul class="grid gap-4">
				<li v-for="course in courses" :key="course.id" class="bg-white rounded-xl p-4 shadow">
					<h3 class="text-lg font-semibold">{{ course.title }}</h3>
					<p class="text-sm text-gray-600">{{ course.description }}</p>
				</li>
			</ul>
		</div>
	</div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import axios from 'axios';
import { useAuthStore } from '@/stores/auth';

const auth = useAuthStore();

const courses = ref<any[]>([]);
const loading = ref(true);
const error = ref<string | null>(null);

onMounted(async () => {
	try {
		const res = await axios.get('http://localhost:3000/api/v1/courses', {
			headers: {
				Authorization: `Bearer ${auth.token}`,
			},
		});
		courses.value = res.data;
	} catch (err: any) {
		error.value = err.response?.data?.errors?.[0] || 'Erro ao carregar cursos';
	} finally {
		loading.value = false;
	}
});
</script>
