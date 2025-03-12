/*******************************************************************************
 * (c) Copyright 2013 Microsemi SoC Producst Group.  All rights reserved.
 *
 *
 * SVN $Revision: 4956 $
 * SVN $Date: 2013-01-08 15:25:36 +0000 (Tue, 08 Jan 2013) $
 */

#include "lwip/opt.h"
#include "lwip/arch.h"
#include "lwip/api.h"

#include "httpserver-netconn.h"

/* FreeRTOS includes. */
#include "FreeRTOS.h"
#include "queue.h"
#include "webpages.h"
#include "mss_rtc.h"
#include "m2sxxx.h"
#include <stdio.h>
#include <string.h>
#include <assert.h>
#include "mss_gpio.h"
#include "core_tse.h"

#include "ethernet_status.h"

char String[128];

#if LWIP_NETCONN

#ifndef HTTPD_DEBUG
#define HTTPD_DEBUG         LWIP_DBG_OFF
#endif

extern tse_instance_t g_tse;
extern xQueueHandle xEthStatusQueue;

ethernet_status_t g_ethernet_status;

#define RTC_PRESCALER    (1000000u - 1u)        /* 1MhZ clock is RTC clock source. */

/*------------------------------------------------------------------------------
 * External functions.
 */
uint32_t get_ip_address(void);
void get_mac_address(uint8_t * mac_addr);

/*------------------------------------------------------------------------------
 *
 */
void handle_trigger_request(char * buf, u16_t len);
unsigned char hex_digits_to_byte(unsigned char u, unsigned char l);
/*------------------------------------------------------------------------------
 *
 */
extern const char mscc_jpg_logo[8871];
char uip_appdata[1200];

/*------------------------------------------------------------------------------
 *
 */
const static char http_html_hdr[] = "HTTP/1.1 200 OK\r\nContent-type: text/html\r\n\r\n";
const static char http_json_hdr[] = "HTTP/1.1 200 OK\r\nContent-type: application/jsonrequest\r\n\r\n";

const static char http_post_resp_hdr[] = "HTTP/1.1 204 No Content\r\n\r\n";
const static char http_html_ok_hdr[] = "HTTP/1.1 200 OK\r\n\r\n";

/*------------------------------------------------------------------------------
 *
 */


/*------------------------------------------------------------------------------
 *
 */
static char status_json[400];

/*------------------------------------------------------------------------------
 *
 */

/* The queue used by PTPd task to transmit status information to webserver task. */
extern xQueueHandle xPTPdOutQueue;

extern void send_msg(const uint8_t * p_msg);

/*------------------------------------------------------------------------------
 *
 */
