// scripts/code-tabs.js
hexo.extend.tag.register('code_tabs', function (args, content) {
    // 解析标签参数（语言名称）
    const languages = args.join(' ').split(',').map(lang => lang.trim());

    // 解析嵌套的 Markdown 内容
    const codeBlocks = content.split('\n====\n').map(block => block.trim());

    // 生成标签栏
    let tabs = `<div class="code-tabs">\n`;
    tabs += `<div class="code-tab-labels">\n`;
    languages.forEach((lang, index) => {
        tabs += `<button class="code-tab-label ${index === 0 ? 'active' : ''}" data-lang="lang${index}">${lang}</button>\n`;
    });
    tabs += `</div>\n`;

    // 生成代码块内容
    codeBlocks.forEach((block, index) => {
        tabs += `<div class="code-tab-content ${index === 0 ? 'active' : ''}" data-lang="lang${index}">\n`;
        tabs += `${hexo.render.renderSync({ text: block, engine: 'markdown' })}\n`;
        tabs += `</div>\n`;
    });

    tabs += `</div>`;

    return tabs;
}, { ends: true });