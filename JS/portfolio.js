document.addEventListener('DOMContentLoaded', function() {
    // Project data
    const projects = [
        {
            id: 1,
            title: "Tech Product Launch",
            type: "Commercial",
            tools: ["After Effects", "Premiere Pro", "Cinema 4D"],
            image: "assets/images/projects/tech-launch.jpg",
            video: "assets/videos/tech-launch.mp4",
            editors: ["Alex C.", "Sam R."],
            description: "High-energy product reveal for a major tech company with complex motion graphics and 3D elements."
        },
        {
            id: 2,
            title: "Fashion Brand Reel",
            type: "Reels",
            tools: ["Premiere Pro", "DaVinci Resolve"],
            image: "assets/images/projects/fashion-reel.jpg",
            video: "assets/videos/fashion-reel.mp4",
            editors: ["Maria G.", "James L."],
            description: "Fast-paced fashion reel with dynamic transitions and color grading to match brand aesthetics."
        },
        // Add more projects...
    ];
    
    // Load projects into grid
    const portfolioGrid = document.querySelector('.portfolio-grid');
    const filterButtons = document.querySelectorAll('.filter-btn');
    
    if (portfolioGrid) {
        function renderProjects(filter = 'All') {
            portfolioGrid.innerHTML = '';
            
            const filteredProjects = filter === 'All' 
                ? projects 
                : projects.filter(project => project.type.toLowerCase() === filter.toLowerCase());
            
            filteredProjects.forEach(project => {
                const projectCard = document.createElement('div');
                projectCard.className = 'project-card';
                projectCard.innerHTML = `
                    <img src="${project.image}" alt="${project.title}" class="project-image">
                    <div class="project-overlay">
                        <span class="project-type">${project.type}</span>
                        <h3 class="project-title">${project.title}</h3>
                        <button class="view-project" data-id="${project.id}">View Project</button>
                    </div>
                `;
                portfolioGrid.appendChild(projectCard);
            });
            
            // Add event listeners to view buttons
            document.querySelectorAll('.view-project').forEach(button => {
                button.addEventListener('click', function() {
                    const projectId = parseInt(this.getAttribute('data-id'));
                    const project = projects.find(p => p.id === projectId);
                    openModal(project);
                });
            });
        }
        
        // Initial render
        renderProjects();
        
        // Filter buttons
        filterButtons.forEach(button => {
            button.addEventListener('click', function() {
                filterButtons.forEach(btn => btn.classList.remove('active'));
                this.classList.add('active');
                renderProjects(this.textContent);
            });
        });
    }
    
    // Modal functionality
    const modal = document.createElement('div');
    modal.className = 'modal';
    modal.innerHTML = `
        <div class="modal-content">
            <button class="close-modal">&times;</button>
            <video controls class="modal-video">
                Your browser does not support the video tag.
            </video>
            <div class="modal-details">
                <h2></h2>
                <p class="project-description"></p>
                <div class="modal-meta">
                    <span class="meta-tools"></span>
                    <span class="meta-editors"></span>
                </div>
            </div>
        </div>
    `;
    document.body.appendChild(modal);
    
    function openModal(project) {
        const modalVideo = modal.querySelector('.modal-video');
        const modalTitle = modal.querySelector('h2');
        const modalDesc = modal.querySelector('.project-description');
        const modalTools = modal.querySelector('.meta-tools');
        const modalEditors = modal.querySelector('.meta-editors');
        
        modalVideo.innerHTML = `<source src="${project.video}" type="video/mp4">`;
        modalTitle.textContent = project.title;
        modalDesc.textContent = project.description;
        modalTools.textContent = `Tools: ${project.tools.join(', ')}`;
        modalEditors.textContent = `Editors: ${project.editors.join(', ')}`;
        
        modal.style.display = 'flex';
        document.body.style.overflow = 'hidden';
        
        // Play video when modal opens
        modalVideo.load();
        modalVideo.play().catch(e => console.log("Autoplay prevented:", e));
    }
    
    // Close modal
    modal.querySelector('.close-modal').addEventListener('click', function() {
        modal.style.display = 'none';
        document.body.style.overflow = 'auto';
        modal.querySelector('.modal-video').pause();
    });
    
    // Close modal when clicking outside content
    modal.addEventListener('click', function(e) {
        if (e.target === modal) {
            modal.style.display = 'none';
            document.body.style.overflow = 'auto';
            modal.querySelector('.modal-video').pause();
        }
    });
});