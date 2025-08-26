<script setup lang="ts">
import { ref, onMounted } from 'vue'

interface InfoResponse {
  message: string
  applicationName: string
  databaseTime: string
}

const loading = ref(true)
const error = ref<string | null>(null)
const info = ref<InfoResponse | null>(null)

function getBackendUrl(endpoint: string) {
  // Get base URL from environment or default to empty string (for relative paths in development)
  const baseUrl = (import.meta.env.VITE_BACKEND_URL as string | undefined) || '';
  
  // Ensure endpoint starts with a slash
  const normalizedEndpoint = endpoint.startsWith('/') ? endpoint : `/${endpoint}`;
  
  // If baseUrl is empty, just return the endpoint (works for local development)
  if (!baseUrl) {
    return normalizedEndpoint;
  }
  
  // Remove trailing slash from baseUrl if present
  const normalizedBaseUrl = baseUrl.replace(/\/$/, '');
  
  // Combine base URL and endpoint
  return `${normalizedBaseUrl}${normalizedEndpoint}`;
}

onMounted(async () => {
  try {
    // Fetch information from backend API
    const API_ENDPOINT = '/api/info';
    const url = getBackendUrl(API_ENDPOINT);
    const res = await fetch(url)
    if (!res.ok) throw new Error(`${res.status} ${res.statusText}`)
    info.value = await res.json()
  } catch (e: any) {
    error.value = e.message || String(e)
  } finally {
    loading.value = false
  }
})
</script>

<template>
  <section class="backend-info">
    <h2>Backend / DB Status</h2>
    <p v-if="loading">Loading...</p>
    <p v-else-if="error" class="error">Error: {{ error }}</p>
    <div v-else-if="info">
      <p>{{ info.message }} from <strong>{{ info.applicationName }}</strong></p>
      <p>Database time: <code>{{ info.databaseTime }}</code></p>
    </div>
  </section>
</template>

<style scoped>
.backend-info { margin-top: 1.5rem; padding: 1rem; border: 1px solid var(--color-border); border-radius: 8px; }
.error { color: #e33; }
code { font-family: monospace; }
</style>
