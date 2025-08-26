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
const connectionStatus = ref<'connected' | 'error' | 'loading'>('loading')

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
    connectionStatus.value = 'connected'
  } catch (e: any) {
    error.value = e.message || String(e)
    connectionStatus.value = 'error'
  } finally {
    loading.value = false
  }
})
</script>

<template>
  <section class="backend-info">
    <div class="status-header">
      <h2>Backend Connection</h2>
      <div class="status-indicator" :class="connectionStatus"></div>
    </div>
    
    <div class="status-content">
      <div v-if="loading" class="loading-spinner">
        <div class="spinner"></div>
        <p>Connecting to backend...</p>
        <p class="help-text">Note: Initial connection may take up to 30-60 seconds as our database is hosted on a free tier platform (render.com) and instances are spun down after 15 minutes of inactivity.</p>
      </div>
      
      <div v-else-if="error" class="error-container">
        <div class="error-icon">❌</div>
        <div class="error-message">
          <h3>Connection Error</h3>
          <p>{{ error }}</p>
          <p class="help-text">Check if the backend server is running or if there are CORS issues.</p>
          <p class="help-text">If this is the first access in a while, the database may still be starting up on our free tier hosting (render.com). Please try again in a minute.</p>
        </div>
      </div>
      
      <div v-else-if="info" class="info-container">
        <div class="info-item">
          <span class="label">Status:</span>
          <span class="value success">{{ info.message }}</span>
        </div>
        
        <div class="info-item">
          <span class="label">Application:</span>
          <span class="value">{{ info.applicationName }}</span>
        </div>
        
        <div class="info-item">
          <span class="label">Database Time:</span>
          <div class="db-time">
            <span class="db-icon">🗃️</span>
            <code>{{ info.databaseTime }}</code>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>
.backend-info {
  padding: 1.5rem;
  border-radius: 12px;
  background-color: var(--color-background);
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
}

.status-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 1.5rem;
}

.status-header h2 {
  margin: 0;
  font-size: 1.5rem;
  font-weight: 600;
}

.status-indicator {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  transition: background-color 0.3s ease;
}

.status-indicator.loading {
  background-color: #f0ad4e;
  animation: pulse 1.5s infinite;
}

.status-indicator.connected {
  background-color: #42b883;
}

.status-indicator.error {
  background-color: #e33;
}

.status-content {
  min-height: 100px;
}

.loading-spinner {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 1.5rem;
}

.spinner {
  border: 3px solid rgba(66, 184, 131, 0.2);
  border-radius: 50%;
  border-top: 3px solid #42b883;
  width: 30px;
  height: 30px;
  animation: spin 1s linear infinite;
  margin-bottom: 1rem;
}

.error-container {
  display: flex;
  gap: 1rem;
  padding: 1rem;
  background-color: rgba(238, 51, 51, 0.1);
  border-radius: 8px;
  border-left: 4px solid #e33;
}

.error-icon {
  font-size: 1.5rem;
}

.error-message h3 {
  margin: 0 0 0.5rem;
  color: #e33;
}

.help-text {
  font-size: 0.9rem;
  color: var(--color-text-light);
  margin-top: 0.5rem;
}

.info-container {
  display: flex;
  flex-direction: column;
  gap: 0.8rem;
}

.info-item {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.label {
  min-width: 100px;
  font-weight: 500;
  color: var(--color-text-light);
}

.value {
  font-weight: 500;
}

.value.success {
  color: #42b883;
}

.db-time {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.db-icon {
  font-size: 1.2rem;
}

code {
  font-family: 'Fira Code', monospace;
  background-color: var(--color-background-mute);
  padding: 0.2rem 0.5rem;
  border-radius: 4px;
  font-size: 0.9rem;
}

@keyframes pulse {
  0% {
    opacity: 0.6;
  }
  50% {
    opacity: 1;
  }
  100% {
    opacity: 0.6;
  }
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

@media (max-width: 768px) {
  .info-item {
    flex-direction: column;
    align-items: flex-start;
    gap: 0.3rem;
  }
  
  .label {
    min-width: auto;
  }
}
</style>
