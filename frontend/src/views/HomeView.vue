<script setup lang="ts">
import BackendInfo from '../components/BackendInfo.vue'
</script>

<template>
  <main class="home-container">
    <section class="hero">
      <div class="hero-content">
        <h1>Application Builder</h1>
        <p class="subtitle">A modern deployment testing platform</p>
        <div class="cta-buttons">
          <a href="#about" class="btn primary">Learn More</a>
          <a href="https://github.com/lnbtz/ApplicationBuilder" target="_blank" class="btn secondary">View Source</a>
        </div>
      </div>
    </section>

    <section id="about" class="about-section">
      <div class="container">
        <h2>About This Project</h2>
        <p>
          This application serves as a test environment for various deployment methods and scenarios.
          It's built with Vue.js for the frontend and Spring Boot for the backend, showcasing a modern
          full-stack application structure.
        </p>
        <div class="features">
          <div class="feature-card">
            <div class="feature-icon">🚀</div>
            <h3>CI/CD Ready</h3>
            <p>Built with modern CI/CD principles in mind</p>
          </div>
          <div class="feature-card">
            <div class="feature-icon">🔄</div>
            <h3>Full Stack</h3>
            <p>Frontend + Backend + Database connectivity</p>
          </div>
          <div class="feature-card">
            <div class="feature-icon">🧪</div>
            <h3>Testing Platform</h3>
            <p>Perfect for learning deployment patterns</p>
          </div>
        </div>
      </div>
    </section>

    <section class="connection-section">
      <div class="container">
        <h2>Backend Connection Status</h2>
        <p>This shows the current connection to our backend and database:</p>
        <div class="connection-card">
          <BackendInfo />
        </div>
      </div>
    </section>
  </main>
</template>

<style scoped>
.home-container {
  width: 100%;
  max-width: 1200px;
  margin: 0 auto;
}

.hero {
  height: 60vh;
  min-height: 400px;
  display: flex;
  align-items: center;
  justify-content: center;
  text-align: center;
  background: linear-gradient(135deg, var(--color-background-soft), var(--color-background-mute));
  border-radius: 12px;
  margin: 2rem 1rem;
}

.hero-content {
  padding: 2rem;
  max-width: 800px;
}

.hero h1 {
  font-size: 3.5rem;
  margin-bottom: 1rem;
  background: linear-gradient(45deg, #42b883, #347474);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.subtitle {
  font-size: 1.5rem;
  margin-bottom: 2rem;
  color: var(--color-text-light);
}

.cta-buttons {
  display: flex;
  gap: 1rem;
  justify-content: center;
}

.btn {
  padding: 0.8rem 2rem;
  border-radius: 8px;
  font-weight: 600;
  text-decoration: none;
  transition: all 0.2s ease;
}

.btn.primary {
  background-color: #42b883;
  color: white;
}

.btn.primary:hover {
  background-color: #3aa876;
  transform: translateY(-2px);
}

.btn.secondary {
  background-color: rgba(66, 184, 131, 0.1);
  color: #42b883;
  border: 1px solid #42b883;
}

.btn.secondary:hover {
  background-color: rgba(66, 184, 131, 0.2);
  transform: translateY(-2px);
}

.container {
  padding: 2rem;
  margin: 1rem;
}

.about-section {
  margin-bottom: 3rem;
}

.about-section h2, .connection-section h2 {
  margin-bottom: 1rem;
  font-size: 2.2rem;
  position: relative;
  display: inline-block;
}

.about-section h2:after, .connection-section h2:after {
  content: '';
  position: absolute;
  bottom: -10px;
  left: 0;
  width: 60px;
  height: 4px;
  background-color: #42b883;
  border-radius: 2px;
}

.features {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 2rem;
  margin-top: 3rem;
}

.feature-card {
  background-color: var(--color-background-soft);
  padding: 1.5rem;
  border-radius: 8px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.feature-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
}

.feature-icon {
  font-size: 2rem;
  margin-bottom: 1rem;
}

.feature-card h3 {
  margin-bottom: 0.5rem;
  font-size: 1.4rem;
}

.connection-section {
  margin-bottom: 3rem;
}

.connection-card {
  background-color: var(--color-background-soft);
  border-radius: 8px;
  padding: 0.5rem;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
}

@media (max-width: 768px) {
  .hero h1 {
    font-size: 2.5rem;
  }
  
  .subtitle {
    font-size: 1.2rem;
  }
  
  .cta-buttons {
    flex-direction: column;
  }
}
</style>
