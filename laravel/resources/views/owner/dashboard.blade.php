@extends('owner/master')

@section('title', 'HuniAja - Halaman Pemilik : Dashboard')

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
                          <li class="breadcrumb-item"><a href="index.html">Dashboard</a>
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
                              <h2 class="text-dark mb-1 font-weight-medium">1538</h2>
                              <span
                                  class="badge bg-danger font-12 text-white font-weight-medium badge-pill ml-2 d-md-none d-lg-block">-18.33%</span>
                          </div>
                          <h6 class="text-muted font-weight-normal mb-0 w-100 text-truncate">New Projects</h6>
                      </div>
                      <div class="ml-auto mt-md-3 mt-lg-0">
                          <span class="opacity-7 text-muted"><i data-feather="file-plus"></i></span>
                      </div>
                  </div>
              </div>
          </div>
          <div class="card">
              <div class="card-body">
                  <div class="d-flex d-lg-flex d-md-block align-items-center">
                      <div>
                          <h2 class="text-dark mb-1 font-weight-medium">864</h2>
                          <h6 class="text-muted font-weight-normal mb-0 w-100 text-truncate">Projects</h6>
                      </div>
                      <div class="ml-auto mt-md-3 mt-lg-0">
                          <span class="opacity-7 text-muted"><i data-feather="globe"></i></span>
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
                    <h6 class="card-subtitle">Kelola Sewa property anda</h6>
                    <div class="table-responsive">
                        <table id="datatable" class="table table-striped table-bordered no-wrap">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Properti</th>
                                    <th>Tanggal</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                              @foreach($booking as $k => $data)
                              <tr>
                                  <td>{{ $k + 1}}</td>
                                  <td>{{ $data->name }}</td>
                                  <td>{{ $data->date }}</td>
                                  <td>
                                    <button data-id="{{ $data->userId }}" class="btn btn-primary btn-circle btn-sm viewUser"><i class="fa fa-user"></i></button>
                                    <button class="btn btn-success btn-circle btn-sm"><i class="fa fa-check"></i></button>
                                    <button class="btn btn-danger btn-circle btn-sm"><i class="fa fa-times"></i></button>
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
@endsection