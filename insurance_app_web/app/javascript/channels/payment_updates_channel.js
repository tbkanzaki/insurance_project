document.addEventListener('DOMContentLoaded',() => {
  createWebSocketChannel();
});

function createWebSocketChannel(){
  const socket = new WebSocket('ws://localhost:3000/cable');

  socket.onopen = function(event) {
    const subscribeMessage = {
      command: 'subscribe',
      identifier: JSON.stringify({
        channel: 'PaymentUpdatesChannel'
      })
    };
    socket.send(JSON.stringify(subscribeMessage))
  }

  socket.onmessage = function (event){
    const data = JSON.parse(event.data);
    
    if (data.type == "ping"){
      return;
    }
    
    if (data.message){
      const policyData = JSON.parse(data.message)
      
      const policyId = policyData.policy_id;
      console.log("Policy id:", policyId);
      
      const policyPaymentStatus = policyData.payment_status;
      console.log("Payment Status:", policyPaymentStatus);
      
      const policyDivElement = document.getElementById(`paymentStatus-${policyId}`);
      if (policyDivElement) {
        policyDivElement.innerHTML = policyPaymentStatus;
      }
    }
  }
}
