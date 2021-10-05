@extends('master-home')
@section('title', 'HuniAja - Cari Hunian yang Cocok untuk Anda')

@section('content')
<div class="banner-home w-100">
  <img src="https://wallpapercave.com/wp/wp1846070.jpg">
  <div class="overlay d-flex align-items-center text-center">
    <div class="search-box w-100 text-white">
      <h1 class="no-margin font-weight-bold mb-3">INGIN SEWA <span id="typed"></span></h1>
      <h3 class="no-margin">YA Huni<span class="bold">Aja</span> !</h3>
    </div>
  </div>
</div>
<div class="wrapper">
  <div class="row">
    <div class="col-12 col-lg-6 py-3">
      <div class="card card-greeting outline-none bg-primary py-4 px-5 is-shadow text-white">
        <h5 class="mb-4">Welcome Aboard!</h5>
        <p class=" mb-4 description no-margin">
          Pages that you view in this window won't appear in the browser history and they won't leave other traces, like cookies, on the.
        </p>
        <a class="text-white" href="#">Lets Start</a>
      </div>
    </div>
    <div class="col-12 col-lg-6 hide-mobile step">
      <div class="owl-carousel owl-theme">
        <div class="item">
          <div class="card card-step outline-none is-shadow-thin py-4 px-5">
            <h3 class="mb-4 text-primary"><i class="fa fa-search"></i></h3>
            <h6 class="mb-3">Cari Tempat</h6>
            <p class=" mb-4 description no-margin">
              Pages that you view in this window won't appear
            </p>
          </div>
        </div>
        <div class="item">
          <div class="card card-step outline-none is-shadow-thin py-4 px-5">
            <h3 class="mb-4 text-primary"><i class="fa fa-dollar"></i></h3>
            <h6 class="mb-3">Booking Tempat</h6>
            <p class=" mb-4 description no-margin">
              Pages that you view in this window won't appear
            </p>
          </div>
        </div>
        <div class="item">
          <div class="card card-step outline-none is-shadow-thin py-4 px-5">
            <h3 class="mb-4 text-primary"><i class="fa fa-home"></i></h3>
            <h6 class="mb-3">Huni Tempat</h6>
            <p class=" mb-4 description no-margin">
              Pages that you view in this window won't appear
            </p>
          </div>
        </div>
      </div>
    </div>
    <div class="col-12 my-3">
      <h3 class="font-weight-bold">Apa yang anda cari ?</h3>
      <div class="categories d-flex align-items-center mt-3">
        <div class="card-categories text-primary d-flex text-center align-items-center p-3 my-2 mr-2">
          <div class="content w-100">
            <h5 class="my-2"><i class="fa fa-home"></i></h5>
            <p class="no-margin">Rumah</p>
          </div>
        </div>
        <div class="card-categories text-primary d-flex text-center align-items-center p-3 my-2 mr-2">
          <div class="content w-100">
            <h5 class="my-2"><i class="fa fa-building"></i></h5>
            <p class="no-margin">Apartement</p>
          </div>
        </div>
        <div class="card-categories text-primary d-flex text-center align-items-center p-3 my-2 mr-2">
          <div class="content w-100">
            <h5 class="my-2"><i class="fa fa-hotel"></i></h5>
            <p class="no-margin">Kontrakan</p>
          </div>
        </div>
      </div>
    </div>
    <div class="col-12 my-3">
      <h5 class="font-weight-bold">Sewa Terpopuler</h5>
      <div class="row my-5">
        @foreach($house as $data)
          <div class="col-12 col-xs-6 col-sm-6 col-md-4 col-lg-3">
            <div class="card-hotel">
              <a class="click-target" href="{{ URL::to('detail/'.$data->id.'/'.str_replace(' ', '-', strtolower($data->name))) }}"></a>
              <div class="place-img w-100">
                <img src="{{ asset('assets/images/'.str_replace(' ', '-', $data->id.'-'.strtolower($data->name).'/'.$data->image)) }}">
              </div>
              <div class="content py-3">
                <div class="place-description d-flex justify-content-between align-items-start mb-1">
                  <div class="place-info">
                    <div class="place-name">
                      <h6 class="font-weight-bold mb-2">{{ $data->name }}</h6>
                    </div>
                    <div class="rating d-flex text-primary">
                      @for($i = 1; $i <= 5; $i++)
                        @if($i <= $data->avg_rating)
                          <i class="fa fa-star"></i>
                        @else
                          <i class="fa fa-star-o"></i>
                        @endif
                      @endfor
                    </div>
                  </div>
                  <div class="place-price text-right">
                    <h5 class="mb-1">{{ number_format($data->price_month, 0, ',','.') }}</h5>
                    <p class="no-margin">per bulan</p>
                  </div>
                </div>
                <div class="place-location">
                  <h6 class="no-margin"><i class="fa fa-map-marker mr-2"></i>{{ $data->address }}</h6>
                </div>
              </div>
            </div>
          </div>
        @endforeach
      </div>
    </div>
  </div>
</div>
@endsection     