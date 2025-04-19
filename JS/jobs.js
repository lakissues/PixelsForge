// Add this at the top of your existing jobs.js
document.addEventListener('DOMContentLoaded', function() {
    // Create floating particles
    function createParticles() {
        const particles = 30;
        for (let i = 0; i < particles; i++) {
            const particle = document.createElement('div');
            particle.classList.add('particle');
            
            // Random properties
            const size = Math.random() * 5 + 2;
            const posX = Math.random() * window.innerWidth;
            const duration = Math.random() * 15 + 10;
            const delay = Math.random() * 5;
            const opacity = Math.random() * 0.5 + 0.1;
            
            // Apply properties
            particle.style.width = `${size}px`;
            particle.style.height = `${size}px`;
            particle.style.left = `${posX}px`;
            particle.style.bottom = `-10px`;
            particle.style.opacity = opacity;
            particle.style.animationDuration = `${duration}s`;
            particle.style.animationDelay = `${delay}s`;
            
            document.body.appendChild(particle);
        }
    }
    
    createParticles();
    
    // Rest of your existing jobs.js code
});