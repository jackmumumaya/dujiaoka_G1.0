<div class="header-navbar">
    <div class="container header-flex">
        <!-- LOGO -->
        <a href="/" class="topnav-logo" style="float: none;">
            <img src="{{ picture_ulr(dujiaoka_config_get('img_logo')) }}" height="36">
            <div class="logo-title">{{ dujiaoka_config_get('text_logo') }}</div>
        </a>
        <a class="btn btn-outline-primary" href="{{ url('order-search') }}">
            <i class="noti-icon uil-file-search-alt search-icon"></i>
            查询订单
        </a>
        @guest
            <a class="btn btn-outline-info ms-1" href="{{ route('login') }}">登录</a>
            <a class="btn btn-info ms-1" href="{{ route('register') }}">注册</a>
        @else
            <div class="dropdown ms-1">
                <button class="btn btn-outline-primary dropdown-toggle" type="button" data-bs-toggle="dropdown"
                    aria-expanded="false">
                    {{ Auth::user()->name }}
                </button>
                <ul class="dropdown-menu">
                    <li>
                        <form method="POST" action="{{ route('logout') }}">
                            @csrf
                            <button type="submit" class="dropdown-item">退出登录</button>
                        </form>
                    </li>
                </ul>
            </div>
        @endguest
    </div>
</div>