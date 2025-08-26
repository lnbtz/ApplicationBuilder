<template>
  <div class="about-container">
    <section class="about-header">
      <h1>About Application Builder</h1>
      <p class="about-description">
        A modern test platform for deployment scenarios and CI/CD pipelines
      </p>
    </section>

    <section class="about-content">
      <div class="card">
        <h2>Project Purpose</h2>
        <p>
          This application is designed specifically for learning and testing various deployment methods and scenarios.
          It serves as a practical example of a full-stack application with frontend, backend, and database components.
        </p>
        <p>
          Whether you're learning Kubernetes, Docker, CI/CD pipelines, or cloud deployments, this application
          provides a realistic testing ground without the complexity of a production system.
        </p>
      </div>

      <div class="card">
        <h2>Tech Stack</h2>
        <div class="tech-stack">
          <div class="tech-item">
            <h3>Frontend</h3>
            <ul>
              <li>Vue 3 with Composition API</li>
              <li>TypeScript</li>
              <li>Vite</li>
              <li>Vue Router</li>
            </ul>
          </div>
          
          <div class="tech-item">
            <h3>Backend</h3>
            <ul>
              <li>Spring Boot</li>
              <li>Java</li>
              <li>RESTful APIs</li>
              <li>Flyway Migrations</li>
            </ul>
          </div>
          
          <div class="tech-item">
            <h3>DevOps</h3>
            <ul>
              <li>Docker</li>
              <li>Kubernetes</li>
              <li>CI/CD Pipeline</li>
              <li>Cloud Deployment</li>
            </ul>
          </div>
        </div>
      </div>

      <div class="card">
        <h2>Project Structure</h2>
        <p>
          The application follows a modern microservices architecture with separate frontend and backend components:
        </p>
        <ul class="structure-list">
          <li><strong>Frontend:</strong> Vue.js application with a modern UI</li>
          <li><strong>Backend:</strong> Spring Boot REST API service</li>
          <li><strong>Database:</strong> PostgreSQL database for data persistence</li>
          <li><strong>DevOps:</strong> Docker and Kubernetes configuration files</li>
        </ul>
      </div>
    </section>
  </div>
</template>

<style scoped>
.about-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 2rem 1rem;
}

.about-header {
  text-align: center;
  margin-bottom: 3rem;
  padding: 2rem;
}

.about-header h1 {
  font-size: 2.8rem;
  margin-bottom: 1rem;
  background: linear-gradient(45deg, #42b883, #347474);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.about-description {
  font-size: 1.4rem;
  color: var(--color-text-light);
  max-width: 600px;
  margin: 0 auto;
}

.about-content {
  display: flex;
  flex-direction: column;
  gap: 2rem;
}

.card {
  background-color: var(--color-background-soft);
  border-radius: 12px;
  padding: 2rem;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.card:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
}

.card h2 {
  margin-top: 0;
  margin-bottom: 1.5rem;
  position: relative;
  display: inline-block;
  font-size: 1.8rem;
}

.card h2:after {
  content: '';
  position: absolute;
  bottom: -8px;
  left: 0;
  width: 50px;
  height: 3px;
  background-color: #42b883;
  border-radius: 2px;
}

.tech-stack {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: 2rem;
  margin-top: 1rem;
}

.tech-item {
  background-color: var(--color-background);
  padding: 1.5rem;
  border-radius: 8px;
}

.tech-item h3 {
  margin-top: 0;
  margin-bottom: 1rem;
  color: #42b883;
}

.tech-item ul {
  padding-left: 1.2rem;
  margin-bottom: 0;
}

.tech-item li {
  margin-bottom: 0.5rem;
}

.structure-list {
  padding-left: 1.2rem;
}

.structure-list li {
  margin-bottom: 0.8rem;
}

@media (max-width: 768px) {
  .about-header h1 {
    font-size: 2rem;
  }
  
  .about-description {
    font-size: 1.1rem;
  }
  
  .card {
    padding: 1.5rem;
  }
}
</style>