/** Serve one HTTP connection accepted in the http thread */
static void
http_server_netconn_serve
(
    struct netconn *conn,
    mss_rtc_calendar_t * calendar_count
)
{
    struct netbuf *inbuf;
    char *buf;
    u16_t buflen;
    err_t err;
    unsigned char c,i,leddata;
    char *tempStrPtr;
    char *tempStrPtr2;
    unsigned char Hyper_string[20];
    unsigned char Led_string[4];
    const char * mac_speed_lut[] =
    {
        "10Mbps",
        "100Mbps",
        "1000Mbps",
        "invalid"
    };

    /* Read the data from the port, blocking if nothing yet there. 
    We assume the request (the part we care about) is in one netbuf */
    err = netconn_recv(conn, &inbuf);

    if(err == ERR_OK)
    {
        netbuf_data(inbuf, (void**)&buf, &buflen);
    
        /* Is this an HTTP GET command? (only check the first 5 chars, since
        there are other formats for GET, and we're keeping it very simple )*/
        if(buflen >= 5 &&
           buf[0] == 'G' &&
           buf[1] == 'E' &&
           buf[2] == 'T' &&
           buf[3] == ' ' &&
           buf[4] == '/' )
        {
        	if( !strncmp( buf, "GET /RTCdata", 12 ) || !strncmp( buf, "GET /status", 11 )||!strncmp( buf, "GET /trigger0?", 14)||!strncmp( buf, "GET /trigger1?", 14)|| !strncmp( buf, "GET /index_r1_c1", 16 ))

           {
            	 if( buf[5]=='s')
            	  {
            		  int json_resp_size;
            		  uint32_t ip_addr;
            		  uint8_t mac_addr[6];
            		  uint32_t mac_speed_idx;

            		  ip_addr = get_ip_address();
            		  get_mac_address(mac_addr);
            		  mac_speed_idx = SYSREG->MAC_CR & 0x00000003u;

            		  json_resp_size = snprintf(status_json, sizeof(status_json),
                                          "{\r\n\"MAC_Addr\": \"%02x:%02x:%02x:%02x:%02x:%02x\",\"TCPIP_Addr\": \"%d.%d.%d.%d\",\r\n\"LinkSpeed\": \"%s\"\r,\
                                          \r\n",
                                          mac_addr[0], mac_addr[1], mac_addr[2], mac_addr[3], mac_addr[4], mac_addr[5],
                                          (int)(ip_addr & 0x000000FFu),
                                          (int)((ip_addr >> 8u) & 0x000000FFu),
                                          (int)((ip_addr >> 16u) & 0x000000FFu),
                                          (int)((ip_addr >> 24u) & 0x000000FFu),
                                          mac_speed_lut[g_ethernet_status.speed]);

            		  json_resp_size += snprintf(&status_json[json_resp_size], sizeof(status_json),
                                           "\"CurrentRTCTime\": \"%02d:%02d:%02d\", ",
                                           calendar_count->hour,
                                           calendar_count->minute,
                                           calendar_count->second);

            		  json_resp_size += snprintf(&status_json[json_resp_size], sizeof(status_json),
                                           "\"Current_RTC_Date\": \"%02d/%02d/20%02d\" }\r\n",
                                           calendar_count->day,
                                           calendar_count->month,
                                           calendar_count->year);

            		  assert(json_resp_size < sizeof(status_json));
            		  if(json_resp_size > sizeof(status_json))
            		  {
            			  json_resp_size = sizeof(status_json);
            		  }

            		  //    Send the HTML header
            		  //  * subtract 1 from the size, since we dont send the \0 in the string
            		  //  * NETCONN_NOCOPY: our data is const static, so no need to copy it

            		  netconn_write(conn, http_json_hdr, sizeof(http_json_hdr)-1, NETCONN_NOCOPY);

            		  //  Send our HTML page
            		  netconn_write(conn, status_json, json_resp_size-1, NETCONN_NOCOPY);
					  }

					 else if(buf[5]=='i')
					  {
						  netconn_write(conn, mscc_jpg_logo, sizeof(mscc_jpg_logo)-1, NETCONN_NOCOPY);
					  }
					  else if(buf[5]=='t')
					  {
						  handle_trigger_request(&buf[5], buflen - 5);
						  netconn_write(conn, http_html_ok_hdr, sizeof(http_html_ok_hdr)-1, NETCONN_NOCOPY);
					  }
					 else

					 { /* Send the HTML header
        	                       * subtract 1 from the size, since we dont send the \0 in the string
        	                       * NETCONN_NOCOPY: our data is const static, so no need to copy it
        	                  */
						 netconn_write(conn, http_html_hdr, sizeof(http_html_hdr)-1, NETCONN_NOCOPY);

        	            //      /* Send our HTML page */
        	            netconn_write(conn, http_index_html2, sizeof(http_index_html2)-1, NETCONN_NOCOPY);

					 }
			 }
        	 else if( !strncmp( buf, "GET /LED", 8 ) )
					 {

						 snprintf((char *)uip_appdata, 1200,

																	"<META content=\"MSHTML 6.00.2900.5726\" name=GENERATOR></HEAD>"
						             	        		 			"<BODY>"
						             	        		 			"<FORM action=LED method=get>"
						             	        		 			"<TABLE class=tbl_text height=\"32%\" cellSpacing=1 cellPadding=1 width=\"40%\""
						             	        		 			"align=center>"
						             	        		 			  "<TBODY>"
						             	        		 			"<form name=\"input\" method=\"get\">"
																	 "<p style=\"text-align: center; font-size:22px; color:#333333;font-weight: bold; \">Blinking LED's </p>"
																	 "<p style=\"text-align: center;font-size: 18px; color:  #003399;\">LEDs on the board should blink once from 1 to 255 <br>"
																	 "To blink LEDs manually enter any value between 1 to 255 :"
						             	        		 			"<input type=\"text\" maxlength=3 name=\" INPUTSTRING \" />"
						             	        		 			"<input type=\"submit\" value=\"Submit\" /></p><br>"
						             	        		 			"</form>"
						             	        		 			"<form>"
								                                    "<p style=\"text-align: center;\">"
                                                                     "<input type = \"Button\" value = \"Home\" onclick = \"window.location.href='index.html'\"></p>"
						             	        		 			"</form>"
						             	        		 			"</TBODY></TABLE></FORM></BODY></HTML> \n"
						             	        		 			);
        		        netconn_write(conn, http_html_hdr, sizeof(http_html_hdr)-1, NETCONN_NOCOPY);
        		        netconn_write( conn, uip_appdata, sizeof(uip_appdata), NETCONN_COPY );
        		        if( !strncmp(buf, "GET /LED?+INPUTSTRING+=", 23))
        		        		{
        		        	     leddata=0;
        		        	     Led_string[0]=0;
        		        	     Led_string[1]=0;
								tempStrPtr2 = buf + 23;
								for (i = 0; i < 3; i++)
								      {
								          c = *tempStrPtr2++;
								          if (c == ' ')
								           break;
								          if (c == '+')
								           {
								           c = ' ';
								           }
								          else if (c == '%') {
								         unsigned char temp1,temp2;
								        temp1=(*tempStrPtr2++);
								        temp2=(*tempStrPtr2++);
								         c = hex_digits_to_byte(temp1,temp2);
								         }
								          Led_string[i] = c;
								        }
										Led_string[i] = '\0';
										if(Led_string[1]==0)
										{
											leddata=Led_string[0];
											leddata=leddata-48;
										}
										else if(Led_string[2]==0)
										{
										leddata=10*(Led_string[0]-48)+(Led_string[1]-48);
										}
										else
										{
										leddata=100*(Led_string[0]-48)+10*(Led_string[1]-48)+(Led_string[2]-48);
										}
										MSS_GPIO_set_outputs(leddata);
										uint32_t gpio_pattern;
										gpio_pattern=leddata;
										gpio_pattern = MSS_GPIO_get_outputs();
										gpio_pattern = MSS_GPIO_get_outputs();
        		        		}
        		        else
        		        {
        		       	 led_test();
        		        }
				 }
						 else if( !strncmp( buf, "GET /google_search.htm", 22 ) )
						 {
						 netconn_write(conn, http_html_hdr, sizeof(http_html_hdr)-1, NETCONN_NOCOPY);
            	         netconn_write( conn, data_google_htm, sizeof( data_google_htm), NETCONN_COPY );
            	        }

						 /*else if( !strncmp( buf, "GET /Gadgets.htm", 16) )
            	        			{
							 const static char data_Gadgets_html[]="<HTML>\
							 <head><title>SmartFusion2 Gadgets</title></head>\
							 <body><table width=\"100%\" cellspacing=\"1\">\
							 <tr><td height=\"15\"></td></tr>\
							 <tr><td colspan=\"5\" align=\"center\" ><b><font color=\"#333333\"><font size=\"5\">SmartFusion2 Gadgets</font></font><b>\
							 </td></tr>\
							 <tr><td><script src=\"http://www.gmodules.com/ig/ifr?url=http://www.throttled.org/googlegadgets/youtubesearch.xml\"></script></td>\
							 <tr><td><script src=\"http://www.gmodules.com/ig/ifr?url=http://adwebmaster.net/datetimemulti/datetimemulti.xml&amp;up_color=medgreen&amp;up_txtcolor=softnavy&amp;up_lang=en&amp;up_formattime=24%3A00%3A00&amp;up_formatdisplaytime=12&amp;up_timezoneadd=0&amp;up_startcalendar=0&amp;up_elementscached=1&amp;up_affactualtime=1&amp;up_afftimesec=1&amp;up_affcalendar=1&amp;up_affcalendarlongday=0&amp;up_affbigpub022009=1&amp;up_formattempshorloge=analogue&amp;synd=open&amp;w=368&amp;h=215&amp;title=Clock+%2B+Calander&amp;lang=en&amp;country=ALL&amp;border=%23ffffff%7C3px%2C1px+solid+%23999999&amp;output=js\"></script></td>\
							 <td align=\"center\"><script src=\"http://www.gmodules.com/ig/ifr?url=http://aruljohn.com/gadget/zip.xml&amp;synd=open&amp;w=320&amp;h=120&amp;title=US+Zip+Code+Lookup&amp;border=%23ffffff%7C3px%2C1px+solid+%23999999&amp;output=js\"></script></td>\
							 <tr><td></td></tr>\
							 <tr><td></td><td class=\"tmp\" colspan=\"2\" align=\"center\">\
							 <form><input type = \"Button\" value = \"Home\" onclick = \"window.location.href='index.html'\"></form>\
							 </td><td></td></tr>\
							 </table></form>\
							 </body></HTML>";

									netconn_write(conn, http_html_hdr, sizeof(http_html_hdr)-1, NETCONN_NOCOPY);
            	        			netconn_write( conn, data_Gadgets_html, sizeof( data_Gadgets_html), NETCONN_COPY );
            	        			}*/
						 else if( !strncmp( buf, "GET /HyperTerminal", 18) )
            	        	       {

											 snprintf((char *)uip_appdata, 1200,

            	        		 			"<META content=\"MSHTML 6.00.2900.5726\" name=GENERATOR></HEAD>"
            	        		 			"<BODY>"
            	        		 			"<FORM action=HyperTerminal method=get>"
            	        		 			"<TABLE class=tbl_text height=\"32%\" cellSpacing=1 cellPadding=1 width=\"40%\""
            	        		 			"align=center>"
            	        		 			  "<TBODY>"
            	        		 			"<form name=\"input\" method=\"get\">"
													 //text-decoration: underline;
												"<p style=\"text-align: center; font-size:22px; color:#333333;font-weight: bold; \">HyperTerminal Display</p>"
												"<p style=\"text-align: center;font-size: 18px; color:  #003399;\">Enter string to display on HyperTerminal:"
            	        		 			"<input type=\"text\" maxlength=19 name=\" INPUTSTRING \" />"
            	        		 			"<input type=\"submit\" value=\"Submit\" /></p>"
            	        		 			"</form>"
            	        		 			"<form>"
											 "<p style=\"text-align: center;\">"
            	        		 			"<input type = \"Button\" value = \"Home\" onclick = \"window.location.href='index.html'\"></p>"
            	        		 			"</form>"
            	        		 			"</TBODY>"
            	        		 			"</TABLE>"
            	        		 			"</FORM>"
            	        		 			"</BODY>"
            	        		 			"</HTML>");
            	        		 netconn_write(conn, http_html_hdr, sizeof(http_html_hdr)-1, NETCONN_NOCOPY);
            	        	     netconn_write( conn, uip_appdata, sizeof( uip_appdata), NETCONN_COPY );

            	        	     if( !strncmp(buf, "GET /HyperTerminal?+INPUTSTRING+=", 33 ))
            	        	     			{
            	        	     				tempStrPtr = buf + 33;
            	        	     				    for (i = 0; i < 20; i++)
            	        	     				    {
            	        	     					c = *tempStrPtr++;
            	        	     					if (c == ' ')
            	        	     					break;
            	        	     					if (c == '+')
            	        	     					{
            	        	     					    c = ' ';
            	        	     					}
            	        	     					else if (c == '%') {
            	        	     						unsigned char temp1,temp2;
            	        	     						temp1=(*tempStrPtr++);
            	        	     						temp2=(*tempStrPtr++);
            	        	     					    c = hex_digits_to_byte(temp1,temp2);
            	        	     					}
            	        	     					Hyper_string[i] = c;
            	        	     				    }
            	        	     				    Hyper_string[i] = '\0';
            	        	     		            snprintf((char *)String, sizeof(String),"\r\n Submitted string is %s\n\r \r\n",
            	        	     		            		Hyper_string);
            	        	     		             send_msg((const uint8_t*)String);
//            	        	                         iprintf("Submitted string is %s\n\r",Hyper_string);
            	        	     			}
            	        	            	  }
            	        	else
            	        			{
            	        				netconn_write(conn, http_html_hdr, sizeof(http_html_hdr)-1, NETCONN_NOCOPY);

            	        				/* Send our HTML page */
            	        				netconn_write(conn, http_index_html, sizeof(http_index_html)-1, NETCONN_NOCOPY);
            	        				if(!strncmp( buf, "GET /index_r1_c1", 16 ))
            	        				 netconn_write(conn, mscc_jpg_logo, sizeof(mscc_jpg_logo)-1, NETCONN_NOCOPY);
            	        			}
        }
        else if (buflen>=6 &&
                 buf[0]=='P' &&
                 buf[1]=='O' &&
                 buf[2]=='S' &&
                 buf[3]=='T' &&
                 buf[4]==' ' &&
                 buf[5]=='/' )
        {
        
        err = netconn_recv(conn, &inbuf);
        
        ++err;
        
       /*  Send the HTML header
             * subtract 1 from the size, since we dont send the \0 in the string
             * NETCONN_NOCOPY: our data is const static, so no need to copy it*/

        netconn_write(conn, http_post_resp_hdr, sizeof(http_post_resp_hdr)-1, NETCONN_NOCOPY);
    }


    }
    /* Close the connection (server closes in HTTP) */
    netconn_close(conn);
  
    /* Delete the buffer (netconn_recv gives us ownership,
      so we have to make sure to deallocate the buffer) */
    netbuf_delete(inbuf);
}
unsigned char hex_digits_to_byte(unsigned char u, unsigned char l)
{
    if (u > '9')
	u = u - 'A' + 10;
    else
	u = u - '0';
    if (l > '9')
	l = l - 'A' + 10;
    else
	l = l - '0';
    return (u << 4) + l;
}
/** The main function, never returns! */
void
http_server_netconn_thread(void *arg)
{
    struct netconn *conn, *newconn;
    err_t err;
    ethernet_status_t ethernet_status;

    portBASE_TYPE queue_rx;

    g_ethernet_status.speed = TSE_MAC10MBPS;
    g_ethernet_status.duplex_mode = 0xFFU;
  
    MSS_RTC_init(MSS_RTC_CALENDAR_MODE, RTC_PRESCALER);
    MSS_RTC_start();

    /* Create a new TCP connection handle */
    conn = netconn_new(NETCONN_TCP);
    LWIP_ERROR("http_server: invalid conn", (conn != NULL), return;);
  
    /* Bind to port 80 (HTTP) with default IP address */
    netconn_bind(conn, NULL, 80);
  
    /* Put the connection into LISTEN state */
    netconn_listen(conn);
  
    do {
        mss_rtc_calendar_t calendar_count;
        uint32_t rtc_count_updated;
        
        rtc_count_updated = MSS_RTC_get_update_flag();
        if(rtc_count_updated)
        {
            MSS_RTC_get_calendar_count(&calendar_count);
            MSS_RTC_clear_update_flag();
        }
        
        queue_rx = xQueueReceive(xEthStatusQueue, &ethernet_status, 0);
               if(pdPASS == queue_rx)
               {
                   g_ethernet_status.speed = ethernet_status.speed;
                   g_ethernet_status.duplex_mode = ethernet_status.duplex_mode;
               }

        err = netconn_accept(conn, &newconn);
        if (err == ERR_OK)
        {
            http_server_netconn_serve(newconn, &calendar_count);

            netconn_delete(newconn);
        }
    } while(err == ERR_OK);
    LWIP_DEBUGF(HTTPD_DEBUG,
                ("http_server_netconn_thread: netconn_accept received error %d, shutting down",
                err));
    netconn_close(conn);
    netconn_delete(conn);
}

