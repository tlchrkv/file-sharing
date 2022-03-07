<!DOCTYPE html>
<html>
<head>
  <title>{{ appName }}</title>
</head>
<body>
  <div class="container" style="max-width: 960px;height: 100vh;display: flex;flex-direction: column;justify-content: center;">
    {{ this.getContent() }}
  </div>
  <script src="/assets/app.js"></script>
  <script src="/assets/preview.js"></script>
</body>
</html>
