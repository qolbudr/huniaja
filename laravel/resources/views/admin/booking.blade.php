@extends('admin/master')

@section('title', 'HuniAja - Halaman Pemilik : Kelola Sewa')

@section('content')
<div class="page-wrapper">
  <!-- ============================================================== -->
  <!-- Bread crumb and right sidebar toggle -->
  <!-- ============================================================== -->
  <div class="page-breadcrumb">
      <div class="row">
          <div class="col-7 align-self-center">
              <h4 class="page-title text-truncate text-dark font-weight-medium mb-1">Sewa</h4>
              <div class="d-flex align-items-center">
                  <nav aria-label="breadcrumb">
                      <ol class="breadcrumb m-0 p-0">
                          <li class="breadcrumb-item"><a href="{{ URL::to('Admin/dashboard') }}" class="text-muted">Dasbor</a></li>
                          <li class="breadcrumb-item text-muted active" aria-current="page">Sewa</li>
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
    <!-- ============================================================== -->
    <!-- Start Page Content -->
    <!-- ============================================================== -->
    <!-- basic table -->
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <div class="row justify-content-between">
                      <div class="col-md-6 my-2">
                        <div class="title">
                          <h4 class="card-title">Admin</h4>
                          <h6 class="card-subtitle">Kelola Sewa</h6>
                        </div>
                      </div>
                    </div>
                    <div class="table-responsive">
                        <table id="datatable" class="table table-striped table-bordered no-wrap">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Nama Property</th>
                                    <th>Kamar</th>
                                    <th>Tanggal Booking</th>
                                    <th>Status</th>
                                    <th>Penghuni</th>
                                </tr>
                            </thead>
                            <tbody>
                              @foreach($booking as $i => $data)
                              <tr>
                                  <td>{{ $i + 1}}</td>
                                  <td>{{ $data->name }}</td>
                                  <td>{{ $data->room }}</td>
                                  <td>{{ $data->date}}</td>
                                  <td>
                                    @if($data->status == 1)
                                        <span class="badge badge-success">Diterima</span>
                                    @elseif($data->status == 0)
                                        <span class="badge badge-warning">Menunggu Persetujuan</span>
                                    @else
                                        <span class="badge badge-danger">Ditolak</span>
                                    @endif
                                  </td>
                                  <td><button onclick="fetchInfo({{ $data->id }})" data-toggle="modal" data-target="#showUser" class="btn btn-primary btn-circle btn-sm viewUser"><i class="fa fa-user"></i></button>
                              </tr>
                              @endforeach
                            </tbody>
                        </table>
                    </div>
                </div>
              </div>
          </div>
      </div>
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
  <script>
      const currentUrl = window.location.pathname
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
  </script>
@endsection