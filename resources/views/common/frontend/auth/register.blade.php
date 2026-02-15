@extends(dujiaoka_config_get('template', 'unicorn') . '.layouts.default')

@section('content')
    <div class="container" style="padding-top:50px; padding-bottom:50px;">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">用户注册</div>
                    <div class="card-body">
                        <form method="POST" action="{{ url('register') }}">
                            @csrf
                            <div class="form-group">
                                <label>昵称</label>
                                <input type="text" name="name" class="form-control" required value="{{ old('name') }}">
                            </div>
                            <div class="form-group">
                                <label>邮箱</label>
                                <input type="email" name="email" class="form-control" required value="{{ old('email') }}">
                            </div>
                            <div class="form-group">
                                <label>密码</label>
                                <input type="password" name="password" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>确认密码</label>
                                <input type="password" name="password_confirmation" class="form-control" required>
                            </div>
                            @if($errors->any())
                                <div class="alert alert-danger" style="margin-top:10px;">
                                    {{ $errors->first() }}
                                </div>
                            @endif
                            <div style="margin-top:20px;">
                                <button type="submit" class="btn btn-primary btn-block">注册</button>
                                <a href="{{ url('login') }}" class="btn btn-link btn-block">已有账号？去登录</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection