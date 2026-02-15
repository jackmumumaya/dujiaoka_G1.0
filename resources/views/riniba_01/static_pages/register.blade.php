@extends('riniba_01.layouts.default')

@section('content')
    <section class="section" style="min-height: 80vh; display: flex; justify-content: center; align-items: center;">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-5 col-md-8">
                    <div class="card shadow-sm" style="border-radius: 12px;">
                        <div class="card-body p-4">
                            <div class="text-center mb-4">
                                <h4 class="fw-bold">注册</h4>
                                <p class="text-muted">免费注册一个新账号。</p>
                            </div>

                            <form method="POST" action="{{ route('register') }}">
                                @csrf

                                <div class="mb-3">
                                    <label for="name" class="form-label">姓名</label>
                                    <input class="form-control @error('name') is-invalid @enderror" type="text" id="name"
                                        name="name" value="{{ old('name') }}" required autocomplete="name" autofocus
                                        placeholder="输入您的姓名">
                                    @error('name')
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{ $message }}</strong>
                                        </span>
                                    @enderror
                                </div>

                                <div class="mb-3">
                                    <label for="email" class="form-label">邮箱</label>
                                    <input class="form-control @error('email') is-invalid @enderror" type="email" id="email"
                                        name="email" value="{{ old('email') }}" required autocomplete="email"
                                        placeholder="输入您的邮箱">
                                    @error('email')
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{ $message }}</strong>
                                        </span>
                                    @enderror
                                </div>

                                <div class="mb-3">
                                    <label for="password" class="form-label">密码</label>
                                    <input class="form-control @error('password') is-invalid @enderror" type="password"
                                        id="password" name="password" required autocomplete="new-password"
                                        placeholder="输入您的密码（至少8位）">
                                    @error('password')
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{ $message }}</strong>
                                        </span>
                                    @enderror
                                </div>

                                <div class="mb-3">
                                    <label for="password-confirm" class="form-label">确认密码</label>
                                    <input class="form-control" type="password" id="password-confirm"
                                        name="password_confirmation" required autocomplete="new-password"
                                        placeholder="再次输入密码">
                                </div>

                                <div class="d-grid mb-0 text-center">
                                    <button class="btn btn-primary" type="submit"> 注册 </button>
                                </div>
                            </form>

                            <div class="text-center mt-3">
                                <p class="text-muted">已经有账号了？ <a href="{{ route('login') }}"><b>登录</b></a></p>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
@endsection