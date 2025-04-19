document.addEventListener('DOMContentLoaded', function() {
    // Initialize GSAP scroll animations
    gsap.registerPlugin(ScrollTrigger);

    // Animate timeline items
    gsap.utils.toArray('.timeline-item').forEach((item, i) => {
        gsap.from(item, {
            scrollTrigger: {
                trigger: item,
                start: "top 80%",
                toggleActions: "play none none none"
            },
            x: i % 2 === 0 ? -100 : 100,
            opacity: 0,
            duration: 1,
            ease: "power3.out"
        });
    });

    // Animate team cards with stagger
    gsap.from('.team-card', {
        scrollTrigger: {
            trigger: '.team-section',
            start: "top 80%",
            toggleActions: "play none none none"
        },
        y: 50,
        opacity: 0,
        duration: 0.8,
        stagger: 0.2,
        ease: "back.out"
    });

    // Animate stats with counter
    const statNumbers = document.querySelectorAll('.stat-number');

    statNumbers.forEach(stat => {
        const target = parseInt(stat.getAttribute('data-count'));
        const duration = 2;
        const start = 0;

        ScrollTrigger.create({
            trigger: stat,
            start: "top 80%",
            onEnter: () => {
                gsap.to(stat, {
                    innerText: target,
                    duration: duration,
                    snap: { innerText: 1 },
                    onUpdate: function() {
                        stat.innerText = Math.floor(this.targets()[0].innerText);
                    },
                    ease: "power1.out"
                });
            }
        });
    });

    // You can continue adding more animations below...
});
