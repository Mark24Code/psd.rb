#!/bin/bash
# 测试工作流关键步骤的脚本

echo "🔧 测试 GitHub Actions 工作流关键步骤"

# 测试版本检测
echo "1. 测试版本检测..."
VERSION=$(ruby -e "require './lib/psd/version'; puts PSD::VERSION")
echo "   当前版本: $VERSION"

# 测试 gemspec 验证
echo "2. 测试 gemspec 验证..."
gem build psd.gemspec
if [ $? -eq 0 ]; then
    echo "   ✅ gemspec 验证通过"
    ls -la *.gem
else
    echo "   ❌ gemspec 验证失败"
    exit 1
fi

# 测试测试套件
echo "3. 测试测试套件..."
bundle exec rspec --format documentation --fail-fast
if [ $? -eq 0 ]; then
    echo "   ✅ 测试套件通过"
else
    echo "   ❌ 测试套件失败"
    exit 1
fi

echo "🎉 所有关键步骤测试通过！"