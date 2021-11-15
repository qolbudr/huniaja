@extends('master-home')
@section('title', 'HuniAja - Cari Hunian yang Cocok untuk Anda')

@section('content')
<div class="place-img-slide owl-carousel owl-theme no-margin">
  @foreach($image as $data)
    <div class="item">
      <div class="item-slide">
        <img class="w-100" src="{{ asset('assets/images/'.str_replace(' ', '-', $detail->id.'-'.strtolower($detail->name).'/'.$data->image)) }}">
        <div class="overlay"></div>
      </div>
    </div>
  @endforeach
</div>
<div class="wrapper mt-0 py-2">
  <div class="row">
    <div class="col-12 col-md-7">
      <div class="card-hotel">
        <div class="content py-3">
          <div class="place-description d-flex justify-content-between align-items-start mb-1">
            <div class="place-info">
              <h3 class="font-weight-bold mb-2">{{ $detail->name }}</h3>
              <div class="rating d-flex text-primary">
                @for($i = 1; $i <= 5; $i++)
                  @if($i <= $detail->avg_rating)
                    <i class="fa fa-star"></i>
                  @else
                    <i class="fa fa-star-o"></i>
                  @endif
                @endfor
              </div>
            </div>
            <div class="place-fav text-right">
              <a href="{{ $isFavorite > 0 ? URL::to('favorite/remove/'.$detail->id) : URL::to('favorite/add/'.$detail->id) }}" class="btn filter-btn p-2 p-md-3 {{ $isFavorite > 0 ? 'btn-primary text-white' : 'btn-outline-primary' }}">
                <h6 class="no-margin"><i class="fa fa-heart"></i></h6>
              </a>
            </div>
          </div>
          <div class="place-location">
            <h6 class="no-margin"><i class="fa fa-map-marker mr-2"></i>{{ $detail->address }}</h6>
          </div>
          <hr class="my-4">
          <div class="place-about">
            <h5 class="font-weight-bold mb-2">Tentang</h5>
            <p class="no-margin text-justify">{{ $detail->description }}</p>
          </div>
          <hr class="my-3">
          <div class="place-facilities">
            <h5 class="font-weight-bold mb-3">Fasilitas</h5>
            <div class="facilities d-flex align-items-center mt-3">
              @foreach($facility as $data)
                <div class="card-facilities text-primary d-flex text-center align-items-center p-3 my-2 mr-2">
                  <div class="content w-100">
                    <h5 class="my-2"><i class="{{ $data->webIcon }}"></i></h5>
                    <p class="no-margin">{{ $data->name }}</p>
                  </div>
                </div>
              @endforeach
            </div>
          </div>
          <hr class="my-3">
          <div class="place-review">
            <h5 class="font-weight-bold mb-2">Pemilik</h5>
            <div class="owner-info mt-3">
              <div class="card p-4">
                <div class="row justify-content-between align-items-center">
                  <div class="col-12 col-md-6 mb-1">
                    <h6 class="font-weight-bold mb-2">{{ $detail->ownerName }}</h6>
                    <p class="no-margin">{{ $detail->phone }}</p>
                  </div>
                  <div class="col-12 col-md-6 mb-1 text-right">
                    <button class="btn btn-primary px-4" id="chat-owner" ownerId="{{ $detail->ownerId }}" ownerName="{{ $detail->ownerName }}">Chat</button>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <hr class="my-3">
          <div class="place-review">
            <h5 class="font-weight-bold mb-2">Ulasan</h5>
            <div class="list-review mt-4">
              <table class="table w-100">
                @foreach($review as $data)
                  <tr>
                    <td>
                      <div class="review-item">
                        <h6 class="font-weight-bold mb-2">{{ $data->name }}</h6>
                        <p class="no-margin">{{ $data->review }}</p>
                      </div>
                    </td>
                  </tr>
                @endforeach
              </table>
            </div>
          </div>
          <hr class="my-3">
        </div>
      </div>
    </div>
    <div class="col-12 col-md-5">
      <div class="map-box pt-3 hide-mobile">
        <div id="map-detail" lat="{{ $detail->latitude }}" long="{{ $detail->longitude }}"></div>
      </div>
      <div class="payment-plan py-3">
        <h5 class="font-weight-bold mb-2">Pembayaran</h5>
        <div class="payment-box py-2 mb-2 d-flex">
          <button class="btn filter-btn px-4 mr-2 mb-2 btn-primary text-white" data="payment-daily">Harian</button>
          <button class="btn filter-btn px-4 mr-2 mb-2 btn-outline-primary" data="payment-monthly">Bulanan</button>
          <button class="btn filter-btn px-4 mr-2 mb-2 btn-outline-primary" data="payment-yearly">Tahunan</button>
        </div>
        <div class="card wallet-card no-margin mb-3">
          <div class="p-4 d-flex align-items-center justify-content-between">
            <div class="wallet-title">
              <h6 class="font-weight-bold mb-2">Saldo</h6>
              <p class="no-margin">Saldo e-wallet anda</p>
            </div>
            <div class="wallet-balance">
              <h5>{{ Auth::user()->balance == null ? 'Rp. 0' : 'Rp. ' . number_format(Auth::user()->balance, 0, ',', '.')  }}</h5>
            </div>
          </div>
        </div>
        <div class="payment-daily" price="{{ $detail->price_day }}">
          <div class="row">
            <div class="col-6">                  
              <input class="form-control" type="date" min="{{ date('Y-m-d') }}" value="{{ date('Y-m-d') }}" name="check-in" placeholder="Check-in" required>
            </div>
            <div class="col-6">
              <input class="form-control" type="date" min="{{ date('Y-m-d', strtotime('+1 day')) }}" value="{{ date('Y-m-d', strtotime('+1 day')) }}" max="{{ date('Y-m-d', strtotime('+30 day')) }}"  name="check-out" placeholder="Check-out" required>
            </div>
          </div>
          <div class="form-group mt-3">
            <table class="table w-100">
              <tr>
                <td>Rp. {{ number_format($detail->price_day, 0, ',','.') }} x 1 malam</td>
                <td class="text-right">Rp. {{ number_format($detail->price_day, 0, ',','.') }}</td>
              </tr>
              <tr>
                <td><h5 class="font-weight-bold">Total</h5></td>
                <td class="text-right">Rp. {{ number_format($detail->price_day, 0, ',','.') }}</td>
              </tr>
            </table>
          </div>
          <div class="form-group mt-3">
            <button class="btn btn-primary btn-block">Pesan Sekarang</button>
          </div>
        </div>
        <div class="payment-monthly d-none" price="{{ $detail->price_month }}">
          <div class="row">
            <div class="col-12">
              <select class="form-control" name="month">
                <option value="1">1 Bulan</option>
                <option value="2">2 Bulan</option>
                <option value="3">3 Bulan</option>
                <option value="4">4 Bulan</option>
                <option value="5">5 Bulan</option>
                <option value="6">6 Bulan</option>
                <option value="7">7 Bulan</option>
                <option value="8">8 Bulan</option>
                <option value="9">9 Bulan</option>
                <option value="10">10 Bulan</option>
                <option value="11">11 Bulan</option>
                <option value="12">12 Bulan</option>
              </select>
            </div>
            <div class="col-12 mt-3">
              <select class="form-control" name="plan">
                <option value="full">Penuh</option>
                <option value="1">1x Bayar</option>
              </select>
            </div>
          </div>
          <div class="form-group mt-3">
            <table class="table w-100">
              <tr>
                <td>Biaya Sewa</td>
                <td class="text-right">Rp. {{ number_format($detail->price_month, 0, ',','.') }}</td>
              </tr>
              <tr>
                <td><h5 class="font-weight-bold">Total</h5></td>
                <td class="text-right">Rp. {{ number_format($detail->price_month, 0, ',','.') }}</td>
              </tr>
            </table>
          </div>
          <div class="form-group mt-3">
            <button class="btn btn-primary btn-block">Pesan Sekarang</button>
          </div>
        </div>
        <div class="payment-yearly d-none" price="{{ $detail->price_year }}">
          <div class="row">
            <div class="col-12">
              <select class="form-control" name="year">
                <option value="1">1 Tahun</option>
                <option value="2">2 Tahun</option>
              </select>
            </div>
            <div class="col-12 mt-3">
              <select class="form-control" name="plan">
                <option value="full">Penuh</option>
                <option value="6">2x Bayar (Tiap 6 bulan)</option>
                <option value="4">3x Bayar (Tiap 4 bulan)</option>
                <option value="3">4x Bayar (Tiap 3 bulan)</option>
                <option value="2">6x Bayar (Tiap 2 bulan)</option>
                <option value="1">12x Bayar (Tiap 1 bulan)</option>
              </select>
            </div>
          </div>
          <div class="form-group mt-3">
            <table class="table w-100">
              <tr>
                <td>Biaya Sewa</td>
                <td class="text-right">Rp. {{ number_format($detail->price_year, 0, ',','.') }}</td>
              </tr>
              <tr>
                <td><h5 class="font-weight-bold">Total</h5></td>
                <td class="text-right">Rp. {{ number_format($detail->price_year, 0, ',','.') }}</td>
              </tr>
            </table>
          </div>
          <div class="form-group mt-3">
            <button class="btn btn-primary btn-block">Pesan Sekarang</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<form id="pay-day" action="{{ URL::to('pay/day') }}" method="post">
  @csrf
  <input type="hidden" name="propertyId" value="{{ $detail->id }}">
  <input type="hidden" name="duration" value="1">
  <input type="hidden" name="price" value="{{ $detail->price_day }}">
</form>

<form id="pay-month" action="{{ URL::to('pay/month') }}" method="post">
  @csrf
  <input type="hidden" name="propertyId" value="{{ $detail->id }}">
  <input type="hidden" name="duration" value="1">
  <input type="hidden" name="price" value="{{ $detail->price_month }}">
</form>

<form id="pay-year" action="{{ URL::to('pay/year') }}" method="post">
  @csrf
  <input type="hidden" name="propertyId" value="{{ $detail->id }}">
  <input type="hidden" name="duration" value="1">
  <input type="hidden" name="year" value="1">
  <input type="hidden" name="price" value="{{ $detail->price_year }}">
</form>
@endsection