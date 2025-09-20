<!DOCTYPE html>
<html lang="en">
<head>
  <title>Dashboard</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <style>
    :root {
      --bg: #0f0f0f;
      --card: rgba(25, 25, 25, 0.75);
      --text: #ffffff;
      --highlight1: #d4ff3f;
      --highlight2: #00ffe7;
      --muted: #aaa;
      --radius: 16px;
      --shadow: 0 6px 20px rgba(0, 0, 0, 0.5);
    }
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body {
      font-family: 'Inter', sans-serif;
      background: linear-gradient(135deg, #0d0d0d, #1a1a1a);
      color: var(--text);
      display: flex;
      flex-direction: column;
      height: 100vh;
      overflow: hidden;
    }

    /* Top bar */
    header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 14px 30px;
      background: rgba(20, 20, 20, 0.85);
      backdrop-filter: blur(12px);
      box-shadow: var(--shadow);
    }
    header h1 {
      font-size: 1.4rem;
      font-weight: 800;
      background: linear-gradient(90deg, var(--highlight1), var(--highlight2));
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }

    /* Menu bar */
    nav {
      display: flex;
      gap: 20px;
      margin-left: 30px;
    }
    nav a {
      color: var(--muted);
      font-weight: 600;
      text-decoration: none;
      font-size: 0.9rem;
      transition: all 0.3s ease;
      position: relative;
    }
    nav a:hover { color: var(--highlight1); }
    nav a.active { color: var(--highlight2); }
    nav a::after {
      content: "";
      position: absolute;
      bottom: -5px;
      left: 0;
      width: 0%;
      height: 2px;
      background: var(--highlight2);
      transition: width 0.3s ease;
    }
    nav a:hover::after { width: 100%; }

    /* Notification button */
    .notify-btn {
      position: relative;
      background: linear-gradient(135deg, var(--highlight1), var(--highlight2));
      border: none;
      border-radius: 50%;
      width: 40px;
      height: 40px;
      font-size: 1rem;
      color: #000;
      font-weight: bold;
      cursor: pointer;
      box-shadow: var(--shadow);
      transition: transform 0.2s ease;
    }
    .notify-btn:hover { transform: scale(1.1); }

    .badge {
      position: absolute;
      top: 4px;
      right: 4px;
      background: #ff3f6d;
      color: #fff;
      font-size: 0.65rem;
      font-weight: bold;
      border-radius: 50%;
      padding: 1px 5px;
      box-shadow: 0 0 8px #ff3f6d;
    }

    /* Dashboard layout */
    main {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      grid-template-rows: repeat(2, 1fr);
      gap: 16px;
      padding: 16px 24px;
      flex: 1;
      overflow-y: auto;
    }

    .card {
      background: var(--card);
      border-radius: var(--radius);
      padding: 14px;
      box-shadow: var(--shadow);
      backdrop-filter: blur(10px);
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
    }
    .card:hover {
      transform: translateY(-4px);
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.6);
    }
    .card h2 {
      font-size: 0.9rem;
      margin-bottom: 6px;
      color: var(--muted);
    }
    .value {
      font-size: 1.5rem;
      font-weight: 700;
      background: linear-gradient(90deg, var(--highlight1), var(--highlight2));
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }
    canvas {
      margin-top: 6px;
      height: 120px !important; /* smaller chart */
    }

    /* Responsive */
    @media(max-width: 800px) {
      main { grid-template-columns: 1fr; grid-template-rows: auto; }
      nav { gap: 12px; margin-left: 10px; font-size: 0.85rem; }
    }
  </style>
</head>
<body>

  <!-- Top Bar -->
  <header>
    <div style="display:flex; align-items:center;">
      <h1>Dashboard</h1>
      <nav>
        <a href="BuyerLog.jsp" class="active">Analysis</a>
        <a href="Sellerlog.jsp">Remove Item</a>
        <a href="addItem.jsp">Add item</a>
        <a href="editItem.jsp">Edit Item</a>
      </nav>
    </div>
    <button class="notify-btn">?<span class="badge">0</span></button>
  </header>

  <!-- Dashboard -->
  <main>
    <div class="card">
      <h2>Total Sales</h2>
      <div class="value">$23.0K</div>
      <canvas id="salesChart"></canvas>
    </div>

    <div class="card">
      <h2>Active Campaigns</h2>
      <div class="value">24</div>
      <canvas id="campaignChart"></canvas>
    </div>

    <div class="card">
      <h2>Weekly Engagement</h2>
      <div class="value">580</div>
      <canvas id="engagementChart"></canvas>
    </div>

    <div class="card">
      <h2>Product Performance</h2>
      <div class="value">$34.2K</div>
      <canvas id="productChart"></canvas>
    </div>
  </main>

  <script>
    // Notification
    const notifyBtn = document.querySelector(".notify-btn");
    const badge = document.querySelector(".badge");
    notifyBtn.addEventListener("click", () => { badge.textContent = "0"; });

    // Chart options (compact)
    const chartOptions = {
      responsive: true,
      plugins: { legend: { display: false } },
      scales: { x: { display: false }, y: { display: false } },
      elements: { point: { radius: 0 } }
    };

    new Chart(document.getElementById('salesChart'), {
      type: 'line',
      data: { labels: ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"], datasets: [{ data: [120,180,150,200,170,230,250], borderColor: "#d4ff3f", backgroundColor: "#d4ff3f33", fill: true, tension: 0.4 }] },
      options: chartOptions
    });

    new Chart(document.getElementById('campaignChart'), {
      type: 'doughnut',
      data: { labels: ["Running","Paused"], datasets: [{ data: [18,6], backgroundColor: ["#00ffe7","#444"] }] },
      options: { responsive: true }
    });

    new Chart(document.getElementById('engagementChart'), {
      type: 'bar',
      data: { labels: ["Likes","Comments","Shares"], datasets: [{ data: [320,150,110], backgroundColor: ["#00ffe7","#d4ff3f","#ff3f6d"] }] },
      options: chartOptions
    });

    new Chart(document.getElementById('productChart'), {
      type: 'line',
      data: { labels: ["Q1","Q2","Q3","Q4"], datasets: [{ data: [8000,12000,25000,34000], borderColor: "#00ffe7", backgroundColor: "#00ffe733", fill: true, tension: 0.4 }] },
      options: chartOptions
    });
  </script>
</body>
</html>
