<!-- src/layouts/AppLayout.vue -->
<template>
	<div class="min-h-screen bg-gray-50 text-gray-900">
		<header class="bg-white shadow px-6 py-4 flex justify-between items-center">
			<h1 class="text-xl font-bold">Cursonic</h1>
			<button @click="logout" class="text-sm text-red-600 hover:underline">Sair</button>
		</header>

		<main class="p-6">
			<router-view :key="$route.fullPath"></router-view>
		</main>
	</div>
</template>

<script setup lang="ts">
import { useAuthStore } from '@/stores/auth';
const auth = useAuthStore();

function logout() {
	auth.logout();
}
</script>
