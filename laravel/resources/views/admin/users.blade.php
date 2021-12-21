@extends('admin/master')

@section('title', 'HuniAja - Halaman Pemilik : Kelola Pengguna')

@section('content')
<div class="page-wrapper">
  <!-- ============================================================== -->
  <!-- Bread crumb and right sidebar toggle -->
  <!-- ============================================================== -->
  <div class="page-breadcrumb">
      <div class="row">
          <div class="col-7 align-self-center">
              <h4 class="page-title text-truncate text-dark font-weight-medium mb-1">Pengguna</h4>
              <div class="d-flex align-items-center">
                  <nav aria-label="breadcrumb">
                      <ol class="breadcrumb m-0 p-0">
                          <li class="breadcrumb-item"><a href="{{ URL::to('owner/dashboard') }}" class="text-muted">Dasbor</a></li>
                          <li class="breadcrumb-item text-muted active" aria-current="page">Pengguna</li>
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
                          <h4 class="card-title">Pengguna</h4>
                          <h6 class="card-subtitle">Kelola Pengguna property anda</h6>
                        </div>
                      </div>
                    </div>
                    <div class="table-responsive">
                        <table id="datatable" class="table table-striped table-bordered no-wrap">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Nama</th>
                                    <th>Email</th>
                                    <th>Nomor Telepon</th>
                                    <th>Tanggal Lahir</th>
                                    <th>Alamat</th>
                                    <th>Saldo</th>
                                    <th>Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                              @foreach($users as $i => $user)
                              <tr>
                                  <td>{{ $i + 1}}</td>
                                  <td>{{ $user->name }}</td>
                                  <td>{{ $user->email }}</td>
                                  <td>{{ $user->phone }}</td>
                                  <td>{{ $user->dob }}</td>
                                  <td>{{ $user->address }}</td>
                                  <td>{{ $user->balance | 0 }}</td>
                                  <td>
                                    <button class="btn btn-warning btn-circle btn-sm"  data-toggle="modal" data-target="#editUser" onclick="fetchUser({{$user->id}})"><i class="fa fa-edit"></i></button>
                                    <button class="btn btn-danger btn-circle btn-sm" data-toggle="modal" data-target="#deleteUser" onclick="clickDelete({{$user->id}})"><i class="fa fa-trash"></i></button>
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
<div class="modal fade" id="editUser" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myCenterModalLabel">Perbarui Pengguna</h4>
                <button type="button" class="close" data-dismiss="modal"
                    aria-hidden="true">×</button>
            </div>
            <form id="updateUserForm" action="" method="post">
              @csrf
              <div class="modal-body">
                  <div class="row">
                    <div class="form-group col-md-12">
                      <input type="text" id="namaUpdateUser" class="form-control" placeholder="Nama" name="name" required>
                    </div>
                    <div class="form-group col-md-12">
                        <input type="date" id="newDOB" class="form-control" placeholder="Tanggal Lahir" name="dob" required>
                      </div>
                    <div class="form-group col-md-12">
                        <input type="text" id="emailUpdateUser" class="form-control" placeholder="Email" name="email" required>
                      </div>
                      <div class="form-group col-md-12">
                        <input type="number" id="numberUpdate" class="form-control" placeholder="Nomor Telepon" name="telepon" required>
                      </div>
                      <div class="form-group col-md-12">
                        <input type="number" id="balanceUpdate" class="form-control" placeholder="balance" name="balance" required>
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
<div class="modal fade" id="deleteUser" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myCenterModalLabel">Hapus Pengguna</h4>
                <button type="button" class="close" data-dismiss="modal"
                    aria-hidden="true">×</button>
            </div>
            <form action="" id="deleteUserForm" method="POST">
              @csrf
                <input type="hidden" name="idDelete" id="userIdDelete">
            <div class="p-3">
            Yakin Pengguna ingin dihapus ?
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
    let form = document.querySelector("#updateUserForm")
    let newName = document.querySelector("#namaUpdateUser")
    let dob = document.querySelector("#newDOB")
    let email = document.querySelector("#emailUpdateUser")
    let number = document.querySelector("#numberUpdate")
    let balance = document.querySelector("#balanceUpdate")
    function fetchUser(userid){
        fetch(`${window.location.pathname}/${userid}`).then(res => res.json())
        .then(res => {
            form.setAttribute("action", `${window.location.pathname}/update/${userid}`)
            newName.value = res.name
            email.value = res.email
            number.value = res.phone
            balance.value = res.balance | 0
        })
    }
    function clickDelete(userid){
        document.querySelector("#deleteUserForm").setAttribute("action",  `${window.location.pathname}/delete/${userid}`)
    }
</script>

@endsection