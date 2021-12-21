@extends('master')
@section('title', 'HuniAja - Cari Hunian yang Cocok untuk Anda')

@section('content')
<div class="wrapper">
  <div class="row">
    <div class="col-12 col-md-4 py-3">
      <div class="form-group">
        <form id="search-form" action="{{ URL::to('search') }}" method="get">
          <div class="d-flex position-relative mt-3">
            <input class="form-control mr-3 w-100" placeholder="Harga" name="price" value="{{$price}}" type="number">
          </div>
          <div class="d-flex position-relative mt-3">
            <input class="form-control mr-3 search-property w-100" placeholder="Cari rumah, apartemen dan kost terdekat" required>
            <input type="hidden" name="q" value="{{ $place }}" required>
            <input type="hidden" name="latitude" value="{{ $latitude }}" required>
            <input type="hidden" name="longitude" value="{{ $longitude }}" required>
            <div class="place-result bg-white position-absolute">
            </div>
          </div>
         

        </form>
        <hr class="my-3">
        <h6 class="mb-3">Ditemukan <span id="total-property">{{ count($property) }}</span> kos di sekitar {{ $place }}</h6>
        <div class="list-place">
          @if(count($property) > 0)
            @foreach($property as $data)
              <div class="card-hotel">
                <a class="click-target" href="{{ URL::to('detail/'.$data->id.'/'.str_replace(' ', '-', strtolower($data->name))) }}"></a>
                <div class="place-img w-100">
                  <img src="{{ asset('assets/images/'.$data->id.'/'.$data->image) }}">
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
            @endforeach
          @else
            <div class="alert alert-danger">Tidak ada properti yang cocok</div>
          @endif
        </div>
      </div>
    </div>
    <div class="col-12 col-md-8 hide-mobile">
      <div id="map" lat="{{ $latitude }}" long="{{ $longitude }}"></div>
    </div>
  </div>
</div>
@endsection     