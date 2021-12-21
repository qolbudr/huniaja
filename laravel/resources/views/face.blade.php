@extends('master-home')
@section('title', 'HuniAja - Cari Hunian yang Cocok untuk Anda')

@section('content')
<div class="banner-home w-100">
  <img src="https://wallpapercave.com/wp/wp1846070.jpg">
  <div class="overlay d-flex align-items-center text-center">
    <div class="row w-100 text-center no-margin pt-5">
      <div class="col-11 col-xs-8 col-sm-7 col-md-5 col-lg-4 bg-white px-4 pb-5 pt-4 m-auto text-left border-10">
        <div class="box-brand text-center py-4">
          <h4 class="no-margin">Huni<span class="bold">Aja</span></h4>
        </div>
        <form id="submit-data" action="{{ URL::to('auth/user/register') }}" method="post">
          @csrf
          <input type="hidden" class="form-control" value="{{ $request->name }}" name="name">
          <input type="hidden" class="form-control" value="{{ $request->email }}" name="email">
          <input type="hidden" class="form-control" value="{{ $request->password }}" name="password">
          <input type="hidden" class="form-control" value="{{ $request->password_confirmation }}" name="password_confirmation">
          <input type="hidden" name="role" value="0">
          <input type="hidden" name="face">
          <div class="alert alert-primary mb-3 font-12" role="alert">
            Sesuaikan wajah anda agar terlihat
          </div>
          <div class="camera-canvas">
            <div id="camera">
              <canvas id="camera--sensor"></canvas>
              <video id="camera--view" autoplay playsinline></video>
            </div>
          </div>
          <div class="form-group text-center">
            <a id="submit-reg" class="btn btn-primary px-5 mt-3 text-white">Daftar</a>
          </div>
        </form>
        <div  class="form-group text-center font-12 mt-4">
          <p>Sudah punya akun ? <a href="{{ URL::to('login') }}" class="text-primary">Masuk</a></p>
        </div>
      </div>
    </div>
  </div>
</div>
@endsection