@extends('admin/master')

@section('title', 'HuniAja - Halaman Pemilik : Kelola Fasilitas')

@section('content')
<div class="page-wrapper">
  <!-- ============================================================== -->
  <!-- Bread crumb and right sidebar toggle -->
  <!-- ============================================================== -->
  <div class="page-breadcrumb">
      <div class="row">
          <div class="col-7 align-self-center">
              <h4 class="page-title text-truncate text-dark font-weight-medium mb-1">Fasilitas</h4>
              <div class="d-flex align-items-center">
                  <nav aria-label="breadcrumb">
                      <ol class="breadcrumb m-0 p-0">
                          <li class="breadcrumb-item"><a href="{{ URL::to('Admin/dashboard') }}" class="text-muted">Dasbor</a></li>
                          <li class="breadcrumb-item text-muted active" aria-current="page">Fasilitas</li>
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
                          <h6 class="card-subtitle">Kelola Fasilitas</h6>
                        </div>
                      </div>
                      <div class="col-md-6 my-2 text-lg-right">
                        <button class="btn btn-primary" data-toggle="modal" data-target="#addFacility">Tambah Fasilitas</button>
                      </div>
                    </div>
                    <div class="table-responsive">
                        <table id="datatable" class="table table-striped table-bordered no-wrap">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Fasilitas</th>
                                    <th>Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                              @foreach($facilityCollection as $i => $facility)
                              <tr>
                                  <td>{{ $i + 1}}</td>
                                  <td>{{ $facility->name }}</td>
                                  <td>
                                    <button class="btn btn-warning btn-circle btn-sm" data-toggle="modal" data-target="#editFacility" onclick="editFacility({{$facility->id}})"><i class="fa fa-edit"></i></button>
                                    <button class="btn btn-danger btn-circle btn-sm" data-toggle="modal" data-target="#deleteFacility" onclick="deleteFacility('{{$facility->name}}',{{$facility->id}})"><i class="fa fa-trash"></i></button>
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
<div class="modal fade" id="addFacility" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myCenterModalLabel">Tambah Fasilitas</h4>
                <button type="button" class="close" data-dismiss="modal"
                    aria-hidden="true">×</button>
            </div>
            <form action="{{ URL::to('admin/facility/create') }}" method="post">
              @csrf
              <div class="modal-body">
                  <div class="row">
                    <div class="form-group col-md-12">
                      <input type="hidden" name="icon" id="iconFacility">
                      <input type="hidden" name="mobileIcon" id="mobileIcon">
                      <input type="text" class="form-control" placeholder="Nama Fasilitas" name="name" id="nameFacilityInput" required readonly>
                    </div>
                    
                    <div class="col-md-12 row form-group mx-auto">
                      @foreach(json_decode($facilities) as $i => $f)
                        <button type="button" class="col-md-2 m-1 p-1 btn btn-light " onclick="changeFacilitiesStore('{{$f->name}}','{{$f->icon}}', '{{$f->mobileIcon}}')">
                          @if($f->name == "Sarapan")
                          <svg xmlns="http://www.w3.org/2000/svg" class="col-12" width="20" height="20" viewBox="0 0 48 48"><path d="M31 48a1 1 0 0 1-1-1V1a1 1 0 1 1 2 0v46a1 1 0 0 1-1 1z"/><path d="M37 31h-6a1 1 0 110-2h4.996c-.133-16.802-3.585-26.66-5.014-27.002a.991.991 0 01-.991-.999C29.991.447 30.447 0 31 0c4.188 0 7 15.512 7 30a1 1 0 01-1 1zM17 18c-3.859 0-7-3.141-7-7V1a1 1 0 112 0v10c0 2.757 2.243 5 5 5s5-2.243 5-5V1a1 1 0 112 0v10c0 3.859-3.141 7-7 7z"/><path d="M17 48a1 1 0 0 1-1-1V1a1 1 0 1 1 2 0v46a1 1 0 0 1-1 1z"/></svg>
                          @elseif($f->name == "AC")
                          <svg xmlns="http://www.w3.org/2000/svg" class="col-12" height="20" data-name="Layer 1" viewBox="0 0 24 24"><path d="M12,17a.5.5,0,0,0-.5.5v2a.5.5,0,0,0,1,0v-2A.5.5,0,0,0,12,17ZM8.26,17a.5.5,0,0,0-.58.41l-.35,2a.5.5,0,0,0,.41.58h.09a.5.5,0,0,0,.49-.41l.35-2A.5.5,0,0,0,8.26,17Zm-3.75.07a.5.5,0,0,0-.64.3l-.68,1.88a.5.5,0,1,0,.94.34l.68-1.88A.5.5,0,0,0,4.51,17.09ZM13.5,8h-3a.5.5,0,0,0,0,1h3a.5.5,0,0,0,0-1Zm9.86-3.16A2.55,2.55,0,0,0,21.46,4H2.54a2.55,2.55,0,0,0-1.89.84A2.48,2.48,0,0,0,0,6.75l.61,6A2.52,2.52,0,0,0,3.15,15h.62l.15,0,.14,0H20.85a2.52,2.52,0,0,0,2.52-2.25l.61-6A2.48,2.48,0,0,0,23.36,4.84ZM4.39,14a1.15,1.15,0,0,1,1.15-1H18.46a1.14,1.14,0,0,1,1.14,1Zm18-1.35A1.52,1.52,0,0,1,20.85,14h-.23a2.15,2.15,0,0,0-2.15-2H5.54a2.16,2.16,0,0,0-1.68.79A2.12,2.12,0,0,0,3.39,14H3.15a1.52,1.52,0,0,1-1.53-1.35L1.45,11h21.1ZM22.65,10H1.35L1,6.65a1.46,1.46,0,0,1,.38-1.14A1.55,1.55,0,0,1,2.54,5H21.46a1.55,1.55,0,0,1,1.15.51A1.46,1.46,0,0,1,23,6.65Zm-6.91,7a.5.5,0,0,0-.41.58l.35,2a.5.5,0,0,0,.49.41h.09a.5.5,0,0,0,.41-.58l-.35-2A.5.5,0,0,0,15.74,17Zm4.39.37a.5.5,0,1,0-.94.34l.68,1.88a.5.5,0,0,0,.94-.34Z"/></svg>
                          @elseif($f->name == "Parkir")
                          <svg xmlns="http://www.w3.org/2000/svg" class="col-12" width="20" height="24" viewBox="0 0 24 24"><path fill="none" d="M0 0h24v24H0V0z"/><path d="M12.79 3H8c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2s2-.9 2-2v-4h3c3.57 0 6.42-3.13 5.95-6.79C18.56 5.19 15.84 3 12.79 3zm.41 8H10V7h3.2c1.1 0 2 .9 2 2s-.9 2-2 2z"/></svg>
                          @else
                          <i class="{{$f->icon}} col-12" aria-hidden="true"></i>
                          @endif
                            <span>{{$f->name}}</span>
                        </button>
                      @endforeach
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
<div class="modal fade" id="editFacility" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
          <div class="modal-header">
              <h4 class="modal-title" id="myCenterModalLabel">Tambah Fasilitas</h4>
              <button type="button" class="close" data-dismiss="modal"
                  aria-hidden="true">×</button>
          </div>
          <form action="" id="updateFacilityForm" method="post">
            @csrf
            <div class="modal-body">
                <div class="row">
                  <div class="form-group col-md-12">
                    <input type="hidden" name="icon" id="iconFacilityEdit">
                    <input type="hidden" name="mobileIcon" id="mobileIconFacilityEdit">
                    <input type="text" class="form-control" placeholder="Nama Fasilitas" name="name" id="editNameFacility" required readonly>
                  </div>
                  
                  <div class="col-md-12 row form-group mx-auto">
                    @foreach(json_decode($facilities) as $i => $f)
                      <button type="button" class="col-md-2 m-1 p-1 btn btn-light" onclick="changeEditFacility('{{$f->name}}','{{$f->icon}}', '{{$f->mobileIcon}}')">
                          @if($f->name == "Sarapan")
                          <svg xmlns="http://www.w3.org/2000/svg" class="col-12" width="20" height="20" viewBox="0 0 48 48"><path d="M31 48a1 1 0 0 1-1-1V1a1 1 0 1 1 2 0v46a1 1 0 0 1-1 1z"/><path d="M37 31h-6a1 1 0 110-2h4.996c-.133-16.802-3.585-26.66-5.014-27.002a.991.991 0 01-.991-.999C29.991.447 30.447 0 31 0c4.188 0 7 15.512 7 30a1 1 0 01-1 1zM17 18c-3.859 0-7-3.141-7-7V1a1 1 0 112 0v10c0 2.757 2.243 5 5 5s5-2.243 5-5V1a1 1 0 112 0v10c0 3.859-3.141 7-7 7z"/><path d="M17 48a1 1 0 0 1-1-1V1a1 1 0 1 1 2 0v46a1 1 0 0 1-1 1z"/></svg>
                          @elseif($f->name == "AC")
                          <svg xmlns="http://www.w3.org/2000/svg" class="col-12" height="20" data-name="Layer 1" viewBox="0 0 24 24"><path d="M12,17a.5.5,0,0,0-.5.5v2a.5.5,0,0,0,1,0v-2A.5.5,0,0,0,12,17ZM8.26,17a.5.5,0,0,0-.58.41l-.35,2a.5.5,0,0,0,.41.58h.09a.5.5,0,0,0,.49-.41l.35-2A.5.5,0,0,0,8.26,17Zm-3.75.07a.5.5,0,0,0-.64.3l-.68,1.88a.5.5,0,1,0,.94.34l.68-1.88A.5.5,0,0,0,4.51,17.09ZM13.5,8h-3a.5.5,0,0,0,0,1h3a.5.5,0,0,0,0-1Zm9.86-3.16A2.55,2.55,0,0,0,21.46,4H2.54a2.55,2.55,0,0,0-1.89.84A2.48,2.48,0,0,0,0,6.75l.61,6A2.52,2.52,0,0,0,3.15,15h.62l.15,0,.14,0H20.85a2.52,2.52,0,0,0,2.52-2.25l.61-6A2.48,2.48,0,0,0,23.36,4.84ZM4.39,14a1.15,1.15,0,0,1,1.15-1H18.46a1.14,1.14,0,0,1,1.14,1Zm18-1.35A1.52,1.52,0,0,1,20.85,14h-.23a2.15,2.15,0,0,0-2.15-2H5.54a2.16,2.16,0,0,0-1.68.79A2.12,2.12,0,0,0,3.39,14H3.15a1.52,1.52,0,0,1-1.53-1.35L1.45,11h21.1ZM22.65,10H1.35L1,6.65a1.46,1.46,0,0,1,.38-1.14A1.55,1.55,0,0,1,2.54,5H21.46a1.55,1.55,0,0,1,1.15.51A1.46,1.46,0,0,1,23,6.65Zm-6.91,7a.5.5,0,0,0-.41.58l.35,2a.5.5,0,0,0,.49.41h.09a.5.5,0,0,0,.41-.58l-.35-2A.5.5,0,0,0,15.74,17Zm4.39.37a.5.5,0,1,0-.94.34l.68,1.88a.5.5,0,0,0,.94-.34Z"/></svg>
                          @elseif($f->name == "Parkir")
                          <svg xmlns="http://www.w3.org/2000/svg" class="col-12" width="20" height="24" viewBox="0 0 24 24"><path fill="none" d="M0 0h24v24H0V0z"/><path d="M12.79 3H8c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2s2-.9 2-2v-4h3c3.57 0 6.42-3.13 5.95-6.79C18.56 5.19 15.84 3 12.79 3zm.41 8H10V7h3.2c1.1 0 2 .9 2 2s-.9 2-2 2z"/></svg>
                          @else
                          <i class="{{$f->icon}} col-12" aria-hidden="true"></i>
                          @endif
                            <span>{{$f->name}}</span>
                      </button>
                    @endforeach
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
<div class="modal fade" id="deleteFacility" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
          <div class="modal-header">
              <h4 class="modal-title" id="myCenterModalLabel">Hapus Fasilitas</h4>
              <button type="button" class="close" data-dismiss="modal"
                  aria-hidden="true">×</button>
          </div>
          <form action="" id="deleteFacilityForm" method="POST">
            @csrf
          <div class="p-3">
          Yakin ingin menhapus fasilitas <span id="facilityWillDelete"></span> ?
          </div>
          <div class="row col-md-12 mx-auto">
          <div class="form-group col-md-6">
              <button type="submit" class="btn btn-primary btn-block"  data-dismiss="modal" aria-hidden="true">Tidak</button>
            </div>
            <div class="form-group col-md-6">
              <button type="submit" class="btn btn-danger btn-block">Hapus</button>
            </div>
          </div>
      </form>
      </div>
  </div>
</div>
<script>
  function changeFacilitiesStore(name, icon, mobileIcon){
    document.querySelector('#iconFacility').value = icon
    document.querySelector('#nameFacilityInput').value = name
    document.querySelector('#mobileIcon').value = mobileIcon
  }

  function editFacility(id){
    fetch(`${window.location.pathname}/${id}`).then(res => res.json())
    .then(res => {
      document.querySelector("#editNameFacility").value = res.name
      document.querySelector("#updateFacilityForm").setAttribute('action', `${window.location.pathname}/update/${id}`)
    })
  }

  function changeEditFacility(name, icon, mobileIcon){
    document.querySelector("#editNameFacility").value = name
    document.querySelector('#mobileIconFacilityEdit').value = mobileIcon
    document.querySelector("#iconFacilityEdit").value = icon
  }

  function deleteFacility(name, id){
    document.querySelector('#facilityWillDelete').innerHTML = name
    console.log(name)
    document.querySelector('#deleteFacilityForm').setAttribute('action', `${window.location.pathname}/delete/${id}`)
  }
</script>
@endsection