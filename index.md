---
layout: default
---
<!-- 
<div style="text-align: center; padding: 100px 20px 60px; max-width: 900px; margin: 0 auto;">
  <h1 style="font-size: 4.5rem; font-weight: 800; margin: 0 0 20px 0; color: #111; letter-spacing: -2px;">
    Abhinav Ralhan
  </h1>
  
  <p style="font-size: 1.6rem; color: #444; margin: 30px 0 50px; line-height: 1.6;">
    Analytics Engineering • Machine Learning • Databases • Data Visualization • Building things that scale
  </p>
  
  <div style="font-size: 1.15rem; color: #666; line-height: 1.8; max-width: 660px; margin: 0 auto 60px;">
    I design and ship data driven applications, reporting systems, and deploy ML / AI tools that drive business decisions. Currently focused on Python/SQL, ClickhouseDb, Kafka, and DBT.
  </div>
</div> -->

<div style="position: fixed; top: 30px; right: 30px; z-index: 100;">
  <a href="https://linktr.ee/abhinavr8" style="margin-left: 12px; color: #0066cc; text-decoration: none; font-weight: 600; font-size: 15px; padding: 10px 18px; border: 2px solid #0066cc; border-radius: 8px; transition: all 0.3s;">
    Useful Links
  </a>
  <a href="https://buymeacoffee.com/abhinavr8" style="margin-left: 12px; color: #0066cc; text-decoration: none; font-weight: 600; font-size: 15px; padding: 10px 18px; border: 2px solid #0066cc; border-radius: 8px; transition: all 0.3s;">
    Buy me a coffee!
  </a>
  <a href="mailto:abhinavralhan1@gmail.com" style="margin-left: 12px; color: #0066cc; text-decoration: none; font-weight: 600; font-size: 15px; padding: 10px 18px; border: 2px solid #0066cc; border-radius: 8px; transition: all 0.3s;">
    Contact
  </a>
</div>

<!-- Add this after your hero section in index.md -->

<div style="max-width: 1000px; margin: 0px auto 60px; padding: 0 2px;">
  <h2 style="font-size: 2.5rem; text-align: center; margin-bottom: 40px; color: #222;">Blog</h2>
  
  <input type="text" id="search-input" placeholder="Search posts…" 
         style="width:100%; padding:16px; font-size:18px; border:2px solid #0066cc; border-radius:12px; margin-bottom:40px;">

  <div id="results"></div>
  <p id="no-results" style="text-align:center; color:#888; display:none;">No posts found</p>
</div>

<script src="https://unpkg.com/simple-jekyll-search@latest/dest/simple-jekyll-search.min.js"></script>
<script>
  window.store = [
    {% for post in site.posts %}
    {
      "title": {{ post.title | jsonify }},
      "url": {{ post.url | relative_url | jsonify }},
      "date": {{ post.date | date: "%B %d, %Y" | jsonify }},
      "excerpt": {{ post.content | strip_html | truncate: 160 | jsonify }}
    }{% unless forloop.last %},{% endunless %}
    {% endfor %}
  ];

  function displayResults(posts) {
    const results = document.getElementById('results');
    results.innerHTML = posts.map(p => `
      <div style="background:white; padding:30px; margin-bottom:30px; border-radius:16px; box-shadow:0 6px 20px rgba(0,0,0,0.08); border-left:5px solid #0066cc;">
        <h3 style="margin:0 0 10px 0;"><a href="${p.url}" style="color:#0066cc; text-decoration:none;">${p.title}</a></h3>
        <small style="color:#888;">${p.date}</small>
        <p style="margin:15px 0 0; color:#444; line-height:1.6;">${p.excerpt}...</p>
      </div>
    `).join('');
  }

  displayResults(window.store);

  SimpleJekyllSearch({
    searchInput: document.getElementById('search-input'),
    resultsContainer: document.getElementById('results'),
    json: '/search.json'
  });
</script>

<style>
  a:hover { background: #0066cc; color: white !important; }
  @media (max-width: 640px) {
    h1 { font-size: 3.2rem; }
    .fixed-nav { position: static; margin: 40px 0; text-align: center; }
    .fixed-nav a { display: inline-block; margin: 8px !important; }
  }
</style>
