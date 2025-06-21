<template>
	<div class="min-h-screen flex items-center justify-center bg-gray-100">
		<div class="w-full max-w-md bg-white rounded-xl shadow-xl p-6">
			<router-view :key="$route.fullPath"></router-view>
		</div>
	</div>
</template>