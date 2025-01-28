document.addEventListener('DOMContentLoaded', function () {
    const tabs = document.querySelectorAll('.code-tabs');
    tabs.forEach(tab => {
        const labels = tab.querySelectorAll('.code-tab-label');
        const contents = tab.querySelectorAll('.code-tab-content');

        labels.forEach(label => {
            label.addEventListener('click', () => {
                // 移除所有标签和内容的激活状态
                labels.forEach(l => l.classList.remove('active'));
                contents.forEach(c => c.classList.remove('active'));

                // 激活当前标签和对应内容
                const lang = label.getAttribute('data-lang');
                label.classList.add('active');
                tab.querySelector(`.code-tab-content[data-lang="${lang}"]`).classList.add('active');
            });
        });
    });
});