<template>
	<div class="p-4 max-w-xl mx-auto">
		<h1 class="text-2xl font-bold mb-4">Nova Aula</h1>

		<form @submit.prevent="createLesson" class="space-y-4">
			<div>
				<label class="block mb-1 font-medium">Título</label>
				<input v-model="form.title" type="text" class="w-full border p-2 rounded" />
			</div>

			<div>
				<label class="block mb-1 font-medium">Descrição</label>
				<textarea v-model="form.description" class="w-full border p-2 rounded" />
			</div>

			<button type="submit" class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700">Criar Aula</button>
		</form>
	</div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import api from '@/api/axios';

const route = useRoute();
const router = useRouter();

const form = ref({
	title: '',
	description: '',
});

const createLesson = async () => {
	await api.post(`courses/${route.params.course_id}/lessons`, {
		...form.value,
	});
	router.push(`/cursos/${route.params.course_id}`);
};
</script>
