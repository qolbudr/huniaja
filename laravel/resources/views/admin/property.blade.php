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
              <h4 class="page-title text-truncate text-dark font-weight-medium mb-1">Property</h4>
              <div class="d-flex align-items-center">
                  <nav aria-label="breadcrumb">
                      <ol class="breadcrumb m-0 p-0">
                          <li class="breadcrumb-item"><a href="{{ URL::to('Admin/dashboard') }}" class="text-muted">Dashboard</a></li>
                          <li class="breadcrumb-item text-muted active" aria-current="page">Property</li>
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
                          <h6 class="card-subtitle">Kelola Property</h6>
                        </div>
                      </div>
                    </div>
                    <div class="table-responsive">
                        <table id="datatable" class="table table-striped table-bordered no-wrap">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Property</th>
                                    <th>Pemilik</th>
                                    <th>Harga harian</th>
                                    <th>Harga bulanan</th>
                                    <th>Harga Tahunan</th>
                                    <th>Bukti Kepemilikan</th>
                                    <th colspan="2" class="text-center">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                              @foreach($properties as $i => $p)
                              <tr>
                                  <td>{{ $i + 1}}</td>
                                  <td>{{ $p->name }}</td>
                                  <td>{{ $p->owner }}</td>
                                  <td>{{ $p->price_day}}</td>
                                  <td>{{ $p->price_month}}</td>
                                  <td>{{ $p->price_month}}</td>
                                  <td><a href="{{asset(str_replace(' ', '-', 'ownership/' . $p->id . '-' . strtolower($p->name) . '/' . $p->ownership_proof))}}" target="_blank" class="btn btn-primary">Lihat Bukti Kepemilikan</a></td>
                                  <td>
                                    <button class="btn btn-danger btn-circle btn-sm" data-toggle="modal" data-target="#deletePropertyModal" onclick="deleteProperty({{$p->id}},'{{$p->name}}','{{$p->owner}}')"><i class="fa fa-trash"></i></button>
                                  </td>
                                  <td>
                                    <a role="button" class="btn btn-primary btn-circle btn-sm" href="{{ URL::to('detail/'.$p->id.'/'.str_replace(' ', '-', strtolower($p->name))) }}" target="_blank"><i class="fa fa-eye"></i></a>
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
<div class="modal fade" id="deletePropertyModal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
          <div class="modal-header">
              <h4 class="modal-title" id="myCenterModalLabel">Hapus Fasilitas</h4>
              <button type="button" class="close" data-dismiss="modal"
                  aria-hidden="true">×</button>
          </div>
          <form action="" id="deleteProperty" method="POST">
            @csrf
          <div class="p-3">
          Yakin ingin menghapus property <span id="propertyName"></span> dengan owner <span id="deleteOwner"></span> ?
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
  function deleteProperty(id, name, owner){
    document.querySelector('#deleteProperty').setAttribute('action', `${window.location.pathname}/delete/${id}`)
    document.querySelector("#propertyName").innerHTML = name
    document.querySelector('#deleteOwner').innerHTML = owner
  }
</script>
@endsection