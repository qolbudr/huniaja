@extends('master-home')
@section('title', 'HuniAja - Cari Hunian yang Cocok untuk Anda')

@section('content')
<div class="banner-home w-100">
  <img src="https://wallpapercave.com/wp/wp1846070.jpg">
  <div class="overlay d-flex align-items-center text-center">
    <div class="row w-100 text-center no-margin pt-5">
      <div class="col-10 col-xs-7 col-sm-6 col-md-4 col-lg-3 bg-white px-4 pb-5 pt-4 m-auto text-left border-10">
        <div class="box-brand text-center py-4">
          <h4 class="no-margin">Huni<span class="bold">Aja</span></h4>
        </div>
        <form action="{{ URL::to('auth/user/login') }}" method="post">
          @csrf
          <div class="form-group">
            <label>Email</label>
            <input type="email" class="form-control" placeholder="Email" name="email" required>
          </div>
          <div class="form-group">
            <label>Password</label>
            <input type="password" class="form-control" placeholder="Password" name="password" required>
          </div>
          <div class="form-group text-center">
            <button class="btn btn-primary px-5 mt-3" type="submit">Masuk</button>
          </div>
        </form>
        <div class="form-group text-center font-12 mt-4">
          <p>Belum punya akun ? <a href="{{ URL::to('register') }}" class="text-primary">Daftar</a></p>
        </div>
      </div>
    </div>
  </div>
</div>
@endsection