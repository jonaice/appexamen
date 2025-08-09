<!doctype html>
<html lang="es" class="h-full">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>@yield('title', 'Panel')</title>
    @vite(['resources/css/app.css','resources/js/app.js'])
  </head>
  <body class="min-h-screen bg-gray-50 text-gray-800 dark:bg-gray-900 dark:text-gray-100">
    <div class="flex min-h-screen">
      @includeIf('tailadmin.partials.sidebar')
    </div>
  </body>
</html>