<!DOCTYPE html>
<html lang="en">
<%@ page import="java.util.*" %> 
<%
    // Logout logic
    String action = request.getParameter("action");
    if ("logout".equals(action)) {
        session = request.getSession(false);
        if (session != null) {
            session.invalidate(); 
        }
        response.sendRedirect("Sellerlog.jsp");
        return;
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seller Dashboard</title>

    <style>
        /* ---------------------- RESET ---------------------- */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Poppins", sans-serif;
        }

        body {
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: radial-gradient(circle at top left, #2e3192, #1bffff, #00c6ff, #0072ff);
            background-size: 300% 300%;
            animation: gradientShift 10s ease infinite;
            overflow: hidden;
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* ---------------------- DASHBOARD CONTAINER ---------------------- */
        .dashboard {
            position: relative;
            width: 420px;
            background: rgba(255, 255, 255, 0.12);
            backdrop-filter: blur(20px);
            border-radius: 25px;
            padding: 40px 35px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.35);
            text-align: center;
            color: #fff;
            border: 1px solid rgba(255, 255, 255, 0.18);
            animation: floatUp 1.5s ease;
        }

        @keyframes floatUp {
            from { transform: translateY(30px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        .dashboard h2 {
            font-size: 28px;
            margin-bottom: 30px;
            letter-spacing: 1px;
            font-weight: 600;
            text-shadow: 0 3px 10px rgba(0,0,0,0.3);
        }

        /* ---------------------- BUTTONS ---------------------- */
        .btn {
            display: block;
            width: 100%;
            padding: 14px;
            margin: 12px 0;
            background: linear-gradient(135deg, #00c6ff, #0072ff);
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 500;
            color: white;
            letter-spacing: 0.5px;
            cursor: pointer;
            transition: all 0.35s ease;
            box-shadow: 0 0 12px rgba(0, 153, 255, 0.4);
        }

        .btn:hover {
            transform: translateY(-4px);
            box-shadow: 0 0 18px rgba(0, 230, 255, 0.8);
            background: linear-gradient(135deg, #43e97b, #38f9d7);
        }

        .btn.logout {
            background: linear-gradient(135deg, #ff6a00, #ee0979);
            box-shadow: 0 0 12px rgba(255, 70, 70, 0.5);
        }

        .btn.logout:hover {
            background: linear-gradient(135deg, #ff512f, #dd2476);
            box-shadow: 0 0 20px rgba(255, 100, 100, 0.8);
        }

        /* ---------------------- MESSAGE BOX ---------------------- */
        .message-box {
            display: none;
            margin-top: 20px;
            animation: fadeIn 0.5s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: scale(0.9); }
            to { opacity: 1; transform: scale(1); }
        }

        textarea {
            width: 100%;
            height: 120px;
            border-radius: 14px;
            border: none;
            padding: 12px;
            font-size: 15px;
            background: rgba(255, 255, 255, 0.9);
            color: #333;
            outline: none;
            resize: none;
        }

        textarea::placeholder {
            color: #666;
        }

        .close-btn {
            background: linear-gradient(135deg, #ff5f6d, #ffc371);
        }

        /* ---------------------- NEON EFFECT ---------------------- */
        .glow {
            position: absolute;
            width: 150px;
            height: 150px;
            border-radius: 50%;
            filter: blur(90px);
            opacity: 0.7;
            animation: pulse 8s infinite ease-in-out alternate;
            z-index: -1;
        }

        .glow.one {
            top: -50px;
            left: -50px;
            background: #00c6ff;
        }

        .glow.two {
            bottom: -50px;
            right: -50px;
            background: #ff6a00;
        }

        @keyframes pulse {
            0% { transform: scale(1); opacity: 0.7; }
            100% { transform: scale(1.3); opacity: 0.4; }
        }

        /* ---------------------- FOOTER ---------------------- */
        .footer {
            margin-top: 25px;
            font-size: 13px;
            opacity: 0.8;
        }

        .footer span {
            color: #ffeb3b;
        }
    </style>
</head>

<body>
    <div class="dashboard">
        <div class="glow one"></div>
        <div class="glow two"></div>

        <%
            session = request.getSession(false);
            if (session == null || session.getAttribute("Email") == null) {
                response.sendRedirect("Sellerlog.jsp");
                return;
            }
        %>

        <h2>Welcome, <%= ((String)session.getAttribute("Email")).replaceAll("@gmail.com","") %></h2>

        <button class="btn" onclick="location.href='Seller_Add_Interface.jsp'">Add Items</button>
        <button class="btn" onclick="location.href='Delete_List.jsp'">Delete Items</button>
        <button class="btn" onclick="location.href='Seller_Interface.jsp'">Inventory</button>
        <button class="btn" onclick="location.href='View_Products.jsp'">View Products</button>
        <button class="btn" onclick="location.href='View_List_U.jsp'">Update Product</button>
        <button class="btn logout" onclick="destroySessionAndRedirect()">Logout</button>
        <button class="btn" onclick="toggleMessageBox()">Messages</button>

        <div class="message-box" id="msgBox">
            <textarea placeholder="Write your message here..."></textarea>
            <button class="btn close-btn" onclick="toggleMessageBox()">Close</button>
        </div>

        <div class="footer">
            © 2025 <span>Agresh</span> | Crafted with
        </div>
    </div>

    <script>
        function toggleMessageBox() {
            const box = document.getElementById('msgBox');
            box.style.display = (box.style.display === 'block') ? 'none' : 'block';
        }

        function destroySessionAndRedirect() {
            window.location.href = 'Seller_Interface.jsp?action=logout';
        }
    </script>
</body>
</html>
