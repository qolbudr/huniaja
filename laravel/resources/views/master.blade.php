<html>
<head>
    <link href="//fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="theme-color" content="#325baf">
    <link rel="stylesheet" type="text/css" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css">
    <link rel="stylesheet" type="text/css" href="{{ asset('assets/css/bootstrap.min.css') }}">
    <link rel="stylesheet" type="text/css" href="{{ asset('assets/css/materialDateTimePicker.css') }}">
    <link rel="stylesheet" type="text/css" href="{{ asset('assets/css/fontawesome.min.css') }}">
    <link rel="stylesheet" type="text/css" href="{{ asset('assets/css/owl.carousel.min.css') }}">
    <link rel="stylesheet" type="text/css" href="{{ asset('assets/css/owl.theme.default.min.css') }}">
    <link rel="stylesheet" type="text/css" href="{{ asset('assets/css/datatable.min.css') }}">
    <link rel="stylesheet" type="text/css" href="{{ asset('assets/css/datatable-select.min.css') }}">
    <link rel="stylesheet" type="text/css" href="{{ asset('assets/css/styles.css') }}">
    <link rel="icon" href="assets/images/logo.png">
    <title>@yield('title')</title>
    <meta name="description" content="Sebuah website untuk mencari hunian yang cocok bagi anda"/>
  </head>
