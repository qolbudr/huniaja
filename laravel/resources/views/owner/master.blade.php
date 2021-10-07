
<!DOCTYPE html>
<html dir="ltr" lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <title>@yield('title')</title>
    <link href="{{ asset('admin/extra-libs/c3/c3.min.css') }}" rel="stylesheet">
    <link href="{{ asset('admin/libs/chartist/dist/chartist.min.css') }}" rel="stylesheet">
    <link href="{{ asset('admin/extra-libs/jvector/jquery-jvectormap-2.0.2.css') }}" rel="stylesheet" />
    <link href="{{ asset('admin/extra-libs/datatables.net-bs4/css/dataTables.bootstrap4.css') }}" rel="stylesheet">
    <link href="{{ asset('admin/dist/css/style.min.css') }}" rel="stylesheet">
</head>
<body url="{{ URL::to('/') }}">
    <div class="preloader">
        <div class="lds-ripple">
            <div class="lds-pos"></div>
            <div class="lds-pos"></div>
        </div>
    </div>
    <div id="main-wrapper" data-theme="light" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
        data-sidebar-position="fixed" data-header-position="fixed" data-boxed-layout="full">
        <header class="topbar" data-navbarbg="skin6">
            <nav class="navbar top-navbar navbar-expand-md">
                <div class="navbar-header" data-logobg="skin6">
                    <a class="nav-toggler waves-effect waves-light d-block d-md-none" href="javascript:void(0)"><i class="ti-menu ti-close"></i></a>
                    <div class="navbar-brand">
                        <a href="index.html">
                            <b class="logo-icon">
                                <img src="{{ asset('admin/images/logo-icon.png') }}" alt="homepage" class="dark-logo" />
                                <img src="{{ asset('admin/images/logo-icon.png') }}" alt="homepage" class="light-logo" />
                            </b>
                            <span class="logo-text">
                                <img src="{{ asset('admin/images/logo-text.png') }}" alt="homepage" class="dark-logo" />
                                <img src="{{ asset('admin/images/logo-light-text.png') }}" class="light-logo" alt="homepage" />
                            </span>
                        </a>
                    </div>

                    <a class="topbartoggler d-block d-md-none waves-effect waves-light" href="javascript:void(0)"></a>
                </div>
                <div class="navbar-collapse collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav float-left mr-auto ml-3 pl-1">
                    </ul>
                    <ul class="navbar-nav float-right">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="javascript:void(0)" data-toggle="dropdown"
                                aria-haspopup="true" aria-expanded="false">
                                <!-- <img src="{{ asset('admin/images/users/profile-pic.jpg') }}" alt="user" class="rounded-circle" width="40"> -->
                                <span class="ml-2 d-none d-lg-inline-block"><span>Hi, </span> 
                                <span class="text-dark">{{ Auth::user()->name }}</span> <i data-feather="chevron-down" class="svg-icon"></i></span>
                            </a>
                            <div class="dropdown-menu dropdown-menu-right user-dd animated flipInY">
                                <a class="dropdown-item my-2" href="javascript:void(0)">
                                    <i data-feather="settings" class="svg-icon mr-2 ml-1"></i>
                                    Pengaturan Akun
                                </a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="{{ URL::to('logout') }}">
                                    <i data-feather="power" class="svg-icon mr-2 ml-1"></i>
                                    Keluar
                                </a>
                            </div>
                        </li>
                    </ul>
                </div>
            </nav>
        </header>
        <aside class="left-sidebar" data-sidebarbg="skin6">
            <!-- Sidebar scroll-->
            <div class="scroll-sidebar" data-sidebarbg="skin6">
                <!-- Sidebar navigation-->
                <nav class="sidebar-nav">
                    <ul id="sidebarnav">
                        <li class="sidebar-item">
                            <a class="sidebar-link sidebar-link" href="{{ URL::to('owner/dashboard') }}">
                                <i data-feather="home" class="feather-icon"></i>
                                <span class="hide-menu">Dashboard</span>
                            </a>
                        </li>
                        <li class="list-divider"></li>
                        <li class="nav-small-cap"><span class="hide-menu">Keuangan</span></li>
                        <li class="sidebar-item">
                            <a class="sidebar-link" href="{{ URL::to('owner/income') }}">
                                <i data-feather="dollar-sign" class="feather-icon"></i>
                                <span class="hide-menu">Pemasukan</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link" href="ticket-list.html">
                                <i data-feather="credit-card" class="feather-icon"></i>
                                <span class="hide-menu">Penarikan</span>
                            </a>
                        </li>
                        <li class="list-divider"></li>
                        <li class="nav-small-cap"><span class="hide-menu">Properti</span></li>
                        <li class="sidebar-item">
                            <a class="sidebar-link has-arrow" href="javascript:void(0)">
                                <i data-feather="home" class="feather-icon"></i>
                                <span class="hide-menu">Properti</span>
                            </a>
                            <ul aria-expanded="false" class="collapse  first-level base-level-line">
                                <li class="sidebar-item">
                                    <a href="{{ URL::to('owner/property') }}" class="sidebar-link">
                                        <span class="hide-menu">Kelola Properti</span>
                                    </a>
                                </li>
                                <li class="sidebar-item">
                                    <a href="{{ URL::to('owner/booking') }}" class="sidebar-link">
                                        <span class="hide-menu">Kelola Sewa</span>
                                    </a>
                                </li>
                                <li class="sidebar-item">
                                    <a href="{{ URL::to('owner/bill') }}" class="sidebar-link">
                                        <span class="hide-menu">Tagihan</span
                                    ></a>
                                </li>
                            </ul>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link sidebar-link" href="{{ URL::to('owner/chat') }}">
                                <i data-feather="message-square" class="feather-icon"></i>
                                <span class="hide-menu">Chat</span>
                            </a>
                        </li>
                        <li class="list-divider"></li>
                        <li class="sidebar-item">
                            <a class="sidebar-link sidebar-link" type="button" data-toggle="modal" data-target="#settingAccountDialog">
                                <i data-feather="settings" class="feather-icon"></i>
                                <span class="hide-menu">Pengaturan Akun</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link sidebar-link" href="{{ URL::to('logout') }}">
                                <i data-feather="log-out" class="feather-icon"></i>
                                <span class="hide-menu">Keluar</span>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
        </aside>
        @yield('content')

        <div class="modal fade" id="settingAccountDialog" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="myCenterModalLabel">Pengaturan Akun</h4>
                        <button type="button" class="close" data-dismiss="modal"
                            aria-hidden="true">×</button>
                    </div>
                    <form action="{{URL::to('updateUserCredential')}}" id="updateAccount" method="POST">
                      @csrf
                      <div class="form-group col-md-12">
                        <input type="text" id="namaSettingAccount" class="form-control" placeholder="nama" name="name" required>
                      </div>
                      <div class="form-group col-md-12">
                        <input type="email" id="emailSettingAccount" class="form-control" placeholder="Email" name="email" required>
                      </div>
                      <div class="form-group col-md-12">
                        <input type="number" id="phoneSettingAccount" class="form-control" placeholder="Nomor telepon" name="phone" required>
                      </div>
                      <div class="form-group col-md-12">
                        <input type="date" id="dobSettingAccount" class="form-control" placeholder="Tanggal Lahir" name="dob" required>
                      </div>
                      <div class="form-group col-md-12">
                        <textarea name="address" id="address" cols="30" rows="3" class="form-control" placeholder="Alamat"></textarea>
                      </div>
                      <div class="form-group col-md-12">
                        <button type="submit" class="btn btn-success btn-block">Simpan</button>
                      </div>
                    </div>
                </form>
                </div>
            </div>
    </div>
    <script src="https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js"></script>
    <script src="https://www.gstatic.com/firebasejs/8.10.0/firebase-firestore.js"></script>
    <script src="{{ asset('admin/libs/jquery/dist/jquery.min.js') }}"></script>
    <script src="{{ asset('admin/libs/popper.js/dist/umd/popper.min.js') }}"></script>
    <script src="{{ asset('admin/libs/bootstrap/dist/js/bootstrap.min.js') }}"></script>
    <script src="{{ asset('admin/dist/js/app-style-switcher.js') }}"></script>
    <script src="{{ asset('admin/dist/js/feather.min.js') }}"></script>
    <script src="{{ asset('admin/libs/perfect-scrollbar/dist/perfect-scrollbar.jquery.min.js') }}"></script>
    <script src="{{ asset('admin/dist/js/sidebarmenu.js') }}"></script>
    <script src="{{ asset('admin/dist/js/custom.min.js') }}"></script>
    <script src="{{ asset('admin/extra-libs/c3/d3.min.js') }}"></script>
    <script src="{{ asset('admin/extra-libs/c3/c3.min.js') }}"></script>
    <script src="{{ asset('admin/libs/chartist/dist/chartist.min.js') }}"></script>
    <script src="{{ asset('admin/libs/chartist-plugin-tooltips/dist/chartist-plugin-tooltip.min.js') }}"></script>
    <script src="{{ asset('admin/extra-libs/jvector/jquery-jvectormap-2.0.2.min.js') }}"></script>
    <script src="{{ asset('admin/extra-libs/jvector/jquery-jvectormap-world-mill-en.js') }}"></script>
    <script src="{{ asset('admin/dist/js/pages/dashboards/dashboard1.min.js') }}"></script>
    <script type="text/javascript" src="{{ asset('assets/js/slimscroll.js') }}"></script>
    <script type="text/javascript" src="{{ asset('assets/js/sweetalert.min.js') }}"></script>
    <script src="{{ asset('admin/extra-libs/datatables.net/js/jquery.dataTables.min.js') }}"></script>
    <script src="{{ asset('admin/dist/js/pages/datatable/datatable-basic.init.js') }}"></script>
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