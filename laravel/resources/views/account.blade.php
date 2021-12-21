@extends('master')

@section('title', 'HuniAja - Cari Hunian yang Cocok untuk Anda')

@section('content')
<div class="w-100 bg-primary d-flex align-items-center account-banner text-center">
  <div class="w-100 text-center">
    <h4 class="font-weight-bold">AKUN SAYA</h4>
  </div>
</div>
<div class="wrapper my-2">
  <div class="row mt-3">
    <div class="col-12 my-2">
      <div class="card">
        <div class="account-menu d-flex align-items-center">
          <a data-target="#account-card" class="text-none p-4 {{ Session::has('data') ? '' : 'active' }}" href="javascript:void(0)">Profil</a>
          <a data-target="#booking-card" class="text-none p-4 {{ Session::get('data') == 'sewa' ? 'active' : '' }}" href="javascript:void(0)">Sewa</a>
          <a data-target="#bill-card" class="text-none p-4 {{ Session::get('data') == 'sewa' ? 'active' : '' }}" href="javascript:void(0)">Tagihan</a>
          <a data-target="#balance-card" class="text-none p-4" href="javascript:void(0)">Saldo</a>
          <a data-target="#favorite-card" class="text-none p-4" href="javascript:void(0)">Favorit</a>
        </div>
      </div>
    </div>
    <div class="account-card col-12 my-2 {{ Session::has('data') ? 'd-none' : '' }}" id="account-card">
      <div class="card p-4">
        <div class="card-title">
          <h5 class="font-weight-bold">KELOLA PROFIL</h5>
        </div>
        <form action="{{ URL::to('account/user/update') }}" method="post">
          @csrf
          <div class="row">
            <div class="col-12">
              <div class="form-group">
                <label>Nama</label>
                <input type="text" class="form-control" name="name" value="{{ $user->name }}" placeholder="Nama Lengkap" required>
              </div>
            </div>
            <div class="col-12 col-md-6">
              <div class="form-group">
                <label>Email</label>
                <input type="email" class="form-control" name="email" value="{{ $user->email }}" placeholder="Email" required>
              </div>
            </div>
            <div class="col-12 col-md-6">
              <div class="form-group">
                <label>Tanggal Lahir</label>
                <input type="date" class="form-control" name="dob" value="{{ $user->dob }}" placeholder="Tanggal Lahir" required>
              </div>
            </div>
            <div class="col-12">
              <div class="form-group">
                <label>Alamat</label>
                <input type="text" class="form-control" name="address" value="{{ $user->address }}" placeholder="Alamat" required>
              </div>
            </div>
            <div class="col-12">
              <div class="form-group">
                <label>Telepon</label>
                <input type="number" class="form-control" name="phone" value="{{ $user->phone }}" placeholder="Nomor Telepon" required>
              </div>
            </div>
            <div class="col-12 mt-3">
              <div class="form-group">
                <button type="submit" class="btn btn-primary btn-block py-2">Simpan</button>
              </div>
            </div>
          </div>
        </form>
        <hr>
        <div class="row justify-content-between align-items-center">
          <div class="col-12 col-md-6 my-2">
            <h6 class="font-weight-bold mb-2">Ganti password</h6>
            <p class="no-margin">Ganti kredensial password login anda</p>
          </div>
          <div class="col-12 col-md-6 text-right my-2">
            <button data-toggle="modal" data-target="#changepassword" class="btn btn-primary">Ganti Password</button>
          </div>
        </div>
        <hr>
        <div class="row justify-content-between align-items-center">
          <div class="col-12 col-md-6 my-2">
            <h6 class="font-weight-bold mb-2">Hapus akun</h6>
            <p class="no-margin">Semua data anda akan hilang, dan anda tidak bisa mengembalikan akun anda</p>
          </div>
          <div class="col-12 col-md-6 text-right my-2">
            <button data-toggle="modal" data-target="#deleteaccount" class="btn btn-danger px-4">Hapus Akun</button>
          </div>
        </div>
      </div>
    </div>

    <div class="account-card col-12 my-2 {{ Session::get('data') == 'sewa' ? '' : 'd-none' }}" id="booking-card">
      <div class="card p-4">
        <div class="card-title">
          <h5 class="font-weight-bold">SEWA</h5>
        </div>
        <div class="row mt-3">
          @if(isset($booking))
            <div class="col-12 col-md-4">
              <div class="card-hotel">
                <a class="click-target" href="{{ URL::to('detail/'.$booking->id.'/'.str_replace(' ', '-', strtolower($booking->name))) }}"></a>
                <div class="place-img w-100">
                  <img src="{{ asset('assets/images/'. $booking->id .'/'.$booking->image) }}">
                </div>
                <div class="content py-3">
                  <div class="place-description d-flex justify-content-between align-items-start mb-1">
                    <div class="place-info">
                      <div class="place-name">
                        <h6 class="font-weight-bold mb-2">{{ $booking->name }}</h6>
                      </div>
                      <div class="rating d-flex text-primary">
                        @for($i = 1; $i <= 5; $i++)
                          @if($i <= $booking->avg_rating)
                            <i class="fa fa-star"></i>
                          @else
                            <i class="fa fa-star-o"></i>
                          @endif
                        @endfor
                      </div>
                    </div>
                    <div class="place-price text-right">
                      <h5 class="mb-1">{{ number_format($booking->price_month, 0, ',','.') }}</h5>
                      <p class="no-margin">per bulan</p>
                    </div>
                  </div>
                  <div class="place-location">
                    <h6 class="no-margin"><i class="fa fa-map-marker mr-2"></i>{{ $booking->address }}</h6>
                  </div>
                </div>
              </div>
              @if($booking->status == 0)
                <div class="alert alert-warning">Status sewa menunggu persetujuan pemilik</div>
              @elseif($booking->status == 1)
                <div class="alert alert-success">Status sewa telah disetujui pemilik</div>
              @else
            	<div class="alert alert-danger">Sewa ditolak pemilik</div>
              @endif
            </div>
            <div class="col-12 col-md-8">
              <form action="{{ URL::to('review/add') }}" method="post">
                @csrf
                <input type="hidden" name="propertyId" value="{{ $booking->id }}">
                <div class="form-group">
                  <label>Rating</label>
                  <select class="form-control" name="rating" required>
                    <option value="1" {{ (isset($review) && $review->rating == 1) ? 'selected' : '' }} >1 Bintang</option>
                    <option value="2" {{ (isset($review) && $review->rating == 2) ? 'selected' : '' }}>2 Bintang</option>
                    <option value="3" {{ (isset($review) && $review->rating == 3) ? 'selected' : '' }}>3 Bintang</option>
                    <option value="4" {{ (isset($review) && $review->rating == 4) ? 'selected' : '' }}>4 Bintang</option>
                    <option value="5" {{ (isset($review) && $review->rating == 5) ? 'selected' : '' }}>5 Bintang</option>
                  </select>
                </div>
                <div class="form-group">
                  <textarea class="form-control" name="review" rows="7" placeholder="Beri review anda..." required>{{ isset($review) ? $review->review : '' }}</textarea>
                </div>
                <div class="form-group">
                  <button class="btn btn-primary" type="submit">Beri Review</button>
                </div>
              </form>
            </div>
          @else
            <div class="col-12">
              <div class="alert alert-danger">List sewa masih kosong</div>
            </div>
          @endif
        </div>
      </div>
    </div>

    <div class="account-card col-12 my-2 {{ Session::get('data') == 'tagihan' ? '' : 'd-none' }}" id="bill-card">
      <div class="card p-4">
        <div class="card-title">
          <h5 class="font-weight-bold">TAGIHAN</h5>
        </div>
        <div class="row mt-3">
          <div class="col-12">
            <div class="table-responsive">
              <table class="table table-bordered datatable">
                <thead>
                  <tr>
                    <th>No</th>
                    <th>Nama Hotel</th>
                    <th>Tanggal</th>
                    <th>Tagihan</th>
                    <th>Status</th>
                  </tr>
                </thead>
                <tbody>
                  @foreach($bill as $index => $data)
                    <tr>
                      <td>{{ $index+1 }}</td>
                      <td>{{ $data->propertyName }}</td>
                      <td>{{ $data->date }}</td>
                      <td>{{ 'Rp. '. number_format($data->price, 0, '.', ',') }}</td>
                      <td>
                        @if($data->status == 1)
                          <span class="badge badge-success px-4 py-2">Lunas</span>
                        @else
                          <a href="{{ URL::to('pay/bill/'.$data->id) }}" class="btn btn-danger btn-sm">Bayar Tagihan</a>
                        @endif
                      </td>
                    </tr>
                  @endforeach
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="account-card col-12 my-2 d-none" id="balance-card">
      <div class="card p-4">
        <div class="card-title">
          <h5 class="font-weight-bold">SALDO AKUN</h5>
        </div>
        <div class="row mt-3">
          <div class="col-12">
            <div class="card wallet-card no-margin mb-3 bg-primary text-white">
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
            <div class="alert alert-warning align-items-center justify-content-between my-3 d-none">
              <div class="row align-items-center">
                <div class="col-6">
                  <h6 class="no-margin">Mohon selesaikan pembayaran anda sebelumnya</h6>
                </div>
                <div class="col-6 text-right">
                  <button class="btn btn-dark btn-check my-1">Bayar</button>
                </div>
              </div>
            </div>
            <div class="my-3">
              Untuk topup masukkan nominal topup pada form dibawah ini.
            </div>
            <div class="filter-box my-2 d-flex">
              <button class="btn filter-type-btn mr-2 mb-2 btn-primary text-white" type="500000">500.000</button>
              <button class="btn filter-type-btn mr-2 mb-2 btn-outline-primary" type="1000000">1.000.000</button>
              <button class="btn filter-type-btn mr-2 mb-2 btn-outline-primary" type="5000000">5.000.000</button>
              <button class="btn filter-type-btn mr-2 mb-2 btn-outline-primary" type="10000000">10.000.000</button>
            </div>
            <div class="form-topup">
              <div class="row">
                <div class="col-12 col-md-8">
                  <input class="form-control my-1" type="number" placeholder="Nominal Saldo" value="500000" name="balance">
                </div>
                <div class="col-12 col-md-4">
                  <button class="btn btn-primary btn-block btn-topup my-1">Topup</button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="account-card col-12 my-2 d-none" id="favorite-card">
      <div class="card p-4">
        <div class="card-title">
          <h5 class="font-weight-bold">FAVORIT</h5>
        </div>
        <div class="row mt-3">
          @if(count($property) > 0)
            @foreach($property as $data)
              <div class="col-12 col-xs-6 col-sm-6 col-md-4 col-lg-3">
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
              </div>
            @endforeach
          @else
            <div class="col-12">
              <div class="alert alert-danger">List properti favorit masih kosong</div>
            </div>
          @endif
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="changepassword" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
          <div class="modal-header">
              <h6 class="modal-title" id="myCenterModalLabel">Ganti Password</h6>
              <button type="button" class="close" data-dismiss="modal"
                  aria-hidden="true">×</button>
          </div>
          <form action="{{ URL::to('account/change/password') }}" method="post">
            @csrf
            <div class="modal-body">
                <div class="row">
                  <div class="form-group col-md-12">
                    <label>Password Saat Ini</label>
                    <input class="form-control" type="password" name="current_password" placeholder="Password saat ini" required>
                  </div>
                  <div class="form-group col-md-12">
                    <label>Password Baru</label>
                    <input class="form-control" type="password" name="password" placeholder="Password baru" required>
                  </div>
                  <div class="form-group col-md-12">
                    <label>Konfirmasi Password</label>
                    <input class="form-control" type="password" name="password_confirmation" placeholder="Konfirmasi password" required>
                  </div>
                  <div class="form-group col-md-12">
                    <button type="submit" class="btn btn-primary btn-block">Simpan</button>
                  </div>
                </div>
            </div>
          </form>
      </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div>

<div class="modal fade" id="deleteaccount" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
          <div class="modal-header">
              <h6 class="modal-title" id="myCenterModalLabel">Hapus Akun</h6>
              <button type="button" class="close" data-dismiss="modal"
                  aria-hidden="true">×</button>
          </div>
          <div class="modal-body">
              <div class="row">
                <div class="col-12 text-center">
                  Yakin ingin menghapus account ?
                </div>
              </div>
          </div>
          <div class="modal-footer">
            <button data-dismiss="modal" class="btn btn-danger">Batal</button>
            <a href="{{ URL::to('account/delete') }}" class="btn btn-primary">Hapus</a>
          </div>
      </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div>