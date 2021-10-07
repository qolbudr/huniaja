
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="{{ asset('admin/dist/css/style.min.css') }}" rel="stylesheet">
    <title>HuniAja - Halaman Admin</title>
    <meta name="description" content="Sebuah website untuk mencari hunian yang cocok bagi anda"/>
</head>

<body>
    <div class="main-wrapper">
        <div class="preloader">
            <div class="lds-ripple">
                <div class="lds-pos"></div>
                <div class="lds-pos"></div>
            </div>
        </div>
        <div class="auth-wrapper d-flex no-block justify-content-center align-items-center position-relative">
            <div class="auth-box row">
                <div class="col-lg-7 col-md-5 modal-bg-img" style="background-image: url('{{ asset('/admin/images/background/5124556.jpg') }}');">
                </div>
                <div class="col-lg-5 col-md-7 bg-white">
                    <div class="p-3">
                        <div class="text-center">
                            <img src="{{ asset('admin/images/big/icon.png') }}" alt="wrapkit">
                        </div>
                        <h2 class="mt-3 text-center">Masuk</h2>
                        <p class="text-center">Masuk sebagai Admin</p>
                        <form action="{{ URL::to('auth/admin/login') }}" method="post" class="mt-4">
                            @csrf
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <label class="text-dark">Email</label>
                                        <input class="form-control" type="text" placeholder="Email" name="email" required>
                                    </div>
                                </div>
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <label class="text-dark">Password</label>
                                        <input class="form-control" type="password" placeholder="Password" name="password">
                                    </div>
                                </div>
                                <div class="col-lg-12 text-center">
                                    <button type="submit" class="btn btn-block btn-primary">Masuk</button>
                                </div>
                                <div class="col-lg-12 text-center mt-5">
                                   Halaman Khusus untuk admin
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="{{ asset('admin/libs/jquery/dist/jquery.min.js') }}"></script>
    <script src="{{ asset('admin/libs/popper.js/dist/umd/popper.min.js') }}"></script>
    <script src="{{ asset('admin/libs/bootstrap/dist/js/bootstrap.min.js') }}"></script>
    <script type="text/javascript" src="{{ asset('assets/js/sweetalert.min.js') }}"></script>
    <script>
        $(".preloader ").fadeOut();
    </script>
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