/** Initialize the HTTP server (start its thread) */
void
http_server_netconn_init(void)
{
  sys_thread_new("http_server_netconn", http_server_netconn_thread, NULL, DEFAULT_THREAD_STACKSIZE, DEFAULT_THREAD_PRIO);
}

/** */
void handle_trigger_request(char * buf, u16_t len)
{
    unsigned int trigger_id;
    unsigned int seconds = 1;
    int idx;
    int time[3] = {0, 0, 0};
    int time_inc = 0;
    
    trigger_id = buf[7] - '0';
    if(trigger_id < 3)
    {
        /* Parse request for the trigger's seconds value. */
        idx = 14;
        while((buf[idx] != '&') && (idx < len) && (time_inc < 3))
        {
            if('%' == buf[idx])
            {
                idx += 3;   /* skip %3A. */
                ++time_inc;
            }
            else
            {
                if((buf[idx] >= '0') && (buf[idx] <= '9'))
                {
                    time[time_inc] = (time[time_inc] * 10) + buf[idx] - '0';
                    ++idx;
                }
                else
                {   /* Invalid character found in request. */
                    seconds = 0;
                    idx = len;
                }
            }
        }
        
        if(seconds != 0)
        {
            mss_rtc_calendar_t new_calendar_time;
            
            MSS_RTC_get_calendar_count(&new_calendar_time);
            if(0 == trigger_id)
            {
                new_calendar_time.hour = (uint8_t)time[0];
                new_calendar_time.minute = (uint8_t)time[1];
                new_calendar_time.second = (uint8_t)time[2];
            }
            else if(1 == trigger_id)
            {
                if((time[0] > 0) && (time[0] <= 31))
                {
                    new_calendar_time.day = (uint8_t)time[0];
                }
                if((time[1] > 0) && (time[1] <= 12))
                {
                    new_calendar_time.month = (uint8_t)time[1];
                }
                if((time[2] > 0) && (time[2] <= 255))
                {
                    new_calendar_time.year = (uint8_t)time[2];
                }
            }
            MSS_RTC_set_calendar_count(&new_calendar_time);
        }
    }
}

#endif /* LWIP_NETCONN*/
