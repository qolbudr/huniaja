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
                          <li class="breadcrumb-item"><a href="{{ URL::to('Admin/dashboard') }}" class="text-muted">Dashboard</a></li>
                          <li class="breadcrumb-item text-muted active" aria-current="page">Fasilitas</li>
                      </ol>
                  </nav>
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
                    </div>
                    <div class="table-responsive">
                        <table id="datatable" class="table table-striped table-bordered no-wrap">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Fasilitas</th>
                                    <th>Action</th>
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
                      <input type="text" class="form-control" placeholder="Nama Fasilitas" name="name" id="nameFacilityInput" required readonly>
                    </div>
                    
                    <div class="col-md-12 row form-group mx-auto">
                      @foreach(json_decode($facilities) as $i => $f)
                        <button type="button" class="col-md-2 m-1 p-1 btn btn-light" onclick="changeFacilitiesStore('{{$f->name}}','{{$f->icon}}')">
                          <i class="{{$f->icon}}" aria-hidden="true"></i>
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
                    <input type="text" class="form-control" placeholder="Nama Fasilitas" name="name" id="editNameFacility" required readonly>
                  </div>
                  
                  <div class="col-md-12 row form-group mx-auto">
                    @foreach(json_decode($facilities) as $i => $f)
                      <button type="button" class="col-md-2 m-1 p-1 btn btn-light" onclick="changeEditFacility('{{$f->name}}','{{$f->icon}}')">
                        <i class="{{$f->icon}}" aria-hidden="true"></i>
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
  function changeFacilitiesStore(name, icon){
    document.querySelector('#iconFacility').value = icon
    document.querySelector('#nameFacilityInput').value = name
  }

  function editFacility(id){
    fetch(`${window.location.pathname}/${id}`).then(res => res.json())
    .then(res => {
      document.querySelector("#editNameFacility").value = res.name
      document.querySelector("#updateFacilityForm").setAttribute('action', `${window.location.pathname}/update/${id}`)
    })
  }

  function changeEditFacility(name, icon){
    document.querySelector("#editNameFacility").value = name
    document.querySelector("#iconFacilityEdit").value = icon
  }

  function deleteFacility(name, id){
    document.querySelector('#facilityWillDelete').innerHTML = name
    console.log(name)
    document.querySelector('#deleteFacilityForm').setAttribute('action', `${window.location.pathname}/delete/${id}`)
  }
</script>
@endsection