<!DOCTYPE html>
<html>
  <head>
    <title>{{ appName }}</title>
  </head>
<body>
{#  <div class="container" id="common-template__header">#}
{#    <header class="d-flex flex-wrap justify-content-center py-3 mt-3">#}
{#      <div class="d-flex align-items-center mb-3 text-dark text-decoration-none" style="flex: 1;justify-content: center;">#}
{#        <span style="color: #d0d0d0;font-family: monospace;font-size: 20px !important;font-weight: bold;text-align: center;">{{ appName }}</span>#}
{#      </div>#}
{#    </header>#}
{#  </div>#}
  <div class="container" style="max-width: 960px;min-height: 100vh;display: flex;flex-direction: column;justify-content: center;">
    {{ this.getContent() }}
  </div>
  <script src="/assets/app.js"></script>
</body>
</html>
