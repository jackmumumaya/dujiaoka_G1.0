@extends('hyper.layouts.default')

@section('content')
    <div class="row justify-content-center" style="min-height: 70vh; align-items: center;">
        <div class="col-md-6 col-lg-5">
            <div class="card">
                <div class="card-body p-4">
                    <div class="text-center w-75 m-auto">
                        <h4 class="text-dark-50 text-center mt-0 font-weight-bold">注册</h4>
                        <p class="text-muted mb-4">免费注册一个新账号。</p>
                    </div>

                    <form method="POST" action="{{ route('register') }}">
                        @csrf

                        <div class="form-group mb-3">
                            <label for="fullname">姓名</label>
                            <input class="form-control @error('name') is-invalid @enderror" type="text" id="fullname"
                                name="name" value="{{ old('name') }}" required autocomplete="name" autofocus
                                placeholder="输入您的姓名">
                            @error('name')
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{ $message }}</strong>
                                </span>
                            @enderror
                        </div>

                        <div class="form-group mb-3">
                            <label for="emailaddress">邮箱</label>
                            <input class="form-control @error('email') is-invalid @enderror" type="email" id="emailaddress"
                                name="email" value="{{ old('email') }}" required autocomplete="email" placeholder="输入您的邮箱">
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
                                    id="password" name="password" required autocomplete="new-password"
                                    placeholder="输入您的密码（至少8位）">
                            </div>
                            @error('password')
                                <span class="invalid-feedback d-block" role="alert">
                                    <strong>{{ $message }}</strong>
                                </span>
                            @enderror
                        </div>

                        <div class="form-group mb-3">
                            <label for="password-confirm">确认密码</label>
                            <div class="input-group input-group-merge">
                                <input class="form-control" type="password" id="password-confirm"
                                    name="password_confirmation" required autocomplete="new-password" placeholder="再次输入密码">
                            </div>
                        </div>

                        <div class="form-group mb-0 text-center">
                            <button class="btn btn-primary btn-block" type="submit"> 注册 </button>
                        </div>
                    </form>

                    <div class="text-center mt-3">
                        <p class="text-muted">已经有账号了？ <a href="{{ route('login') }}" class="text-muted ml-1"><b>登录</b></a>
                        </p>
                    </div>

                </div>
            </div>
        </div>
    </div>
@endsection