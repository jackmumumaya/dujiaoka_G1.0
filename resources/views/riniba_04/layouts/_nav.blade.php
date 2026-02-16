<div class="top-header">
  <div class="container header-block">
    <div class="header-left">
      <div class="header-right clearfix">
        <nav class="navbar navbar-expand-lg navbar-light">
          <div class="container-fluid" style="position: relative;">
            <a href="/" class="topnav-logo" style="float: none">
              <img class="img-logo" src="https://i.postimg.cc/8crWdxXw/Gemini-Generated-Image-9fh69fh69fh69fh6.png"
                alt="{{ dujiaoka_config_get('text_logo') }}"
                style="height: 100px; width: auto; vertical-align: middle;">
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" id="myButton"
              data-bs-target="#navbarColor" aria-controls="navbarColor" aria-expanded="false"
              aria-label="Toggle navigation">
              <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarColor">
              <ul class="navbar-nav me-auto centered-nav">
                <a class="btn btn-top-nav" href="/">首页</a><a class="btn btn-top-nav" href="/order-search">订单查询</a><a
                  class="btn btn-top-nav" href="https://t.me/Gemini_51xueAi" target="_blank">在线客服</a><a
                  class="btn btn-top-nav" href="https://t.me/ai51xue" target="_blank"><i class="uil uil-cart"></i>
                  加入社区</a>
                @guest
                  <a class="btn btn-top-nav" href="{{ route('login') }}">登录</a>
                  <a class="btn btn-top-nav" href="{{ route('register') }}">注册</a>
                @else
                  <span class="btn btn-top-nav" style="cursor: default;">{{ Auth::user()->name }}</span>
                  <form method="POST" action="{{ route('logout') }}" style="display: inline;">
                    @csrf
                    <button type="submit" class="btn btn-top-nav" style="border: none; cursor: pointer;">退出</button>
                  </form>
                @endguest
              </ul>
              @if (request()->is('/'))
                <div class="search-box-placeholder">
                  <div class="search-box">
                    <input type="text" class="search-form" id="search" placeholder="输入关键词搜索..." /><span
                      class="uil-search"></span>
                  </div>
                </div>
              @endif
            </div>
          </div>
        </nav>
      </div>
    </div>
  </div>
</div>

<!-- Scripts for Mobile Menu Hint -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    console.log('Mobile Menu Hint Script Loading...');
    
    var btn = document.getElementById('myButton');
    if (!btn) {
        console.error('Menu button not found!');
        return;
    }

    // Create Hint Element
    var hint = document.createElement('div');
    hint.id = 'js-mobile-menu-hint';
    hint.innerHTML = `
        <span style="color: #dc3545; font-weight: bold; font-size: 14px; margin-right: 5px;">点击展开</span>
        <svg width="30" height="30" viewBox="0 0 24 24" fill="none" class="hint-arrow-anim">
          <line x1="5" y1="19" x2="19" y2="5" stroke="#dc3545" stroke-width="2" stroke-linecap="round" />
          <polyline points="9 5 19 5 19 15" stroke="#dc3545" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
        </svg>
    `;
    // Base Styles
    hint.style.position = 'absolute';
    hint.style.zIndex = '999999';
    hint.style.display = 'none'; // hidden by default
    hint.style.alignItems = 'center';
    hint.style.cursor = 'pointer';
    hint.style.pointerEvents = 'auto'; // ensure clickable
    document.body.appendChild(hint);

    // Animation Style
    var style = document.createElement('style');
    style.innerHTML = `
        @keyframes hint-bounce { 0%, 100% { transform: translate(0,0); } 50% { transform: translate(3px, -3px); } }
        .hint-arrow-anim { animation: hint-bounce 1s infinite; }
    `;
    document.head.appendChild(style);

    // Update Position Function
    function updateHint() {
        var rect = btn.getBoundingClientRect();
        var compStyle = window.getComputedStyle(btn);
        
        // Hide if button hidden or expanded
        if (compStyle.display === 'none' || btn.getAttribute('aria-expanded') === 'true') {
            hint.style.display = 'none';
            return;
        }

        // Show and Position
        hint.style.display = 'flex';
        // Position: Top-Right of button essentially
        // Let's put it to the LEFT of the button as per user request (arrow pointing right/up)
        // User screenshot: Arrow points TOP-RIGHT towards button. Text says "Click to expand".
        // Hint should be below-left of button.
        
        var scrollTop = window.pageYOffset || document.documentElement.scrollTop;
        var scrollLeft = window.pageXOffset || document.documentElement.scrollLeft;
        
        hint.style.top = (rect.bottom + scrollTop + 5) + 'px'; // 5px below button
        hint.style.left = (rect.left + scrollLeft - 80) + 'px'; // Shift left
    }

    // Events
    window.addEventListener('resize', updateHint);
    window.addEventListener('scroll', updateHint);
    setInterval(updateHint, 1000); // Polling for safety layout shifts
    updateHint(); // Initial call

    // Interaction
    hint.addEventListener('click', function() {
        btn.click();
    });

    // Observe Button attributes for aria-expanded changes
    var observer = new MutationObserver(function(mutations) {
        updateHint();
    });
    observer.observe(btn, { attributes: true, attributeFilter: ['aria-expanded', 'class', 'style'] });
});
</script>