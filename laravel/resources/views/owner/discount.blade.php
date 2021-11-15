@extends('owner/master')

@section('title', 'HuniAja - Halaman Pemilik : Diskon')

@section('content')
<div class="page-wrapper">
  <!-- ============================================================== -->
  <!-- Bread crumb and right sidebar toggle -->
  <!-- ============================================================== -->
  <div class="page-breadcrumb">
      <div class="row">
          <div class="col-7 align-self-center">
              <h4 class="page-title text-truncate text-dark font-weight-medium mb-1">Diskon</h4>
              <div class="d-flex align-items-center">
                  <nav aria-label="breadcrumb">
                      <ol class="breadcrumb m-0 p-0">
                          <li class="breadcrumb-item"><a href="{{ URL::to('owner/dashboard') }}" class="text-muted">Dashboard</a></li>
                          <li class="breadcrumb-item text-muted active" aria-current="page">Diskon</li>
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
                          <h4 class="card-title">Diskon</h4>
                          <h6 class="card-subtitle">Kelola kode diskon properti</h6>
                        </div>
                      </div>
                      <div class="col-md-6 my-2 text-lg-right">
                        <button class="btn btn-primary" data-toggle="modal" data-target="#addDiscount">Tambah Diskon</button>
                      </div>
                    </div>
                    <div class="table-responsive">
                        <table id="datatable" class="table table-striped table-bordered no-wrap">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Properti</th>
                                    <th>Nominal</th>
                                    <th>Satuan</th>
                                    <th>Kode</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                              @foreach($discount as $k => $data)
                              <tr>
                                  <td>{{ $k + 1}}</td>
                                  <td>{{ $data->name }}</td>
                                  <td>{{ $data->percent ?? $data->value }}</td>
                                  <td>{{ $data->percent == null ? 'Rupiah' : 'Persen' }}</td>
                                  <td>{{ $data->code }}</td>
                                  <td>
                                    <a href="{{ URL::to('owner/discount/delete/'.$data->id) }}" class="btn btn-danger btn-circle btn-sm"><i class="fa fa-trash"></i></a>
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

<!-- Center modal content -->
<div class="modal fade" id="addDiscount" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myCenterModalLabel">Tambah Diskon</h4>
                <button type="button" class="close" data-dismiss="modal"
                    aria-hidden="true">×</button>
            </div>
            <form action="{{ URL::to('owner/discount/insert') }}" method="post">
              @csrf
              <div class="modal-body">
                  <div class="row">
                    <div class="form-group col-md-12">
                      <label>Properti</label>
                      <select class="form-control" name="propertyId" required>
                        @foreach($property as $data) 
                          <option value="{{ $data->id }}">{{ $data->name }}</option>
                        @endforeach
                      </select>
                    </div>
                    <div class="form-group col-md-12" required>
                      <input type="number" class="form-control" name="nominal" placeholder="Nominal" required>
                    </div>
                    <div class="form-group col-md-12" required>
                      <select class="form-control" name="type">
                        <option value="percent">Persen</option>
                        <option value="rupiah">Rupiah</option>
                      </select>
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
<div class="modal fade" id="EditProperty" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
          <div class="modal-header">
              <h4 class="modal-title" id="myCenterModalLabel">Edit Property</h4>
              <button type="button" class="close" data-dismiss="modal"
                  aria-hidden="true">×</button>
          </div>
          <form action="" method="post" id="updateForm">
            @csrf
            <div class="modal-body">
                <div class="row">
                  <div class="form-group col-md-12">
                    <input type="text" class="form-control" placeholder="Nama Properti" name="name" id="editName" required>
                  </div>
                  <div class="form-group col-md-12">
                    <textarea type="text" class="form-control" placeholder="Deskripsi" id="editDeskripsi" name="description" rows="5" required></textarea>
                  </div>
                  <div class="form-group col-md-12">
                    <div class="d-flex position-relative">
                      <input type="text" class="form-control search-property" placeholder="Alamat" id="editAddress" name="address" required>
                      <input type="hidden" name="latitude" value="-7.96662" required>
                      <input type="hidden" name="longitude" value="112.633" required>
                      <div class="place-result bg-white position-absolute">
                      </div>
                    </div>
                  </div>
                  <div class="form-group col-12">
                    <input type="text" class="form-control" placeholder="Virtual Room" id="editVrooms" name="vrooms">
                  </div>
                  <div class="form-group col-md-6">
                    <input type="number" class="form-control" placeholder="Harga (Harian)" name="price_day" id="editPriceDay" required>
                  </div>
                  <div class="form-group col-md-6">
                    <input type="number" class="form-control" placeholder="Harga (Bulanan)" name="price_month" id="editPriceMonth" required>
                  </div>
                  <div class="form-group col-12">
                    <input type="number" class="form-control" placeholder="Harga (Tahunan)" name="price_year" id="editPriceYear" required>
                  </div>
                  <div class="form-group col-md-12" required>
                    <select class="form-control" id="editType" name="type">
                      <option value="0">Rumah</option>
                      <option value="1">Apartemen</option>
                      <option value="2">Kontrakan</option>
                    </select>
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
<div class="modal fade" id="deletePropertyModal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
          <div class="modal-header">
              <h4 class="modal-title" id="myCenterModalLabel">Hapus Property</h4>
              <button type="button" class="close" data-dismiss="modal"
                  aria-hidden="true">×</button>
          </div>
          <form action="" id="deleteProperty" method="GET">
            @csrf
          <div class="p-3">
          Yakin ingin menghapus property <span id="propertyNameDelete"></span> ?
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
<div class="modal fade" id="uploadImage" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
          <div class="modal-header">
              <h4 class="modal-title" id="myCenterModalLabel">Kelola Gambar</h4>
              <button type="button" class="close" data-dismiss="modal"
                  aria-hidden="true">×</button>
          </div>
          <form action="{{ URL::to('owner/property/upload')  }}" id="deleteProperty" method="POST">
            <div class="col-12" id="imagePlacer"></div>
            <input type="hidden" id="csrfTokenImage" value="{{csrf_token()}}">
          <div class="p-3">
            <input type="file" name="images" id="imageChooser" onchange="handleUploadImage()" class="form-control" id="">
          </div>
          <div class="row col-md-12 mx-auto">
          <div class="form-group col-md-12">
              <button type="button" class="btn btn-primary btn-block"  data-dismiss="modal" aria-hidden="true">Tutup</button>
            </div>
          </div>
      </form>
      </div>
  </div>
</div>
@endsection