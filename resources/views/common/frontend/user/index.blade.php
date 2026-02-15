@extends(dujiaoka_config_get('template', 'unicorn') . '.layouts.default')

@section('content')
    <div class="container" style="padding-top:50px; padding-bottom:50px; min-height:600px;">
        <div class="row">
            <div class="col-md-3">
                <div class="list-group">
                    <a href="{{ url('user') }}" class="list-group-item list-group-item-action active">我的订单</a>
                    <a href="{{ url('logout') }}" class="list-group-item list-group-item-action">退出登录</a>
                </div>
            </div>
            <div class="col-md-9">
                <div class="card">
                    <div class="card-header">历史订单</div>
                    <div class="card-body">
                        @if($orders->count() > 0)
                            <div class="table-responsive">
                                <table class="table table-hover table-bordered">
                                    <thead>
                                        <tr>
                                            <th>订单号</th>
                                            <th>商品名称</th>
                                            <th>价格</th>
                                            <th>状态</th>
                                            <th>下单时间</th>
                                            <th>操作</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        @foreach($orders as $order)
                                            <tr>
                                                <td>{{ $order->order_sn }}</td>
                                                <td>{{ $order->title }}</td>
                                                <td>{{ $order->actual_price }}</td>
                                                <td>
                                                    @if($order->status == \App\Models\Order::STATUS_WAIT_PAY)
                                                        <span class="badge badge-warning text-white"
                                                            style="background-color: #ffc107;">待支付</span>
                                                    @elseif($order->status == \App\Models\Order::STATUS_PENDING)
                                                        <span class="badge badge-info text-white"
                                                            style="background-color: #17a2b8;">待处理</span>
                                                    @elseif($order->status == \App\Models\Order::STATUS_PROCESSING)
                                                        <span class="badge badge-primary text-white"
                                                            style="background-color: #007bff;">处理中</span>
                                                    @elseif($order->status == \App\Models\Order::STATUS_COMPLETED)
                                                        <span class="badge badge-success text-white"
                                                            style="background-color: #28a745;">已完成</span>
                                                    @elseif($order->status == \App\Models\Order::STATUS_FAILURE)
                                                        <span class="badge badge-danger text-white"
                                                            style="background-color: #dc3545;">失败</span>
                                                    @elseif($order->status == \App\Models\Order::STATUS_EXPIRED)
                                                        <span class="badge badge-secondary text-white"
                                                            style="background-color: #6c757d;">已过期</span>
                                                    @else
                                                        <span class="badge badge-dark text-white"
                                                            style="background-color: #343a40;">异常</span>
                                                    @endif
                                                </td>
                                                <td>{{ $order->created_at }}</td>
                                                <td>
                                                    <a href="{{ url('bill', ['orderSN' => $order->order_sn]) }}"
                                                        class="btn btn-sm btn-info" target="_blank">订单详情</a>
                                                </td>
                                            </tr>
                                        @endforeach
                                    </tbody>
                                </table>
                            </div>
                            <div class="mt-3">
                                {{ $orders->links() }}
                            </div>
                        @else
                            <div class="text-center p-5">
                                <h4>暂无订单数据</h4>
                                <p>您还没有下过单，或者下单时使用的邮箱与当前账号不一致。</p>
                                <a href="/" class="btn btn-primary">去购物</a>
                            </div>
                        @endif
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection