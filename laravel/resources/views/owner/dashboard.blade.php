@extends('owner/master')

@section('title', 'HuniAja - Halaman Pemilik : Dasbor')

@section('content')
<div class="page-wrapper">
  <!-- ============================================================== -->
  <!-- Bread crumb and right sidebar toggle -->
  <!-- ============================================================== -->
  <div class="page-breadcrumb">
      <div class="row">
          <div class="col-12 align-self-center">
              <h3 class="page-title text-truncate text-dark font-weight-medium mb-1">Halo {{ Auth::user()->name }}!</h3>
              <div class="d-flex align-items-center">
                  <nav aria-label="breadcrumb">
                      <ol class="breadcrumb m-0 p-0">
                          <li class="breadcrumb-item"><a href="#">Dasbor</a>
                          </li>
                      </ol>
                  </nav>
              </div>
          </div>
      </div>
  </div>
  <!-- ============================================================== -->
  <!-- End Bread crumb and right sidebar toggle -->
  <!-- ============================================================== -->
  <!-- ============================================================== -->
  <!-- Container fluid  -->
  <!-- ============================================================== -->
  <div class="container-fluid">
      <!-- *************************************************************** -->
      <!-- Start First Cards -->
      <!-- *************************************************************** -->
      <div class="card-group">
          <div class="card border-right">
              <div class="card-body">
                  <div class="d-flex d-lg-flex d-md-block align-items-center">
                      <div>
                          <div class="d-inline-flex align-items-center">
                              <h2 class="text-dark mb-1 font-weight-medium">{{ $propertyCount }}</h2>
                          </div>
                          <h6 class="text-muted font-weight-normal mb-0 w-100 text-truncate">Properti</h6>
                      </div>
                      <div class="ml-auto mt-md-3 mt-lg-0">
                          <span class="opacity-7 text-muted"><i class="fa fa-building"></i></span>
                      </div>
                  </div>
              </div>
          </div>
          <div class="card border-right">
              <div class="card-body">
                  <div class="d-flex d-lg-flex d-md-block align-items-center">
                      <div>
                          <h2 class="text-dark mb-1 w-100 text-truncate font-weight-medium">{{ $incomeCount }}</h2>
                          <h6 class="text-muted font-weight-normal mb-0 w-100 text-truncate">Total Pemasukan
                          </h6>
                      </div>
                      <div class="ml-auto mt-md-3 mt-lg-0">
                          <span class="opacity-7 text-muted"><i data-feather="dollar-sign"></i></span>
                      </div>
                  </div>
              </div>
          </div>
          <div class="card border-right">
              <div class="card-body">
                  <div class="d-flex d-lg-flex d-md-block align-items-center">
                      <div>
                          <div class="d-inline-flex align-items-center">
                              <h2 class="text-dark mb-1 font-weight-medium">Rp. {{$withdrawCount}}</h2>
                          </div>
                          <h6 class="text-muted font-weight-normal mb-0 w-100 text-truncate">Jumlah Penarikan</h6>
                      </div>
                      <div class="ml-auto mt-md-3 mt-lg-0">
                          <span class="opacity-7 text-muted"><i data-feather="dollar-sign"></i></span>
                      </div>
                  </div>
              </div>
          </div>
      </div>
      
      <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Sewa</h4>
                    <h6 class="card-subtitle">Kelola Sewa anda</h6>
                    <div class="table-responsive">
                        <table id="datatable" class="table table-striped table-bordered no-wrap">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Properti</th>
                                    <th>Tanggal</th>
                                    <th>Status</th>
                                    <th>Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                              @foreach($booking as $k => $data)
                              <tr>
                                  <td>{{ $k + 1}}</td>
                                  <td>{{ $data->name }}</td>
                                  <td>{{ $data->date }}</td>
                                  <td>
                                    @if($data->status == 0)
                                          Pending
                                    @elseif($data->status == 1)
                                        diterima
                                    @elseif($data->status == 2)
                                        selesai
                                    @else
                                        ditolak
                                    @endif
                                  </td>
                                  <td>
                                    <button onclick="fetchInfo({{ $data->id }})" data-toggle="modal" data-target="#showUser" class="btn btn-primary btn-circle btn-sm viewUser"><i class="fa fa-user"></i></button>
                                    @if($data->status == 0)
                                    <button data-toggle="modal" data-target="#confirmationModal" onclick="confirmation({{$data->id}})" class="btn btn-success btn-circle btn-sm"><i class="fa fa-check"></i></button>
                                    <button data-toggle="modal" data-target="#confirmationDenyModal" onclick="denyConfirmation({{$data->id}})" class="btn btn-danger btn-circle btn-sm"><i class="fa fa-times"></i></button>
                                    @elseif($data->status == 1)
                                    <button data-toggle="modal" data-target="#stopSewa" onclick="stopBooking({{$data->id}})" class="btn btn-danger btn-circle btn-sm"><i class="fa fa-stop"></i></button>
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
      <!-- *************************************************************** -->
      <!-- End Top Leader Table -->
      <!-- *************************************************************** -->
  </div>
