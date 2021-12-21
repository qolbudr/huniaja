@extends('owner/master')

@section('title', 'HuniAja - Halaman Pemilik : Sewa')

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
                          <li class="breadcrumb-item"><a href="{{ URL::to('owner/dashboard') }}" class="text-muted">Dashboard</a></li>
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
                    <h4 class="card-title">Sewa</h4>
                    <h6 class="card-subtitle">Kelola Sewa property anda</h6>
                    <div class="my-4">
                      <select class="form-control" id="property">
                        @foreach($property as $data)
                        <option value="{{ $data->id }}">{{ $data->name }}</option>
                        @endforeach
                      </select>
                    </div>
                    <div class="table-responsive">
                        <table id="datatable" class="table table-striped table-bordered no-wrap">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Properti</th>
                                    <th>Penghuni</th>
                                    <th>Tenggat Pembayaran</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                              @foreach($bill as $k => $data)
                              <tr>
                                  <td>{{ $k + 1}}</td>
                                  <td>{{ $data->propertyName }}</td>
                                  <td>{{ $data->userName }}</td>
                                  <td>{{ $data->date }}</td>
                                  <td>{{ $data->status == 1 ? 'Lunas' : 'Belum Lunas' }}</td>
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
@endsection