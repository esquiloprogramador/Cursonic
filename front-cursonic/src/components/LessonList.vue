<template>
	<div>
		<h2 class="text-xl font-semibold mb-3">Aulas</h2>

		<ul class="space-y-3">
			<li v-for="lesson in lessons" :key="lesson.id" class="p-3 bg-gray-100 rounded hover:bg-gray-200 transition">
				<RouterLink :to="{ name: 'show-lesson', params: { lesson_id: lesson.id } }" class="text-blue-600 hover:underline font-medium">
					{{ lesson.title }}
				</RouterLink>
			</li>
		</ul>

		<div v-if="lessons.length === 0" class="text-gray-500 mt-4">Esse curso ainda não tem nenhuma aula.</div>
	</div>
</template>

<script setup lang="ts">
defineProps<{
	lessons: { id: number; title: string }[];
}>();
</script>
