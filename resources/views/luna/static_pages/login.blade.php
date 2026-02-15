@extends('luna.layouts.default')

@section('notice')
@endsection

@section('notice_min')
@endsection

@section('content')

    <body>
        @include('luna.layouts._nav')

        <div class="main">
            <div class="layui-row">
                <div class="layui-col-md6 layui-col-md-offset3 layui-col-sm12">
                    <div class="main-box" style="margin-top: 50px;">
                        <div class="title">
                            <span>登录</span>
                        </div>
                        <div style="padding: 20px;">
                            @if(session('success'))
                                <div
                                    style="background-color: #d4edda; color: #155724; padding: 10px; border-radius: 4px; margin-bottom: 15px;">
                                    {{ session('success') }}</div>
                            @endif

                            <form method="POST" action="{{ route('login') }}">
                                @csrf

                                <div style="margin-bottom: 15px;">
                                    <label style="display: block; margin-bottom: 5px; font-weight: bold;">邮箱</label>
                                    <input type="email" name="email" value="{{ old('email') }}" required
                                        autocomplete="email" autofocus placeholder="输入您的邮箱"
                                        style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box;">
                                    @error('email')
                                        <span style="color: #dc3545; font-size: 12px;">{{ $message }}</span>
                                    @enderror
                                </div>

                                <div style="margin-bottom: 15px;">
                                    <label style="display: block; margin-bottom: 5px; font-weight: bold;">密码</label>
                                    <input type="password" name="password" required autocomplete="current-password"
                                        placeholder="输入您的密码"
                                        style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box;">
                                    @error('password')
                                        <span style="color: #dc3545; font-size: 12px;">{{ $message }}</span>
                                    @enderror
                                </div>

                                <div style="margin-bottom: 15px;">
                                    <label><input type="checkbox" name="remember"> 记住我</label>
                                </div>

                                <div style="text-align: center;">
                                    <button type="submit"
                                        style="width: 100%; padding: 10px; background: linear-gradient(135deg, #3C8CE7, #00EAFF); color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 16px;">登录</button>
                                </div>
                            </form>

                            <div style="text-align: center; margin-top: 15px;">
                                <span style="color: #999;">还没有账号？</span> <a href="{{ route('register') }}"
                                    style="color: #3C8CE7; font-weight: bold;">注册</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        @include('luna.layouts._footer')
    </body>
@endsection