# GitHub Actions 工作流说明

## Publish Gem to GitHub Packages

这个工作流会自动构建 psd gem 并发布到 GitHub Packages。

### 触发条件

1. **自动触发**：
   - 当推送以 'v' 开头的 git 标签时（例如：`v1.0.0`, `v2.1.3`）

2. **手动触发**：
   - 在 GitHub Actions 页面手动运行工作流
   - 可以指定自定义版本号（可选）

### 工作流程

1. **检出代码**：获取完整的 git 历史记录
2. **设置 Ruby 环境**：使用 Ruby 3.4 和缓存 bundler
3. **确定版本号**：
   - 手动触发时使用输入的版本
   - 标签触发时使用标签名（去掉 'v' 前缀）
   - 其他情况从 gemspec 读取版本
4. **验证 gemspec**：确保 gemspec 文件有效
5. **运行测试**：执行所有 RSpec 测试
6. **构建 gem**：生成 .gem 文件
7. **发布到 GitHub Packages**：使用 GitHub Token 认证
8. **上传制品**：将 gem 文件保存为工作流制品
9. **创建 GitHub Release**（仅标签触发时）：自动生成发布说明

### 使用方法

#### 通过标签发布

```bash
# 创建并推送标签
git tag v3.9.1
git push origin v3.9.1
```

#### 手动发布

1. 访问 GitHub 仓库的 Actions 页面
2. 选择 "Publish Gem to GitHub Packages" 工作流
3. 点击 "Run workflow"
4. （可选）输入自定义版本号
5. 点击 "Run workflow"

### 安装发布的 gem

在 Gemfile 中添加：

```ruby
source "https://rubygems.pkg.github.com/#{YOUR_USERNAME}" do
  gem "psd"
end
```

或者配置全局源：

```bash
gem sources --add https://rubygems.pkg.github.com/YOUR_USERNAME/
```

### 认证

工作流使用自动生成的 `GITHUB_TOKEN` 进行认证，无需额外配置。

### 版本管理建议

- 使用语义化版本控制（SemVer）
- 标签格式：`vMAJOR.MINOR.PATCH`（例如：`v3.9.1`）
- 每次发布前确保所有测试通过