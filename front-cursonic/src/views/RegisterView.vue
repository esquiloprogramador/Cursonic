<template>
	<h1 class="text-2xl font-bold mb-4">Cadastro</h1>
	<div v-if="errors.length" class="mb-4">
		<ul class="bg-red-100 text-red-700 px-4 py-2 rounded space-y-1">
			<li v-for="(error, index) in errors" :key="index">• {{ error }}</li>
		</ul>
	</div>
	<form @submit.prevent="register">
		<input v-model="name" type="text" placeholder="Nome" class="input mb-2" />
		<input v-model="email" type="email" placeholder="Email" class="input mb-2" />
		<input v-model="password" type="password" placeholder="Senha" class="input mb-4" />
		<input v-model="passwordConfirmation" type="password" placeholder="Repita a Senha" class="input mb-4" />
		<button type="submit" class="btn">Cadastrar</button>
	</form>
	<router-link to="/login" class="text-sm mt-4 block text-blue-600">Já tem conta? Entrar</router-link>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { useAuthStore } from '@/stores/auth';

const router = useRouter();
const authStore = useAuthStore();

const name = ref('');
const email = ref('');
const password = ref('');
const passwordConfirmation = ref('');
const errors = ref<string[]>([]);

async function register() {
	errors.value = [];
	try {
		await authStore.register(name.value, email.value, password.value, passwordConfirmation.value);
		router.push('/login');
	} catch (err: any) {
		if (err.response && err.response.data && err.response.data.errors) {
			errors.value = err.response.data.errors;
		} else {
			errors.value = ['Erro desconhecido. Tente novamente.'];
		}
	}
}
</script>