<body url="{{ URL::to('/') }}">
  <nav class="navbar bg-white d-flex align-items-center is-shadow">
    <div class="navbar-brand">
      <h4 class="no-margin">Huni<span class="bold">Aja</span></h4>
    </div>
    <div class="navbar-menu hide-mobile">
      <ul class="no-margin list-none d-flex align-items-center">
        <li>
          <a class="text-dark" href="{{ URL::to('/') }}">Beranda</a>
        </li>
        <li>
          <a class="text-dark" href="{{ URL::to('search') }}">Cari</a>
        </li>
        @if(Auth::check() && Auth::user()->role == 0)
          <li>
            <a class="text-dark" href="{{ URL::to('account') }}">Akun Saya</a>
          </li>
          <li>
            <a class="text-dark" href="{{ URL::to('logout') }}">Keluar</a>
          </li>
        @else
          <li>
            <a class="text-dark" href="{{ URL::to('login') }}">Masuk</a>
          </li>
          <li>
            <a class="text-dark" href="{{ URL::to('register') }}">Daftar</a>
          </li>
          <li>
            <a class="btn btn-primary no-margin px-4 py-2 text-white" href="{{ URL::to('owner/login') }}">Masuk Pemilik</a>
          </li>
        @endif
      </ul>
    </div>
    <div class="navbar-menu hide-web">
      <ul class="no-margin list-none d-flex">
        <li>
          <a href="#"><i class="fa fa-bars text-dark"></i></a>
        </li>
      </ul>
    </div>
  </nav>
  @yield('content')

  @if(Auth::check() && Auth::user()->role == 0)
    <div class="chat-bubble">
      <h6 class="w-100 no-margin text-white"><i class="fa fa-comments-o"></i></h6>
    </div>
    <div class="chat-box" userId="{{ Auth::user()->id }}" userName="{{ Auth::user()->name }}" userFace="{{ Auth::user()->face }}">
      <div class="chat-header d-flex justify-content-between py-2 px-4 align-items-center">
        <h6 class="no-margin">Obrolan</h6>
        <h6 class="no-margin cursor-pointer" id="close-chat"><i class="fa fa-times"></i></h6>
      </div>
      <div class="chat-list">
        
      </div>
      <div class="chat-content">
        <div class="chat-content-list py-2 px-4">
        </div>
        <div class="chat-input d-flex align-items-center py-2 px-4">
          <input id="chat-send" class="w-100 form-control" placeholder="Ketik pesan lalu tekan enter">
        </div>
      </div>
    </div>
  @endif

  <footer>
    <div class="row no-margin">
      <div class="col-12 col-lg-4 mb-3">
        <h5 class="mb-3">Huni<span class="bold">Aja</span></h5>
        <p class="description pr-lg-5">
          Pages that you view in this window won't appear in the browser history and they won't leave other traces, like cookies, on the computer after you close all open Guest windows.
        </p>
      </div>
      <div class="col-12 col-lg-4 mb-3">
        <h6 class="mb-3">Importants Link</h6>
        <ul class="list-none no-margin">
          <li>
            <a href="{{ URL::to('/') }}">Beranda</a>
          </li>
          <li>
            <a href="{{ URL::to('search') }}">Cari</a>
          </li>
          @if(Auth::check() && Auth::user()->role == 0)
            <li>
              <a href="{{ URL::to('account') }}">Akun Saya</a>
            </li>
            <li>
              <a href="{{ URL::to('logout') }}">Keluar</a>
            </li>
          @else
            <li>
              <a href="{{ URL::to('login') }}">Masuk</a>
            </li>
            <li>
              <a href="{{ URL::to('register') }}">Daftar</a>
            </li>
            <li>
              <a class="btn btn-light no-margin px-4 py-2 text-primary" href="{{ URL::to('owner/login') }}">Daftarkan Properti</a>
            </li>
          @endif
        </ul>
      </div>
      <div class="col-12 col-lg-4 social-media mb-3">
        <h6 class="mb-3">Social Media</h6>
        <div class="d-flex align-items-center">
          <a href="#"><i class="fa fa-facebook-square"></i></a>
          <a href="#"><i class="fa fa-instagram"></i></a>
          <a href="#"><i class="fa fa-telegram"></i></a>
          <a href="#"><i class="fa fa-envelope"></i></a>
        </div>
      </div>
    </div>
  </footer>
  <script src="https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js"></script>
  <script src="https://www.gstatic.com/firebasejs/8.10.0/firebase-firestore.js"></script>
  <script type="text/javascript" src="{{ asset('assets/js/jquery-3.2.1.slim.min.js') }}"></script>
  <script type="text/javascript" src="{{ asset('assets/js/moment-with-locales.min.js') }}"></script>
  <script type="text/javascript" src="{{ asset('assets/js/materialDateTimePicker.js') }}"></script>
  <script type="text/javascript" src="{{ asset('assets/js/popper.min.js') }}"></script>
  <script type="text/javascript" src="{{ asset('assets/js/bootstrap.min.js') }}"></script>
  <script type="text/javascript" src="{{ asset('assets/js/sweetalert.min.js') }}"></script>
  <script type="text/javascript" src="{{ asset('assets/js/chart.min.js') }}"></script>
  <script type="text/javascript" src="{{ asset('assets/js/owl.carousel.min.js') }}"></script>
  <script type="text/javascript" src="{{ asset('assets/js/typed.js') }}"></script>
  <script type="text/javascript" src="{{ asset('assets/js/leaflet.js') }}"></script>
  <script type="text/javascript" src="{{ asset('assets/js/slimscroll.js') }}"></script>
  <script type="text/javascript" src="{{ asset('assets/js/jquery.datatable.min.js') }}"></script>
  <script type="text/javascript" src="{{ asset('assets/js/datatable.min.js') }}"></script>
  <script type="text/javascript" src="{{ asset('assets/js/datatable-select.min.js') }}"></script>
  <script src="https://app.sandbox.midtrans.com/snap/snap.js" data-client-key="SB-Mid-client-C0O9nJMj3HYHqUBS"></script>
  <script type="text/javascript">
    const firebaseConfig = {
      apiKey: "AIzaSyAJHoIm1mkgVGISlNWfOC_cOysSshO5a5k",
      authDomain: "huniaja.firebaseapp.com",
      projectId: "huniaja",
      storageBucket: "huniaja.appspot.com",
      messagingSenderId: "815208910612",
      appId: "1:815208910612:web:fef1f1ae5ef4aa81533c01"
    };
    const app = firebase.initializeApp(firebaseConfig);
    var db = firebase.firestore();
  </script>
  <script type="text/javascript" src="{{ asset('assets/js/script.js') }}"></script>
  @if(Session::has('error'))
  <script>
    swal({title: "Error", text: "{{ Session::get('error') }}", icon: "error", buttons: { hapus: "OK" }})
  </script>
  @endif

  @if(Session::has('success'))
  <script>
    swal({title: "Success", text: "{{ Session::get('success') }}", icon: "success", buttons: { hapus: "OK" }})
  </script>
  @endif

  @if(session('errors'))
  <script>
    @foreach ($errors->all() as $error)
      text = "{{ $error }}";
    @endforeach
    swal({title: "Error", text: text, icon: "error", buttons: { hapus: "OK" }})
  </script>
  @endif
</body>
</html>