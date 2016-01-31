## redis测试环境

* 一个 `redis server` 监听 `6379` 端口.
* 一个 `redis cluster node` 监听 `7000` 端口, 处理 `slots 0` 到 `8191`.
* 一个 `redis cluster node` 监听 `7001` 端口, 处理 `slots 8192` 到 `16383`.
* 一个 `redis server` 运行在 `master` 模式, 监听 `8000` 端口.
* 一个 `redis server` 运行在 `slave` 模式, 监听 `8001` 端口, 作为 `8000` 端口 `redis server` 的 `slave`.
* 一个 `redis sentinel` 监听 `28000` 端口, 监控 `8000` 端口的 `master` 命名为 `test`.
