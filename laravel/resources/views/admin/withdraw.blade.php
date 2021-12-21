@extends('admin/master')

@section('title', 'HuniAja - Halaman Admin : Kelola Penarikan')

@section('content')
<div class="page-wrapper">
  <!-- ============================================================== -->
  <!-- Bread crumb and right sidebar toggle -->
  <!-- ============================================================== -->
  <div class="page-breadcrumb">
      <div class="row">
          <div class="col-7 align-self-center">
              <h4 class="page-title text-truncate text-dark font-weight-medium mb-1">Penarikan</h4>
              <div class="d-flex align-items-center">
                  <nav aria-label="breadcrumb">
                      <ol class="breadcrumb m-0 p-0">
                          <li class="breadcrumb-item"><a href="{{ URL::to('Admin/dashboard') }}" class="text-muted">Dashboard</a></li>
                          <li class="breadcrumb-item text-muted active" aria-current="page">Penarikan</li>
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
                          <h6 class="card-subtitle">Kelola Penarikan</h6>
                        </div>
                      </div>
                    </div>
                    <div class="table-responsive">
                        <table id="datatable" class="table table-striped table-bordered no-wrap">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Nama Owner</th>
                                    <th>Jumlah Penarikan</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                              @foreach($withdraw as $i => $p)
                              <tr>
                                  <td>{{ $i + 1}}</td>
                                  <td>{{ $p->owner }}</td>
                                  <td>Rp. {{ number_format($p->amount, 0, ',', '.') }}</td>
                                  <td>
                                    @if($p->status == null)
                                      pending
                                    @elseif($p->status == 1)
                                      accepted
                                    @else
                                      deny
                                    @endif
                                  </td>
                                  <td>
                                  @if($p->status == null)

                                    <button onclick="fetchInfo({{ $p->id }})" data-toggle="modal" data-target="#showUser" class="btn btn-primary btn-circle btn-sm viewUser"><i class="fa fa-user"></i></button>
                                    <button data-toggle="modal" data-target="#confirmationModal" onclick="confirmation({{$p->id}})" class="btn btn-success btn-circle btn-sm"><i class="fa fa-check"></i></button>
                                    <button data-toggle="modal" data-target="#confirmationDenyModal" onclick="denyConfirmation({{$p->id}})" class="btn btn-danger btn-circle btn-sm"><i class="fa fa-times"></i></button>
                                    @else
                                    <button data-toggle="modal" data-target="#showDetail" onclick="getWithdrawDetail({{$p->id}})" class="btn btn-success">Detail Penarikan</button>
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
    </div>
