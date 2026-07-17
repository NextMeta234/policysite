// スムーズスクロール
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        
        const targetId = this.getAttribute('href');
        const targetElement = document.querySelector(targetId);
        
        if (targetElement) {
            const headerHeight = document.querySelector('.header').offsetHeight;
            const targetPosition = targetElement.offsetTop - 20;
            
            window.scrollTo({
                top: targetPosition,
                behavior: 'smooth'
            });
        }
    });
});

// 現在のセクションをハイライト
window.addEventListener('scroll', () => {
    const sections = document.querySelectorAll('.policy-section');
    const navLinks = document.querySelectorAll('.toc a');
    
    let current = '';
    
    sections.forEach(section => {
        const sectionTop = section.offsetTop;
        const sectionHeight = section.clientHeight;
        
        if (scrollY >= sectionTop - 100) {
            current = section.getAttribute('id');
        }
    });
    
    navLinks.forEach(link => {
        link.classList.remove('active');
        if (link.getAttribute('href') === '#' + current) {
            link.classList.add('active');
            link.style.fontWeight = 'bold';
            link.style.color = '#2563eb';
        }
    });
});

// ページロード時のアニメーション
document.addEventListener('DOMContentLoaded', () => {
    // フェードインアニメーション
    const sections = document.querySelectorAll('.policy-section');
    
    sections.forEach((section, index) => {
        section.style.opacity = '0';
        section.style.transform = 'translateY(20px)';
        section.style.transition = `opacity 0.6s ease ${index * 0.1}s, transform 0.6s ease ${index * 0.1}s`;
        
        setTimeout(() => {
            section.style.opacity = '1';
            section.style.transform = 'translateY(0)';
        }, 50);
    });
    
    // "トップに戻る"ボタン機能
    const scrollToTopLink = document.querySelector('a[href="#overview"]');
    if (scrollToTopLink && scrollToTopLink.parentElement.textContent.includes('トップに戻る')) {
        scrollToTopLink.addEventListener('click', (e) => {
            e.preventDefault();
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });
    }
});

// 外部リンクに新しいウィンドウで開く属性を追加
document.addEventListener('DOMContentLoaded', () => {
    const links = document.querySelectorAll('a[href^="http"]');
    links.forEach(link => {
        link.target = '_blank';
        link.rel = 'noopener noreferrer';
    });
});

// アクセシビリティ向上：キーボードナビゲーション
document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape') {
        // エスケープキーで最上部へ
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    }
});

// ページの読み込み進度を表示
window.addEventListener('load', () => {
    console.log('Privacy Policy page loaded successfully');
});
