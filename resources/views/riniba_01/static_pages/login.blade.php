@extends('riniba_01.layouts.default')

@section('content')
    <section class="section" style="min-height: 80vh; display: flex; justify-content: center; align-items: center;">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-5 col-md-8">
                    <div class="card shadow-sm" style="border-radius: 12px;">
                        <div class="card-body p-4">
                            <div class="text-center mb-4">
                                <h4 class="fw-bold">登录</h4>
                                <p class="text-muted">请输入您的邮箱和密码来访问。</p>
                            </div>

                            @if(session('success'))
                                <div class="alert alert-success">{{ session('success') }}</div>
                            @endif

                            <form method="POST" action="{{ route('login') }}">
                                @csrf

                                <div class="mb-3">
                                    <label for="email" class="form-label">邮箱</label>
                                    <input class="form-control @error('email') is-invalid @enderror" type="email" id="email"
                                        name="email" value="{{ old('email') }}" required autocomplete="email" autofocus
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
                                        id="password" name="password" required autocomplete="current-password"
                                        placeholder="输入您的密码">
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
                                <p class="text-muted">还没有账号？ <a href="{{ route('register') }}"><b>注册</b></a></p>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
@endsection