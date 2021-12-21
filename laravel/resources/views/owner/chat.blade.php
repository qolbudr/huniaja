@extends('owner/master')

@section('title', 'HuniAja - Halaman Pemilik : Chat')

@section('content')
<div class="page-wrapper">
    <!-- ============================================================== -->
    <!-- Bread crumb and right sidebar toggle -->
    <!-- ============================================================== -->
    <div class="page-breadcrumb">
        <div class="row">
            <div class="col-12 align-self-center">
                <h4 class="page-title text-truncate text-dark font-weight-medium mb-1">Chat</h4>
                <div class="d-flex align-items-center">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb m-0 p-0">
                            <li class="breadcrumb-item text-muted active" aria-current="page">Properti</li>
                            <li class="breadcrumb-item text-muted" aria-current="page">Chat</li>
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
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="row no-gutters">
                        <div class="col-lg-4 col-xl-4 border-right">
                            <div class="scrollable position-relative" style="height: calc(100vh - 111px);">
                                <ul class="mailbox list-style-none">
                                </ul>
                            </div>
                        </div>
                        <div class="col-lg-8 col-xl-8" id="owner-chat-box" ownerId="{{ Auth::user()->id }}" ownerName="{{ Auth::user()->name }}">
                            <div class="chat-box position-relative" style="height: calc(100vh - 111px);">
                                <div class="d-flex align-items-center text-center" style="height: calc(100vh - 111px);">
                                    <div class="content w-100">
                                        <h1 class="font-weight-bold">
                                            <i class="fa fa-comments"></i>
                                        </h1>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body border-top p-3" id="chat-field">
                                <div class="row">
                                    <div class="col-9">
                                        <div class="input-field mt-0 mb-0">
                                            <input id="chat-send" placeholder="Type and enter"
                                                class="form-control border-0" type="text">
                                        </div>
                                    </div>
                                    <div class="col-3">
                                        <a class="btn-circle btn-lg btn-cyan float-right text-white"
                                            href="javascript:void(0)"><i class="fas fa-paper-plane"></i></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection