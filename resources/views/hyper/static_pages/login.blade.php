@extends('hyper.layouts.default')

@section('content')
    <div class="row justify-content-center" style="min-height: 70vh; align-items: center;">
        <div class="col-md-6 col-lg-5">
            <div class="card">
                <div class="card-body p-4">
                    <div class="text-center w-75 m-auto">
                        <h4 class="text-dark-50 text-center mt-0 font-weight-bold">登录</h4>
                        <p class="text-muted mb-4">请输入您的邮箱和密码来访问。</p>
                    </div>

                    @if(session('success'))
                        <div class="alert alert-success">{{ session('success') }}</div>
                    @endif

                    <form method="POST" action="{{ route('login') }}">
                        @csrf

                        <div class="form-group mb-3">
                            <label for="emailaddress">邮箱</label>
                            <input class="form-control @error('email') is-invalid @enderror" type="email" id="emailaddress"
                                name="email" value="{{ old('email') }}" required autocomplete="email" autofocus
                                placeholder="输入您的邮箱">
                            @error('email')
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{ $message }}</strong>
                                </span>
                            @enderror
                        </div>

                        <div class="form-group mb-3">
                            <label for="password">密码</label>
                            <div class="input-group input-group-merge">
                                <input class="form-control @error('password') is-invalid @enderror" type="password"
                                    id="password" name="password" required autocomplete="current-password"
                                    placeholder="输入您的密码">
                            </div>
                            @error('password')
                                <span class="invalid-feedback d-block" role="alert">
                                    <strong>{{ $message }}</strong>
                                </span>
                            @enderror
                        </div>

                        <div class="form-group mb-3">
                            <div class="custom-control custom-checkbox">
                                <input type="checkbox" class="custom-control-input" id="remember" name="remember">
                                <label class="custom-control-label" for="remember">记住我</label>
                            </div>
                        </div>

                        <div class="form-group mb-0 text-center">
                            <button class="btn btn-primary btn-block" type="submit"> 登录 </button>
                        </div>
                    </form>

                    <div class="text-center mt-3">
                        <p class="text-muted">还没有账号？ <a href="{{ route('register') }}" class="text-muted ml-1"><b>注册</b></a>
                        </p>
                    </div>

                </div>
            </div>
        </div>
    </div>
@endsection