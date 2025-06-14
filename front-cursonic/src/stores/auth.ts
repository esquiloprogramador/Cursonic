// src/stores/auth.ts
import { defineStore } from 'pinia';
import api from '../api/axios';

export const useAuthStore = defineStore('auth', {
	state: () => ({
		token: localStorage.getItem('token') || null,
		user: null as null | Record<string, any>,
	}),
	actions: {
		async login(email: string, password: string) {
			const response = await api.post('login', { email, password });
			this.token = response.data.token;
			localStorage.setItem('token', this.token);
			// await this.fetchUser();
		},

		async register(name: string, email: string, password: string, password_confirmation: string) {
			const response = await api.post('users', {
				user: { name, email, password, password_confirmation },
			});
			this.token = response.data.token;
			localStorage.setItem('token', this.token);
			// await this.fetchUser();
		},

		async fetchUser() {
			if (!this.token) return;
			const response = await api.get('profile', {
				headers: { Authorization: `Bearer ${this.token}` },
			});
			this.user = response.data;
		},

		logout() {
			this.token = null;
			this.user = null;
			localStorage.removeItem('token');
		},
	},
});
