<!-- src/components/CreateCourseForm.vue -->
<template>
	<div class="max-w-md mx-auto bg-white p-6 rounded-xl shadow">
		<h2 class="text-xl font-bold mb-4">Novo Curso</h2>
		<form @submit.prevent="submit">
			<div class="mb-4">
				<label class="block font-medium mb-1" for="title">Título</label>
				<input id="title" v-model="form.title" type="text" class="w-full border rounded p-2" required />
			</div>

			<div class="mb-4">
				<label class="block font-medium mb-1" for="description">Descrição</label>
				<textarea id="description" v-model="form.description" class="w-full border rounded p-2" required />
			</div>

			<div class="mb-4">
				<label class="block font-medium mb-1" for="slug">URL pública</label>
				<textarea id="slug" v-model="form.slug" class="w-full border rounded p-2" required />
			</div>

			<div v-if="error" class="text-red-600 text-sm mb-4">{{ error }}</div>

			<button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white py-2 px-4 rounded">Criar</button>
		</form>
	</div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import axios from 'axios';
import { useAuthStore } from '@/stores/auth';
import { useRouter } from 'vue-router';
import api from '@/api/axios';

const auth = useAuthStore();
const router = useRouter();

const form = ref({
	title: '',
	description: '',
	slug: '',
});

const error = ref<string | null>(null);

const submit = async () => {
	error.value = null;
	try {
		await axios.post('http://localhost:3000/api/v1/courses', form.value, {
			headers: {
				Authorization: `Bearer ${auth.token}`,
			},
		});
		router.push('/cursos');
	} catch (err: any) {
		error.value = err.response?.data?.errors?.[0] || 'Erro ao criar curso.';
	}
};
</script>
