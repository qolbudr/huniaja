@extends('admin/master')

@section('title', 'HuniAja - Halaman Admin : Dashboard')

@section('content')
<div class="page-wrapper">
  <!-- ============================================================== -->
  <!-- Bread crumb and right sidebar toggle -->
  <!-- ============================================================== -->
  <div class="page-breadcrumb">
      <div class="row">
          <div class="col-12 align-self-center">
              <h3 class="page-title text-truncate text-dark font-weight-medium mb-1">Halo Your Name</h3>
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
        <div class="card">
            <div class="card-body">
                <div class="d-flex d-lg-flex d-md-block align-items-center">
                    <div>
                        <h2 class="text-dark mb-1 font-weight-medium">{{ $countUser}}</h2>
                        <h6 class="text-muted font-weight-normal mb-0 w-100 text-truncate">Jumlah User</h6>
                    </div>
                    <div class="ml-auto mt-md-3 mt-lg-0">
                        <span class="opacity-7 text-muted"><i data-feather="users"></i></span>
                    </div>
                </div>
            </div>
        </div>
          <div class="card border-right">
              <div class="card-body">
                  <div class="d-flex d-lg-flex d-md-block align-items-center">
                      <div>
                          <div class="d-inline-flex align-items-center">
                              <h2 class="text-dark mb-1 font-weight-medium">{{$countProperty}}</h2>
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
                          <h2 class="text-dark mb-1 w-100 text-truncate font-weight-medium">100</h2>
                          <h6 class="text-muted font-weight-normal mb-0 w-100 text-truncate">Jumlah Penarikan
                          </h6>
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
                    <h6 class="card-subtitle">Kelola Sewa property anda</h6>

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