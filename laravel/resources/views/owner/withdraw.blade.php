@extends('owner/master')

@section('title', 'HuniAja - Halaman Pemilik : Penarikan')

@section('content')

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
                          <li class="breadcrumb-item"><a href="{{ URL::to('owner/dashboard') }}" class="text-muted">Dashboard</a></li>
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
  
    <!-- ============================================================== -->
    <!-- Start Page Content -->
    <!-- ============================================================== -->
    <!-- basic table -->
    <div class="container-fluid">
        <div class="page-wrapper">
            <div class="card wallet-card no-margin mb-3 text-dark">
                <div class="p-4 d-flex align-items-center justify-content-between">
                  <div class="wallet-title">
                    <h3 class="font-weight-bold mb-2">Saldo</h3>
                    <p class="no-margin">Saldo e-wallet anda</p>
                  </div>
                  <div class="wallet-balance">
                    <h3>Rp. <span id="balance">{{number_format($balance, 0, ',', '.')}}</span></h3>
                  </div>
                </div>
              </div>
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <div class="row justify-content-between">
                        <div class="col-md-6 my-2">
                          <div class="title">
                            <h4 class="card-title">Penarikan</h4>
                            <h6 class="card-subtitle">Kelola Penarikan Anda</h6>
                          </div>
                        </div>
                        <div class="col-md-6 my-2 text-lg-right">
                          <button class="btn btn-primary" data-toggle="modal" data-target="#addWithDraw">Ajukan Penarikan</button>
                        </div>
                      </div>
                    <div class="table-responsive">
                        <table id="datatable" class="table table-striped table-bordered no-wrap">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Nominal</th>
                                    <th>Tanggal Pengajuan</th>
                                    <th>Status Penarikan</th>
                                </tr>
                            </thead>
                            <tbody>
                              @foreach($withdraws as $k => $data)
                              <tr>
                                  <td>{{ $k + 1}}</td>
                                  <td>{{ "Rp ". number_format($data->amount, 0, ',','.') }}</td>
                                  <td>{{ $data->created }}</td>
                                  <td>
                                      @if ($data->status == null)
                                          Pending
                                      @elseif($data->status == 1)
                                          Accepted
                                    @else
                                        Deny
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
</div>
<!-- ============================================================== -->
<!-- End Page wrapper  -->
<!-- ============================================================== -->
<div class="modal fade" id="addWithDraw" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myCenterModalLabel">Penarikan</h4>
                <button type="button" class="close" data-dismiss="modal"
                    aria-hidden="true">×</button>
            </div>
            <form action="{{ URL::to('/owner/withdraw') }}" method="post">
              @csrf
              <div class="modal-body">
                  <div class="row">
                    <div class="form-group col-md-12">
                        <label for="amount">Jumlah</label>
                      <input type="number" class="form-control" min="100000" placeholder="Nominal" id="amount" name="amount" oninput="countFinalBalance()" required>
                    </div>
                    <div class="form-group col-md-12">
                        <label for="final_balance">Saldo Akhir</label>
                        <input type="number" class="form-control" placeholder="Sisa Saldo" name="final_balance" id="final_balance" readonly>
                      </div>
                    <div class="form-group col-md-12">
                      <button type="submit" class="btn btn-primary btn-block">Ajukan</button>
                    </div>
                  </div>
              </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>
<script>
    let balance = parseInt('{{$balance}}')
    let amount = document.querySelector('#amount')
    let formWithdraw = document.querySelector('#withdrawForm')
    let finalBalance = document.querySelector('#final_balance')
    function countFinalBalance(){
        let intAmount = parseInt(amount.value)
        if(!intAmount){
            finalBalance.value = ""
        }
        if(balance < intAmount){
            finalBalance.value = "" 

            finalBalance.setAttribute('placeholder', "Tidak Dapat Melakukan Penarikan")
        }else{
             finalBalance.value = (balance - intAmount)
        }
    }

    function checkIsValidAmount(){
        let intAmount = parseInt(amount.value)

        if(balance < intAmount){
            return false;
        }
        return true
    }

</script>
@endsection