</div>
<div class="modal fade" id="showUser" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myCenterModalLabel">Informasi Calon Penghuni</h4>
                <button type="button" class="close" data-dismiss="modal"
                    aria-hidden="true">×</button>
            </div>
            <div id="userInfo" method="POST">
                <img src="" class="col-12 p-5" alt="" id="profileImage">
                <table class="table table-responsive">
                    <tr>
                        <th>Nama</th>
                        <th>:</th>
                        <th><span id="name"></span></th>
                    </tr>
                    <tr>
                        <th>Email</th>
                        <th>:</th>
                        <th><span id="email"></span></th>
                    </tr>
                    <tr>
                        <th>Nomor Telepon</th>
                        <th>:</th>
                        <th><span id="number"></span></th>
                    </tr>
                    <tr>
                        <th>Alamat</th>
                        <th>:</th>
                        <th><span id="address"></span></th>
                    </tr>
                </table>
            <div class="row col-md-12 mx-auto">
            <div class="form-group col-md-12">
                <button type="button" class="btn btn-primary btn-block"  data-dismiss="modal" aria-hidden="true">Tutup</button>
              </div>
            </div>
        </div>
        </div>
    </div>
  </div>

  <div class="modal fade" id="confirmationModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myCenterModalLabel">Konfirmasi Penyewaan</h4>
                <button type="button" class="close" data-dismiss="modal"
                    aria-hidden="true">×</button>
            </div>
            <form action="" id="acceptBookingForm" method="POST">
                
              @csrf
              <input type="hidden" name="status" value="accepted">
            <div class="p-3">
            Yakin ingin menyutujuhi penyewaan <span id="bookingDetail"></span> ?
            </div>
            <div class="row col-md-12 mx-auto">
            <div class="form-group col-md-6">
                <button type="submit" class="btn btn-primary btn-block"  data-dismiss="modal" aria-hidden="true">Tidak</button>
              </div>
              <div class="form-group col-md-6">
                <button type="submit" class="btn btn-success btn-block">Ya</button>
              </div>
            </div>
        </form>
        </div>
    </div>
</div>

<div class="modal fade" id="confirmationDenyModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myCenterModalLabel">Konfirmasi Penyewaan</h4>
                <button type="button" class="close" data-dismiss="modal"
                    aria-hidden="true">×</button>
            </div>
            <form action="" id="denyBookingForm" method="POST">
              @csrf

            <div class="p-3">
            Yakin ingin menolak penyewaan <span id="bookingDetailDeny"></span> ?
            </div>
            <div class="row col-md-12 mx-auto">
            <div class="form-group col-md-6">
                <button type="submit" class="btn btn-primary btn-block"  data-dismiss="modal" aria-hidden="true">Tidak</button>
              </div>
              <div class="form-group col-md-6">
                <button type="submit" class="btn btn-danger btn-block">Tolak</button>
              </div>
            </div>
        </form>
        </div>
    </div>
</div>
<div class="modal fade" id="stopSewa" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myCenterModalLabel">Konfirmasi penghentian Penyewaan</h4>
                <button type="button" class="close" data-dismiss="modal"
                    aria-hidden="true">×</button>
            </div>
            <form action="" id="stopBookingForm" method="GET">
              @csrf            
              <input type="hidden" name="id" id="idStop">

            <div class="p-3">
            Yakin ingin menghentikan Peyewaan <span id="stopSewaSpan"></span> ?
            </div>
            <div class="row col-md-12 mx-auto">
            <div class="form-group col-md-6">
                <button type="submit" class="btn btn-primary btn-block"  data-dismiss="modal" aria-hidden="true">Tidak</button>
              </div>
              <div class="form-group col-md-6">
                <button type="submit" class="btn btn-danger btn-block">Hentikan</button>
              </div>
            </div>
        </form>
        </div>
    </div>
</div>

<script>
    const currentUrl = window.location.pathname.replace("dashboard", "booking")
    function fetchInfo(bookingId){
        fetch(`${currentUrl}/information/${bookingId}`)
        .then(res => res.json())
        .then(res => {
            document.querySelector('#name').innerText = res.user.name
            document.querySelector('#email').innerText = res.user.email
            document.querySelector('#number').innerText = res.user.phone
            document.querySelector('#address').innerText = res.user.address
            document.querySelector('#profileImage').setAttribute("src", res.user.face)
        })
    }

    function confirmation(bookingId){
        document.querySelector('#acceptBookingForm').setAttribute('action', `${currentUrl}/confirmation/${bookingId}`)
        fetch(`${currentUrl}/information/${bookingId}`)
        .then(res => res.json())
        .then(res => {
            document.querySelector('#bookingDetail').innerText = `${res.property.name} oleh ${res.user.name}`
        })
    }

    function denyConfirmation(bookingId){
        document.querySelector('#denyBookingForm').setAttribute('action', `${currentUrl}/confirmation/${bookingId}`)
        fetch(`${currentUrl}/information/${bookingId}`)
        .then(res => res.json())
        .then(res => {
            document.querySelector('#bookingDetailDeny').innerText = `${res.property.name} oleh ${res.user.name}`
        })
    }

    function stopBooking(bookingId){
        document.querySelector('#idStop').value = bookingId
        document.querySelector('#stopBookingForm').setAttribute('action', `${currentUrl}/stop/${bookingId}`)
    }
    
</script>
@endsection