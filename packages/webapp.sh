#!/bin/bash

print_msg "Installing webapp Whatsapp" && ${BLUEPILL_LOCAL}/bin/create_webapp.sh "WhatsApp" https://web.whatsapp.com/ whatsapp.svg && print_status ok || print_status ko
print_msg "Installing webapp ChatGPT"  && ${BLUEPILL_LOCAL}/bin/create_webapp.sh "ChatGPT" https://chatgpt.com/ chatgpt.svg && print_status ok || print_status ko
