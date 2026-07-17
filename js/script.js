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

document.addEventListener("DOMContentLoaded", function () {
  const cookieBanner = document.getElementById("cookie-banner");
  const acceptBtn = document.getElementById("cookie-accept");
  const declineBtn = document.getElementById("cookie-decline");
  
  // HTML内にある「Cookie設定」のリンクを探す
  const cookieLink = document.querySelector('a[href="#cookie-settings"]') || document.querySelector('a[href="#"]');

  // 1. ページ読み込み時の処理
  const cookieConsent = localStorage.getItem("cookieConsent");
  if (!cookieConsent) {
    // 同意履歴がなければ、クラスを付与してフワッと表示
    setTimeout(() => {
      cookieBanner.classList.add("show");
    }, 500); // 0.5秒後に表示
  }

  // 2. 「Cookie設定」リンクを押した時の処理
  if (cookieLink) {
    cookieLink.addEventListener("click", function (e) {
      e.preventDefault(); // 画面がトップに跳ね上がるのを防ぐ
      cookieBanner.classList.add("show"); // バナーを再表示
    });
  }

  // 3. 「同意する」ボタン
  acceptBtn.addEventListener("click", function () {
    localStorage.setItem("cookieConsent", "accepted");
    cookieBanner.classList.remove("show");
  });

  // 4. 「同意しない」ボタン
  declineBtn.addEventListener("click", function () {
    localStorage.setItem("cookieConsent", "declined");
    cookieBanner.classList.remove("show");
  });
});
