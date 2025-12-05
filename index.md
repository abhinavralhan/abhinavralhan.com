---
layout: default
---

<!-- Your fixed top-right buttons (unchanged) -->
<div style="position: fixed; top: 30px; right: 30px; z-index: 100;">
  <a href="https://linktr.ee/abhinavr8" style="margin-left: 12px; color: #0066cc; text-decoration: none; font-weight: 600; font-size: 15px; padding: 10px 18px; border: 2px solid #0066cc; border-radius: 8px; transition: all 0.3s;">Projects</a>
  <a href="https://linktr.ee/abhinavr8" style="margin-left: 12px; color: #0066cc; text-decoration: none; font-weight: 600; font-size: 15px; padding: 10px 18px; border: 2px solid #0066cc; border-radius: 8px; transition: all 0.3s;">Useful Links</a>
  <a href="https://buymeacoffee.com/abhinavr8" style="margin-left: 12px; color: #0066cc; text-decoration: none; font-weight: 600; font-size: 15px; padding: 10px 18px; border: 2px solid #0066cc; border-radius: 8px; transition: all 0.3s;">Buy me a coffee!</a>
  <a href="mailto:abhinavralhan1@gmail.com" style="margin-left: 12px; color: #0066cc; text-decoration: none; font-weight: 600; font-size: 15px; padding: 10px 18px; border: 2px solid #0066cc; border-radius: 8px; transition: all 0.3s;">Contact</a>
</div>

<div style="max-width: 1000px; margin: 100px auto 60px; padding: 0 20px;">
  <h2 style="font-size: 2.5rem; text-align: center; margin-bottom: 40px; color: #222;">Blog</h2>
  
  <input type="text" id="search-input" placeholder="Search posts…" 
         style="width:100%; padding:16px; font-size:18px; border:2px solid #0066cc; border-radius:12px; margin-bottom:40px;">

  <div id="results"></div>
  <p id="no-results" style="text-align:center; color:#888; display:none;">No posts found</p>
</div>

<!-- REAL CLICKABLE PAGINATION (works with layout: default) -->
<!-- CLICKABLE PAGINATION – 100% working -->
<div style="text-align:center; margin:100px 0 60px; font-size:1.2rem; font-weight:600;">
  {% assign current_page = 1 %}
  {% if page.url contains '/page/' %}
    {% assign current_page = page.url | split: '/page/' | last | split: '/' | first | plus: 0 %}
  {% endif %}

  {% assign total_pages = site.posts.size | divided_by: 3 | plus: 1 %}

  <!-- Newer -->
  {% if current_page > 1 %}
    {% if current_page == 2 %}
      <a href="/" style="color:#0066cc; margin:0 30px; text-decoration:none;">Newer</a>
    {% else %}
      <a href="/page/{{ current_page | minus: 1 }}" style="color:#0066cc; margin:0 30px; text-decoration:none;">Newer</a>
    {% endif %}
  {% else %}
    <span style="color:#ccc; margin:0 30px;">Newer</span>
  {% endif %}

  <span style="color:#666; margin:0 40px;">Page {{ current_page }} of {{ total_pages }}</span>

  <!-- Older -->
  {% if current_page < total_pages %}
    <a href="/page/{{ current_page | plus: 1 }}" style="color:#0066cc; margin:0 30px; text-decoration:none;">Older</a>
  {% else %}
    <span style="color:#ccc; margin:0 30px;">Older</span>
  {% endif %}
</div>

<script src="https://unpkg.com/simple-jekyll-search@latest/dest/simple-jekyll-search.min.js"></script>
<script>
  const allPosts = [
    {% for post in site.posts %}
    {
      title: {{ post.title | jsonify }},
      url: {{ post.url | relative_url | jsonify }},
      date: {{ post.date | date: "%B %d, %Y" | jsonify }},
      excerpt: {{ post.content | strip_html | truncate: 160 | jsonify }}
    }{% unless forloop.last %},{% endunless %}
    {% endfor %}
  ];

  // Detect current page from URL – FIXED
  let currentPage = 1;
  const path = window.location.pathname;
  if (path === '/' || path === '') {
    currentPage = 1;
  } else if (path.match(/^\/page\/(\d+)\/?$/)) {
    currentPage = parseInt(path.match(/^\/page\/(\d+)\/?$/)[1]);
  }

  const perPage = 3;
  const start = (currentPage - 1) * perPage;
  const end = start + perPage;
  const postsToShow = allPosts.slice(start, end);

  function displayResults(posts) {
    const results = document.getElementById('results');
    if (posts.length === 0) {
      document.getElementById('no-results').style.display = 'block';
      results.innerHTML = '';
      return;
    }
    document.getElementById('no-results').style.display = 'none';
    results.innerHTML = posts.map(p => `
      <div style="background:white; padding:30px; margin-bottom:30px; border-radius:16px; box-shadow:0 6px 20px rgba(0,0,0,0.08); border-left:5px solid #0066cc;">
        <h3 style="margin:0 0 10px 0;"><a href="${p.url}" style="color:#0066cc; text-decoration:none;">${p.title}</a></h3>
        <small style="color:#888;">${p.date}</small>
        <p style="margin:15px 0 0; color:#444; line-height:1.6;">${p.excerpt}...</p>
      </div>
    `).join('');
  }

  displayResults(postsToShow);

  SimpleJekyllSearch({
    searchInput: document.getElementById('search-input'),
    resultsContainer: document.getElementById('results'),
    json: allPosts
  });
</script>