document.addEventListener('DOMContentLoaded', function() {
    // Initialize Stripe
    const stripe = Stripe('your_publishable_key_here');
    const elements = stripe.elements();
    const cardElement = elements.create('card');
    cardElement.mount('#card-element');
    
    // Tab switching
    document.querySelectorAll('.tab').forEach(tab => {
        tab.addEventListener('click', function() {
            document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
            this.classList.add('active');
            
            document.querySelectorAll('.tab-content').forEach(content => {
                content.classList.remove('active');
            });
            
            document.getElementById(`${this.dataset.tab}-tab`).classList.add('active');
        });
    });
    
    // Load contract details
    async function loadContractDetails() {
        const contractId = new URLSearchParams(window.location.search).get('contract_id');
        
        try {
            const response = await fetch(`/api/contracts/${contractId}`);
            const data = await response.json();
            
            document.getElementById('contract-details').innerHTML = `
                <p><strong>Project:</strong> ${data.title}</p>
                <p><strong>Editor:</strong> ${data.editor_name}</p>
                <p><strong>Agreed Price:</strong> $${data.agreed_price.toFixed(2)}</p>
            `;
            
            document.getElementById('payment-amount').textContent = `$${data.agreed_price.toFixed(2)}`;
        } catch (error) {
            console.error('Error loading contract:', error);
        }
    }
    
    // Handle form submission
    const paymentForm = document.getElementById('payment-form');
    paymentForm.addEventListener('submit', async function(e) {
        e.preventDefault();
        
        const submitButton = document.getElementById('submit-payment');
        const spinner = document.getElementById('spinner');
        const buttonText = document.getElementById('button-text');
        
        // Show loading state
        submitButton.disabled = true;
        buttonText.textContent = 'Processing...';
        spinner.classList.remove('hidden');
        
        // Create payment method
        const { paymentMethod, error } = await stripe.createPaymentMethod({
            type: 'card',
            card: cardElement,
        });
        
        if (error) {
            document.getElementById('card-errors').textContent = error.message;
            submitButton.disabled = false;
            buttonText.textContent = 'Pay Now';
            spinner.classList.add('hidden');
            return;
        }
        
        // Process payment
        const contractId = new URLSearchParams(window.location.search).get('contract_id');
        
        try {
            const response = await fetch('/api/payments/process', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    contract_id: contractId,
                    amount: parseFloat(document.getElementById('payment-amount').textContent.replace('$', '')),
                    payment_method_id: paymentMethod.id
                })
            });
            
            const result = await response.json();
            
            if (result.success) {
                window.location.href = `/payment-success?transaction_id=${result.transaction_id}`;
            } else {
                throw new Error(result.error || 'Payment failed');
            }
        } catch (error) {
            document.getElementById('card-errors').textContent = error.message;
            submitButton.disabled = false;
            buttonText.textContent = 'Pay Now';
            spinner.classList.add('hidden');
        }
    });
    
    // Initialize the page
    loadContractDetails();
});