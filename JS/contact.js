// contact.js - Interactive Elements

document.addEventListener('DOMContentLoaded', function() {
    // FAQ Accordion
    const faqItems = document.querySelectorAll('.faq-item');
    
    faqItems.forEach(item => {
        const question = item.querySelector('.faq-question');
        
        question.addEventListener('click', () => {
            // Close all other items
            faqItems.forEach(otherItem => {
                if (otherItem !== item) {
                    otherItem.classList.remove('active');
                }
            });
            
            // Toggle current item
            item.classList.toggle('active');
        });
    });
    
    // Form Submission
    const contactForm = document.getElementById('contact-form');
    
    if (contactForm) {
        contactForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            // In a real app, you would send the form data to your server
            // This is just a simulation
            const submitBtn = this.querySelector('.submit-btn');
            const originalText = submitBtn.querySelector('span').textContent;
            
            // Show loading state
            submitBtn.disabled = true;
            submitBtn.querySelector('span').textContent = 'Sending...';
            submitBtn.querySelector('svg').style.transform = 'translateX(0)';
            
            // Simulate API call
            setTimeout(() => {
                // Show success state
                submitBtn.querySelector('span').textContent = 'Message Sent!';
                submitBtn.style.backgroundColor = '#4BB543'; // Green color
                
                // Reset form
                setTimeout(() => {
                    contactForm.reset();
                    submitBtn.querySelector('span').textContent = originalText;
                    submitBtn.style.backgroundColor = '';
                    submitBtn.disabled = false;
                }, 2000);
            }, 1500);
        });
    }
    
    // Live Chat Button
    const liveChatBtn = document.getElementById('live-chat-btn');
    
    if (liveChatBtn) {
        liveChatBtn.addEventListener('click', function(e) {
            e.preventDefault();
            alert('Live chat would open in a real implementation. For now, please email us at hello@pixelsforge.com');
        });
    }
    
    // Animate elements on scroll
    const animateOnScroll = () => {
        const elements = document.querySelectorAll('.animate-on-scroll');
        const windowHeight = window.innerHeight;
        
        elements.forEach(element => {
            const elementPosition = element.getBoundingClientRect().top;
            
            if (elementPosition < windowHeight - 100) {
                element.classList.add('animated');
            }
        });
    };
    
    // Initialize scroll animation
    window.addEventListener('scroll', animateOnScroll);
    animateOnScroll(); // Run once on load
});