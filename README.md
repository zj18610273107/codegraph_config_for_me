# CodeGraph 本机配置

这个仓库保存个人 CodeGraph 使用配置、项目级过滤文件和 `cg-*` 命令转发脚本。

## 一键安装

```bash
cd /home/zjppp/work_clone/github/codex_list/codegraph_config_for_me
./install.sh
```

安装脚本会：

1. 把 `cg` 和所有 `cg-*` 命令链接到 `~/.local/bin`。
2. 恢复 Codex 的 `codegraph` MCP 配置。
3. 保留 `CODEGRAPH_DIR=build` 和 5000 ms watcher debounce。

执行后重启 Codex。

## 日常使用

在项目目录内执行：

```bash
cg-init
```

`cg-init` 会自动：

1. 按仓库名查找 `codegraph_config_for_me/<仓库名>/` 配置。
2. 把 `codegraph.json` 和 `.gitignore` 复制到项目的 `build`。
3. 没有索引时执行首次初始化。
4. 已有索引时自动执行完整重建。

轻量增量更新使用：

```bash
cg-sync
```

状态和查询命令：

```bash
cg-status
cg-version
cg-explore "查询内容"
cg-query "符号名"
cg-callers "函数名"
cg-callees "函数名"
cg-impact "符号名"
```

## 路径约定

- `bin/cg`：命令转发脚本。
- `codex/mcp-codegraph.toml`：Codex MCP 配置片段。
- `<仓库名>/codegraph.json`：对应项目的 CodeGraph 配置。
- `<仓库名>/.gitignore`：对应项目使用的完整忽略规则。
