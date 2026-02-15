<header class="large-screens">
    <div class="container-fluid">
        <nav class="navbar navbar-expand-lg p-0">
            <div class="collapse navbar-collapse" id="mynavbar">
                <div class="left-nav">
                    <a href="/" class="navbar-brand m-0 p-0">
                        <img class="logoimage" src="{{ picture_ulr(dujiaoka_config_get('img_logo')) }}">

                    </a>
                    <ul class="navbar-nav m-0">
                        <li class="menu-item"><a href="/">{{ dujiaoka_config_get('text_logo') }}</a></li>
                    </ul>
                </div>
                <div class="search-block">
                    <div class="input-group search-bar">
                        <input id="search" type="text" placeholder="请输入关键词..." required />
                        <button class="search" type="submit">
                            <i class="far fa-search search-icon"></i>
                        </button>
                    </div>
                </div>
                <div class="right-nav">
                    <ul class="navbar-nav m-0">
                        <li class="menu-item">
                            <a href="{{ url('order-search') }}"><i class="fal fa-shopping-cart"></i>订单查询</a>
                        </li>
                        @guest
                            <li class="menu-item">
                                <a href="{{ route('login') }}"><i class="fal fa-sign-in"></i>登录</a>
                            </li>
                            <li class="menu-item">
                                <a href="{{ route('register') }}"><i class="fal fa-user-plus"></i>注册</a>
                            </li>
                        @else
                            <li class="menu-item">
                                <a href="#">{{ Auth::user()->name }}</a>
                            </li>
                            <li class="menu-item">
                                <form method="POST" action="{{ route('logout') }}" style="display:inline;">
                                    @csrf
                                    <button type="submit"
                                        style="background:none;border:none;color:inherit;cursor:pointer;padding:0;">退出</button>
                                </form>
                            </li>
                        @endguest
                    </ul>
                </div>
            </div>
        </nav>
    </div>
</header>
<header class="small-screen">
    <div class="container-fluid">
        <div class="mobile-menu">
            <div>
                <a class="navbar-brand" href="/"><img class="logoimage"
                        src="{{ picture_ulr(dujiaoka_config_get('img_logo')) }}"></a>
            </div>
            <div class="hamburger-menu">
                <div class="bar"></div>
            </div>
        </div>
        <nav class="mobile-navar d-xl-none">
            <ul>
                <li><a href="/">主页</a></li>
                <li><a href="{{ url('order-search') }}">订单查询</a></li>
                @guest
                    <li><a href="{{ route('login') }}">登录</a></li>
                    <li><a href="{{ route('register') }}">注册</a></li>
                @else
                    <li><a href="#">{{ Auth::user()->name }}</a></li>
                    <li>
                        <form method="POST" action="{{ route('logout') }}">
                            @csrf
                            <button type="submit"
                                style="background:none;border:none;color:inherit;cursor:pointer;padding:0;width:100%;text-align:left;">退出登录</button>
                        </form>
                    </li>
                @endguest
            </ul>
        </nav>
    </div>
</header>

<div class="page-title-banner">
    <div class="container">
        <div class="content">
            <div class="title">
                <h2>我将在美好的时间遇到你</h2>
            </div>
        </div>
    </div>

</div>