<script setup lang="ts">
import { RouterLink, RouterView } from 'vue-router'
</script>

<template>
  <div class="app-container">
    <header>
      <div class="navbar">
        <div class="logo-container">
          <img alt="App Builder logo" class="logo" src="@/assets/logo.svg" width="40" height="40" />
          <span class="logo-text">App Builder</span>
        </div>
        
        <nav>
          <RouterLink to="/" class="nav-link">Home</RouterLink>
          <RouterLink to="/about" class="nav-link">About</RouterLink>
        </nav>
      </div>
    </header>

    <div class="content">
      <RouterView />
    </div>

    <footer>
      <div class="footer-content">
        <p>&copy; 2025 Application Builder - A Deployment Test</p>
        <p class="footer-links">
          <a href="https://github.com/lnbtz/ApplicationBuilder" target="_blank">GitHub</a> |
          <a href="#" target="_blank">Documentation</a> |
          <a href="#" target="_blank">License</a>
        </p>
      </div>
    </footer>
  </div>
</template>

<style scoped>
.app-container {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

header {
  background-color: var(--color-background);
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  position: sticky;
  top: 0;
  z-index: 100;
}

.navbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem 2rem;
  max-width: 1200px;
  margin: 0 auto;
  width: 100%;
}

.logo-container {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.logo {
  transition: transform 0.3s ease;
}

.logo:hover {
  transform: rotate(10deg);
}

.logo-text {
  font-weight: 700;
  font-size: 1.3rem;
  background: linear-gradient(45deg, #42b883, #347474);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

nav {
  display: flex;
  gap: 1.5rem;
}

.nav-link {
  text-decoration: none;
  color: var(--color-text);
  font-weight: 500;
  padding: 0.5rem 0;
  position: relative;
  transition: color 0.3s ease;
}

.nav-link:after {
  content: '';
  position: absolute;
  width: 0;
  height: 2px;
  bottom: 0;
  left: 0;
  background-color: #42b883;
  transition: width 0.3s ease;
}

.nav-link:hover:after,
.router-link-exact-active:after {
  width: 100%;
}

.router-link-exact-active {
  color: #42b883;
}

.content {
  flex: 1;
  width: 100%;
}

footer {
  background-color: var(--color-background-soft);
  padding: 2rem 0;
  margin-top: 3rem;
}

.footer-content {
  max-width: 1200px;
  margin: 0 auto;
  text-align: center;
  color: var(--color-text-light);
}

.footer-links {
  margin-top: 1rem;
}

.footer-links a {
  color: #42b883;
  text-decoration: none;
  transition: color 0.3s ease;
}

.footer-links a:hover {
  color: #347474;
}

@media (max-width: 768px) {
  .navbar {
    flex-direction: column;
    padding: 1rem;
    gap: 1rem;
  }
  
  nav {
    width: 100%;
    justify-content: center;
  }
}
</style>
