<template>
	<h1 class="text-2xl font-bold mb-4">Login</h1>
	<form @submit.prevent="login">
		<input v-model="email" type="email" placeholder="Email" class="input mb-2" />
		<input v-model="password" type="password" placeholder="Senha" class="input mb-4" />
		<button type="submit" class="btn">Entrar</button>
	</form>
	<div v-if="errorMessage" class="text-red-600 mb-4">
		{{ errorMessage }}
	</div>
	<router-link to="/register" class="text-sm mt-4 block text-blue-600">Não tem conta? Cadastre-se</router-link>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { useAuthStore } from '@/stores/auth';
import { useRouter } from 'vue-router';

const router = useRouter();
const authStore = useAuthStore();
const email = ref('');
const password = ref('');
const errorMessage = ref('');

async function login() {
	errorMessage.value = '';
	try {
		await authStore.login(email.value, password.value);
		router.push('/cursos');
	} catch (err: any) {
		if (err.response && err.response.data && err.response.data.error) {
			errorMessage.value = err.response.data.error;
		} else {
			errorMessage.value = 'Erro desconhecido. Tente novamente.';
		}
	}
}
</script>
