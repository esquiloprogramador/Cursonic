<template>
	<div class="p-6 max-w-3xl mx-auto">
		<h1 class="text-2xl font-bold mb-4">{{ lesson.title }}</h1>

		<div v-if="lesson.video_url" class="mb-6">
			<video :src="lesson.video_url" controls class="w-full rounded shadow" />
		</div>

		<p class="mb-6 whitespace-pre-wrap text-gray-700">
			{{ lesson.content }}
		</p>

		<div v-if="lesson.materials.length" class="mb-6">
			<h2 class="text-xl font-semibold mb-2">Materiais Complementares</h2>
			<ul class="list-disc list-inside space-y-1">
				<li v-for="material in lesson.materials" :key="material.id">
					<a :href="material.file_url" target="_blank" class="text-blue-600 hover:underline"> 📎 {{ material.title }} </a>
				</li>
			</ul>
		</div>

		<div>
			<h2 class="text-xl font-semibold mb-2">Comentários</h2>
			<ul class="space-y-2">
				<li v-for="comment in lesson.comments" :key="comment.id" class="bg-gray-100 p-3 rounded">
					<strong class="text-sm block text-gray-800"> Usuário {{ comment.user_id }} </strong>
					<p class="text-gray-700 text-sm">{{ comment.body }}</p>
				</li>
			</ul>
		</div>
	</div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import api from '@/api/axios';

const route = useRoute();
const lesson = ref({
	id: 0,
	title: '',
	content: '',
	video_url: '',
	materials: [],
	comments: [],
});

onMounted(async () => {
	const { data } = await api.get(`courses/${route.params.course_id}/lessons/${route.params.lesson_id}`);
	lesson.value = data;
});
</script>