<!-- ============================================================== -->
<!-- End Page wrapper  -->
<!-- ============================================================== -->
<div class="modal fade" id="showUser" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
          <div class="modal-header">
              <h4 class="modal-title" id="myCenterModalLabel">Informasi Owner</h4>
              <button type="button" class="close" data-dismiss="modal"
                  aria-hidden="true">×</button>
          </div>
          <div id="userInfo" method="POST">
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
                  <tr>
                    <th>Nomor Rekening</th>
                    <th>:</th>
                    <th><textarea id="descriptionwd" readonly class="form-control"></textarea></th>
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
<div class="modal fade" id="showDetail" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
          <div class="modal-header">
              <h4 class="modal-title" id="myCenterModalLabel">Informasi Owner</h4>
              <button type="button" class="close" data-dismiss="modal"
                  aria-hidden="true">×</button>
          </div>
          <div id="detailWithdraw">
              <table class="table table-responsive">
                
                <tr>
                  <th>Jumlah Penarikan</th>
                  <th>:</th>
                  <th><span id="amountWithdrawDetail"></span></th>
                </tr>
                  <tr>
                      <th>Nama Penarik</th>
                      <th>:</th>
                      <th><span id="nameWithdrawDetail"></span></th>
                  </tr>
                  <tr>
                      <th>Email</th>
                      <th>:</th>
                      <th><span id="emailWithdrawDetail"></span></th>
                  </tr>
                  <tr>
                      <th>Nomor Telepon</th>
                      <th>:</th>
                      <th><span id="numberWithdrawDetail"></span></th>
                  </tr>
                  <tr>
                      <th>Alamat</th>
                      <th>:</th>
                      <th><span id="addressWithdrawDetail"></span></th>
                  </tr>
                  <tr>
                    <th>Tanggal Pengajuan</th>
                    <th>:</th>
                    <th><span id="dateWithdrawDetail"></span></th>
                  </tr>
                  <tr>
                    <th>Tanggal Konfirmasi</th>
                    <th>:</th>
                    <th><span id="confirmdateWithdrawDetail"></span></th>
                  </tr>
                  <tr>
                    <th>Deskripsi</th>
                    <th>:</th>
                    <th><textarea id="descriptionWithdrawDetail" readonly class="form-control"></textarea></th>
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
              <h4 class="modal-title" id="myCenterModalLabel">Konfirmasi Penarikan</h4>
              <button type="button" class="close" data-dismiss="modal"
                  aria-hidden="true">×</button>
          </div>
          <form action="" id="withdrawForm" method="POST">
            @csrf
            <input type="hidden" name="status" value="accepted">
          <div class="p-3">
          Yakin ingin Menerima Penarikan <span id="withdrawMessage"></span> ?
          </div>
          <div class="row col-md-12 mx-auto">
          <div class="form-group col-md-6">
              <button type="submit" class="btn btn-primary btn-block"  data-dismiss="modal" aria-hidden="true">Tidak</button>
            </div>
            <div class="form-group col-md-6">
              <button type="submit" class="btn btn-success btn-block">Terima</button>
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
              <h4 class="modal-title" id="myCenterModalLabel">Konfirmasi Penarikan</h4>
              <button type="button" class="close" data-dismiss="modal"
                  aria-hidden="true">×</button>
          </div>
          <form action="" id="denyWithdrawForm" method="POST">
            @csrf
            <input type="hidden" name="status" value="deny">
          <div class="p-3">
          Yakin ingin menolak Penarikan <span id="withdrawMessageDeny"></span> ?
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
<script>
  const currentUrl = window.location.pathname
  function fetchInfo(withdrawId){
    fetch(`${currentUrl}/information/${withdrawId}`)
    .then(res => res.json())
    .then(res => {
      document.querySelector('#name').innerText = res.user.name
            document.querySelector('#email').innerText = res.user.email
            document.querySelector('#number').innerText = res.user.phone
            document.querySelector('#address').innerText = res.user.address
            document.querySelector("#descriptionwd").innerText = res.withdraw.description
    })
  }



  function confirmation(withdrawId){
    document.querySelector("#withdrawForm").setAttribute("action", `${currentUrl}/confirmation/${withdrawId}`)
    fetch(`${currentUrl}/information/${withdrawId}`)
    .then(res => res.json())
    .then(res => {
      document.querySelector('#withdrawMessage').innerText = `${res.user.name} dengan jumlah penarikan ${res.withdraw.amount}`
    })
  }

  function denyConfirmation(withdrawId){
    document.querySelector("#denyWithdrawForm").setAttribute("action", `${currentUrl}/confirmation/${withdrawId}`)
    fetch(`${currentUrl}/information/${withdrawId}`)
    .then(res => res.json())
    .then(res => {
      document.querySelector('#withdrawMessageDeny').innerText = `${res.user.name} dengan jumlah penarikan ${res.withdraw.amount}`
    })
  }

  function getWithdrawDetail(withdrawId){
    fetch(`${currentUrl}/details/${withdrawId}`)
    .then(res => res.json())
    .then(res => {
      document.querySelector('#nameWithdrawDetail').innerText = res.name
      document.querySelector('#emailWithdrawDetail').innerText = res.email
      document.querySelector('#numberWithdrawDetail').innerText = res.phone
      document.querySelector('#addressWithdrawDetail').innerText = res.address
      document.querySelector('#amountWithdrawDetail').innerText = res.amount
      document.querySelector('#dateWithdrawDetail').innerText = res.created
      document.querySelector('#confirmdateWithdrawDetail').innerText = res.status_change
      document.querySelector('#descriptionWithdrawDetail').innerText = description

    })
  }
</script>
@endsection