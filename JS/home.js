document.addEventListener('DOMContentLoaded', function() {
    // Testimonial data
    const testimonials = [
        {
            name: "Sarah K.",
            company: "TechStart Inc.",
            quote: "PixelsForge transformed our product launch video. The editors understood our vision perfectly and delivered beyond expectations.",
            project: "Tech Product Launch"
        },
        {
            name: "Michael T.",
            company: "Creative Media Co.",
            quote: "The speed and quality of work is unmatched. We've found our go-to editing team for all our client projects.",
            project: "Social Media Campaign"
        },
        {
            name: "Emma L.",
            company: "Global Brands",
            quote: "Working with PixelsForge has streamlined our video production process. Their editors are true professionals.",
            project: "Corporate Brand Videos"
        }
    ];
    
    // Load testimonials
    const testimonialSlider = document.querySelector('.testimonial-slider');
    
    if (testimonialSlider) {
        let currentTestimonial = 0;
        
        function showTestimonial(index) {
            const testimonial = testimonials[index];
            testimonialSlider.innerHTML = `
                <div class="testimonial-content">
                    <p class="testimonial-quote">"${testimonial.quote}"</p>
                    <div class="testimonial-meta">
                        <h4>${testimonial.name}</h4>
                        <p>${testimonial.company}</p>
                        <p class="testimonial-project">Project: ${testimonial.project}</p>
                    </div>
                </div>
            `;
        }
        
        // Show first testimonial
        showTestimonial(currentTestimonial);
        
        // Auto-rotate testimonials
        setInterval(() => {
            currentTestimonial = (currentTestimonial + 1) % testimonials.length;
            showTestimonial(currentTestimonial);
        }, 5000);
    }
    
    // Auto-play hero video (with fallback for browsers that block autoplay)
    const heroVideo = document.querySelector('.video-background');
    if (heroVideo) {
        heroVideo.play().catch(error => {
            console.log("Autoplay was prevented:", error);
            // Show play button or other fallback
        });
    }
});