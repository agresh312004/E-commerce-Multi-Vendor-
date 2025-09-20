<!DOCTYPE html>
<html lang="en">
<head>
  <title>Add Item</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap" rel="stylesheet">
  <style>
    :root {
      --bg: #0f0f0f;
      --card: rgba(25, 25, 25, 0.85);
      --text: #ffffff;
      --highlight1: #d4ff3f;
      --highlight2: #00ffe7;
      --muted: #aaa;
      --radius: 14px;
      --shadow: 0 6px 20px rgba(0,0,0,0.5);
    }
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body {
      font-family: 'Inter', sans-serif;
      background: linear-gradient(135deg, #0d0d0d, #1a1a1a);
      color: var(--text);
      display: flex;
      flex-direction: column;
      height: 100vh;
    }
    header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 14px 30px;
      background: rgba(20, 20, 20, 0.9);
      backdrop-filter: blur(10px);
      box-shadow: var(--shadow);
    }
    header h1 {
      font-size: 1.3rem;
      font-weight: 800;
      background: linear-gradient(90deg, var(--highlight1), var(--highlight2));
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }
    main {
      flex: 1;
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 30px;
    }
    .form-card {
      background: var(--card);
      padding: 30px;
      border-radius: var(--radius);
      box-shadow: var(--shadow);
      width: 100%;
      max-width: 500px;
    }
    .form-card h2 {
      margin-bottom: 20px;
      font-size: 1.5rem;
      text-align: center;
    }
    .form-group {
      margin-bottom: 16px;
    }
    label {
      display: block;
      margin-bottom: 6px;
      font-weight: 600;
      font-size: 0.9rem;
      color: var(--muted);
    }
    input, textarea {
      width: 100%;
      padding: 12px;
      border: none;
      border-radius: var(--radius);
      background: rgba(255,255,255,0.1);
      color: var(--text);
      font-size: 1rem;
      outline: none;
    }
    input[type="file"] {
      padding: 8px;
      background: transparent;
      color: var(--muted);
    }
    textarea {
      min-height: 100px;
      resize: vertical;
    }
    button {
      width: 100%;
      padding: 14px;
      border: none;
      border-radius: var(--radius);
      font-size: 1rem;
      font-weight: 700;
      color: #000;
      background: linear-gradient(135deg, var(--highlight1), var(--highlight2));
      cursor: pointer;
      box-shadow: var(--shadow);
      transition: transform 0.2s ease;
    }
    button:hover { transform: scale(1.05); }

    /* Preview Image */
    .preview {
      margin-top: 12px;
      text-align: center;
    }
    .preview img {
      max-width: 200px;
      border-radius: var(--radius);
      box-shadow: var(--shadow);
      margin-top: 8px;
    }
  </style>
</head>
<body>
  <header>
    <h1>Add New Product</h1>
  </header>
  <main>
    <div class="form-card">
      <h2>Product Details</h2>
      <form action="uploadItem.jsp" method="post" enctype="multipart/form-data">
        
        <div class="form-group">
          <label for="photo">Upload Product Photo</label>
          <input type="file" id="photo" name="photo" accept="image/*" required>
          <div class="preview" id="preview">
            <p>No image selected</p>
          </div>
        </div>

        <div class="form-group">
          <label for="name">Product Name</label>
          <input type="text" id="name" name="name" placeholder="Enter product name" required>
        </div>

        <div class="form-group">
          <label for="price">Product Price</label>
          <input type="number" id="price" name="price" placeholder="Enter price (? / $)" required>
        </div>

        <div class="form-group">
          <label for="details">Product Details</label>
          <textarea id="details" name="details" placeholder="Enter product description..." required></textarea>
        </div>

        <button type="submit">Add Item</button>
        <button type="button" onclick="goBack()">BACK</button>
      </form>
    </div>
  </main>

  <script>
    const photoInput = document.getElementById("photo");
    const preview = document.getElementById("preview");

    photoInput.addEventListener("change", () => {
      preview.innerHTML = ""; // Clear preview
      const file = photoInput.files[0];
      if (file) {
        const img = document.createElement("img");
        img.src = URL.createObjectURL(file);
        preview.appendChild(img);
      } 
	  else {
        preview.innerHTML = "<p>No image selected</p>";
      }
    });
  </script>
  <script>
          function goBack()
            {
            window.location.href="sellermenu.jsp"; 
            }   
   </script>
</body>
</html>
