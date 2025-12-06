---
layout: default
permalink: /projects/
---

<style>
  .wrapper > header {
    padding-top: 50px;
  }

  /* Sidebar navigation links */
  .sidebar-nav {
    margin-bottom: 30px;
    display: flex;
    flex-direction: column;
    gap: 10px;
  }
  .sidebar-nav a {
    color: #0066cc;
    text-decoration: none;
    font-weight: 600;
    font-size: 13px;
    padding: 8px 14px;
    border: 2px solid #0066cc;
    border-radius: 6px;
    text-align: center;
    transition: all 0.3s;
  }
  .sidebar-nav a:hover {
    background: #0066cc;
    color: white;
  }

  /* Mobile responsive styles */
  @media (max-width: 768px) {
    .wrapper {
      flex-direction: column !important;
    }
    .wrapper > header {
      width: 100% !important;
      max-width: 100% !important;
      padding: 20px !important;
      float: none !important;
      position: relative !important;
    }
    .wrapper > section {
      width: 100% !important;
      max-width: 100% !important;
      padding: 20px !important;
      float: none !important;
      border-left: none !important;
      margin-left: 0 !important;
    }
    .sidebar-nav {
      flex-direction: row;
      flex-wrap: wrap;
      justify-content: center;
    }
    .sidebar-nav a {
      font-size: 12px;
      padding: 6px 10px;
    }
    .project-card {
      padding: 20px !important;
    }
    .project-card h3 {
      font-size: 1.1rem !important;
    }
  }
</style>

<!-- Sidebar navigation (added via JavaScript) -->
<script>
document.addEventListener('DOMContentLoaded', function() {
  const header = document.querySelector('.wrapper > header');
  if (header) {
    const navDiv = document.createElement('div');
    navDiv.className = 'sidebar-nav';
    navDiv.innerHTML = `
      <a href="/">Home</a>
      <a href="/projects/">Projects</a>
      <a href="https://linktr.ee/abhinavr8">Useful Links</a>
      <a href="https://buymeacoffee.com/abhinavr8">Buy me a coffee!</a>
      <a href="mailto:abhinavralhan1@gmail.com">Contact</a>
    `;
    // Insert at the beginning of header (above name)
    header.insertBefore(navDiv, header.firstChild);
  }
});
</script>

<div style="max-width: 1000px; margin: 20px auto 60px; padding: 0 20px;">
  <h2 style="font-size: 2.5rem; text-align: center; margin-bottom: 40px; color: #222;">Projects</h2>

  <div id="projects">
    <!-- Project 1 -->
    <div class="project-card" style="background:white; padding:30px; margin-bottom:30px; border-radius:16px; box-shadow:0 6px 20px rgba(0,0,0,0.08); border-left:5px solid #0066cc;">
      <h3 style="margin:0 0 10px 0; color:#0066cc;">Project 1</h3>
      <p style="margin:15px 0 0; color:#444; line-height:1.6;">Coming soon...</p>
    </div>

    <!-- Project 2 -->
    <div class="project-card" style="background:white; padding:30px; margin-bottom:30px; border-radius:16px; box-shadow:0 6px 20px rgba(0,0,0,0.08); border-left:5px solid #0066cc;">
      <h3 style="margin:0 0 10px 0; color:#0066cc;">Project 2</h3>
      <p style="margin:15px 0 0; color:#444; line-height:1.6;">Coming soon...</p>
    </div>

    <!-- Project 3 -->
    <div class="project-card" style="background:white; padding:30px; margin-bottom:30px; border-radius:16px; box-shadow:0 6px 20px rgba(0,0,0,0.08); border-left:5px solid #0066cc;">
      <h3 style="margin:0 0 10px 0; color:#0066cc;">Project 3</h3>
      <p style="margin:15px 0 0; color:#444; line-height:1.6;">Coming soon...</p>
    </div>
  </div>
</div>
