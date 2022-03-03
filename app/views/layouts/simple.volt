<!DOCTYPE html>
<html>
<head>
  <title>{{ appName }}</title>
</head>
<body>
<div class="container" style="max-width: 960px;height: calc(100vh - 90px);display: flex;flex-direction: column;justify-content: center;">
  {{ this.getContent() }}
</div>
<script src="/assets/app.js"></script>
</body>
</html>
