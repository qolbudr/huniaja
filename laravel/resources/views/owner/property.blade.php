@extends('owner/master')

@section('title', 'HuniAja - Halaman Pemilik : Properti')

@section('content')
<div class="page-wrapper">
  <!-- ============================================================== -->
  <!-- Bread crumb and right sidebar toggle -->
  <!-- ============================================================== -->
  <div class="page-breadcrumb">
      <div class="row">
          <div class="col-7 align-self-center">
              <h4 class="page-title text-truncate text-dark font-weight-medium mb-1">Properti</h4>
              <div class="d-flex align-items-center">
                  <nav aria-label="breadcrumb">
                      <ol class="breadcrumb m-0 p-0">
                          <li class="breadcrumb-item"><a href="{{ URL::to('owner/dashboard') }}" class="text-muted">Dashboard</a></li>
                          <li class="breadcrumb-item text-muted active" aria-current="page">Properti</li>
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
                          <h4 class="card-title">Properti</h4>
                          <h6 class="card-subtitle">Kelola properti property anda</h6>
                        </div>
                      </div>
                      <div class="col-md-6 my-2 text-lg-right">
                        <button class="btn btn-primary" data-toggle="modal" data-target="#addProperty">Tambah Properti</button>
                      </div>
                    </div>
                    <div class="table-responsive">
                        <table id="datatable" class="table table-striped table-bordered no-wrap">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Nama</th>
                                    <th>Harga Harian</th>
                                    <th>Harga Bulanan</th>
                                    <th>Harga Tahunan</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                              @foreach($data['property'] as $k => $data)
                              <tr>
                                  <td>{{ $k + 1}}</td>
                                  <td>{{ $data->name }}</td>
                                  <td>{{ number_format($data->price_day, 0, ',', '.') }}</td>
                                  <td>{{ number_format($data->price_month, 0, ',', '.') }}</td>
                                  <td>{{ number_format($data->price_year, 0, ',', '.') }}</td>
                                  <td>
                                    <button class="btn btn-primary btn-circle btn-sm"><i class="fa fa-image"></i></button>
                                    <button class="btn btn-success btn-circle btn-sm" data-toggle="modal" data-target="#facilityDialog" onclick="editFacility({{$data->id}})"><i class="fa fa-bed"></i></button>
                                    <button class="btn btn-warning btn-circle btn-sm" data-toggle="modal" data-target="#EditProperty" onclick="editProperty({{$data->id}})"><i class="fa fa-edit"></i></button>
                                    <button class="btn btn-danger btn-circle btn-sm" data-toggle="modal" data-target="#deletePropertyModal" onclick="deleteProperty({{$data->id}}, '{{$data->name}}')"><i class="fa fa-trash"></i></button>
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
<div class="modal fade" id="addProperty" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myCenterModalLabel">Tambah Property</h4>
                <button type="button" class="close" data-dismiss="modal"
                    aria-hidden="true">×</button>
            </div>
            <form action="{{ URL::to('owner/property/insert') }}" method="post">
              @csrf
              <div class="modal-body">
                  <div class="row">
                    <div class="form-group col-md-12">
                      <input type="text" class="form-control" placeholder="Nama Properti" name="name" required>
                    </div>
                    <div class="form-group col-md-12">
                      <textarea type="text" class="form-control" placeholder="Deskripsi" name="description" rows="5" required></textarea>
                    </div>
                    <div class="form-group col-md-12">
                      <div class="d-flex position-relative">
                        <input type="text" class="form-control search-property" placeholder="Alamat" name="address" required>
                        <input type="hidden" name="latitude" value="-7.96662" required>
                        <input type="hidden" name="longitude" value="112.633" required>
                        <div class="place-result bg-white position-absolute">
                        </div>
                      </div>
                    </div>
                    <div class="form-group col-12">
                      <input type="text" class="form-control" placeholder="Virtual Room" name="vrooms">
                    </div>
                    <div class="form-group col-md-6">
                      <input type="number" class="form-control" placeholder="Harga (Harian)" name="price_day" required>
                    </div>
                    <div class="form-group col-md-6">
                      <input type="number" class="form-control" placeholder="Harga (Bulanan)" name="price_month" required>
                    </div>
                    <div class="form-group col-12">
                      <input type="number" class="form-control" placeholder="Harga (Tahunan)" name="price_year" required>
                    </div>
                    <div class="form-group col-md-12" required>
                      <select class="form-control" name="type">
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
<div class="modal fade" id="facilityDialog" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
          <div class="modal-header">
              <h4 class="modal-title" id="myCenterModalLabel">Tambah Fasilitas</h4>
              <button type="button" class="close" data-dismiss="modal"
                  aria-hidden="true">×</button>
          </div>
          <form action="" id="updateFacilityForm" method="post">
            <input type="hidden" id="csrfToken" value="{{csrf_token()}}">
            <div class="modal-body">
                <div class="row">
                  <div class="form-group col-md-12">
                  
                  <div class="col-md-12 row form-group mx-auto">
                    @foreach($facilities as $i => $f)
                    <div class="form-check col-md-4 col-6">
                      <input class="form-check-input" type="checkbox" onclick="triggerFacility({{$f->id}})" value="" id="facility-{{$f->id}}">
                      <label class="form-check-label" for="flexCheckDefault">
                        <span> <i class="{{$f->webIcon}}" aria-hidden="true"></i> {{$f->name}}</span>
                      </label>
                    </div>
                    @endforeach
                  </div>
                </div>
            </div>
          </form>
      </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div>


<script>
  let currentPropertyId = null
  function editFacility(propertyId){
    currentPropertyId = propertyId
    fetch(`${window.location.pathname}/${propertyId}/facility`).then(res => res.json())
    .then(res => {
      res.facilitiesProperty.map(facility => {
        document.querySelector(`#facility-${facility.facilityId}`).setAttribute('checked', 'true')
      })
    })
  }

  function deleteProperty(propertyId, propertyName){
    document.querySelector('#deleteProperty').setAttribute('action', `${window.location.pathname}/delete/${propertyId}`)
    document.querySelector('#propertyNameDelete').innerHTML = propertyName
  }

  function editProperty(propertyId){
    document.querySelector('#updateForm').setAttribute('action', `${window.location.pathname}/update/${propertyId}`)
    let name = document.querySelector('#editName')
    let description = document.querySelector('#editDeskripsi')
    let address = document.querySelector('#editAddress')
    let vroom = document.querySelector('#editVrooms')
    let priceDay = document.querySelector('#editPriceDay')
    let priceMonth = document.querySelector('#editPriceMonth')
    let priceYear = document.querySelector('#editPriceYear')
    let type = document.querySelector('#editType')
    fetch(`${window.location.pathname}/${propertyId}`)
    .then(res => res.json())
    .then(res => {
      name.value = res.name
      description.value = res.description
      address.value = res.address
      vroom.value = res.vrooms
      priceDay.value = res.price_day
      priceMonth.value = res.price_month
      priceYear.value = res.price_year
      type.value = res.type
    })  
  }

  function triggerFacility(facilityId){
    let dataBody = {
      facilityId
    }
    let header = {
      'X-CSRF-TOKEN': document.querySelector('#csrfToken').value,
      'content-type': "application/json",
    }
    fetch(`${window.location.pathname}/update/${currentPropertyId}/facility`,{
      method: "POST",
      body: JSON.stringify(dataBody),
      headers: header
    }).then(res => res.json())
  }
</script>
@endsection