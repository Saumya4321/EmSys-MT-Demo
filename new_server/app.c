#include "lwip/init.h"
#include "lwip/netif.h"
#include "lwip/tcp.h"
#include "lwip/ip_addr.h"
#include "lwip/timeouts.h"
#include <stdio.h>
#include <string.h>

#define HTTP_PORT 80  // HTTP default port

static struct tcp_pcb *http_pcb;

// Callback function to handle incoming HTTP requests
static err_t http_recv(void *arg, struct tcp_pcb *tpcb, struct pbuf *p, err_t err) {
    if (!p) {  // Connection closed
        tcp_close(tpcb);
        return ERR_OK;
    }

    // Print the received request (for debugging)
    printf("Received request:\n%s\n", (char *)p->payload);

    // Check if the request is a GET request
    if (strstr((char *)p->payload, "GET / ") != NULL) {
        const char *response =
            "HTTP/1.1 200 OK\r\n"
            "Content-Type: text/html\r\n"
            "Connection: close\r\n\r\n"
            "<html><body><h1>Hello from LwIP on PC!</h1></body></html>";

        tcp_write(tpcb, response, strlen(response), TCP_WRITE_FLAG_COPY);
    }

    pbuf_free(p);  // Free the received packet buffer
    return ERR_OK;
}

// Callback function when a new connection is accepted
static err_t http_accept(void *arg, struct tcp_pcb *tpcb, err_t err) {
    tcp_recv(tpcb, http_recv);  // Register receive callback
    return ERR_OK;
}

// Initialize the HTTP server
void http_server_init() {
    http_pcb = tcp_new();  // Create TCP control block
    if (!http_pcb) {
        printf("Error creating TCP socket\n");
        return;
    }

    tcp_bind(http_pcb, IP_ADDR_ANY, HTTP_PORT);  // Bind to port 80
    http_pcb = tcp_listen(http_pcb);  // Start listening for connections
    tcp_accept(http_pcb, http_accept);  // Register accept callback

    printf("HTTP server started on http://127.0.0.1:%d\n", HTTP_PORT);
}

// Main function
int main() {
    lwip_init();  // Initialize LwIP stack
    http_server_init();  // Start HTTP server

    while (1) {
        sys_check_timeouts();  // Process LwIP timers
    }

    return 0;
}
