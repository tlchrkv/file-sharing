<!DOCTYPE html>
<html>
  <head>
    <title>{{ appName }}</title>
  </head>
<body>
  <div class="container">
    <header class="d-flex flex-wrap justify-content-center py-3 mb-3">
      <div class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-dark text-decoration-none">
        <span class="fs-4">{{ appName }}</span>
      </div>
    </header>
  </div>
  <div class="container">
    {{ this.getContent() }}
  </div>
  <script src="/assets/app.js"></script>
</body>
</html>
