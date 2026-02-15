@extends('riniba_04.layouts.default')

@section('content')
<div class="container d-flex justify-content-center align-items-center" style="min-height: 80vh;">
    <div class="col-md-6 col-lg-5">
        <div class="card">
            <div class="card-body p-4">
                <div class="text-center w-75 m-auto">
                    <h4 class="text-dark-50 text-center mt-0 fw-bold">登录</h4>
                    <p class="text-muted mb-4">请输入您的邮箱和密码来访问。</p>
                </div>

                <form method="POST" action="{{ route('login') }}">
                    @csrf

                    <div class="mb-3">
                        <label for="emailaddress" class="form-label">邮箱</label>
                        <input class="form-control @error('email') is-invalid @enderror" type="email" id="emailaddress" name="email" value="{{ old('email') }}" required autocomplete="email" autofocus placeholder="输入您的邮箱">
                        @error('email')
                            <span class="invalid-feedback" role="alert">
                                <strong>{{ $message }}</strong>
                            </span>
                        @enderror
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label">密码</label>
                        <div class="input-group input-group-merge">
                            <input class="form-control @error('password') is-invalid @enderror" type="password" id="password" name="password" required autocomplete="current-password" placeholder="输入您的密码">
                            <div class="input-group-text" data-password="false">
                                <span class="password-eye"></span>
                            </div>
                        </div>
                        @error('password')
                            <span class="invalid-feedback" role="alert">
                                <strong>{{ $message }}</strong>
                            </span>
                        @enderror
                    </div>

                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="remember" name="remember">
                        <label class="form-check-label" for="remember">记住我</label>
                    </div>

                    <div class="d-grid mb-0 text-center">
                        <button class="btn btn-primary" type="submit"> 登录 </button>
                    </div>
                </form>

                <div class="text-center mt-3">
                    <p class="text-muted">还没有账号？ <a href="{{ route('register') }}" class="text-muted ms-1"><b>注册</b></a></p>
                </div>

            </div> <!-- end card-body -->
        </div>
        <!-- end card -->
    </div> <!-- end col -->
</div>
@endsection