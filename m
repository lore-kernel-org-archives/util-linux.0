Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36719 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753917AbdFVWiX (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 22 Jun 2017 18:38:23 -0400
Received: by mail-lf0-f66.google.com with SMTP id f28so4431754lfi.3
        for <util-linux@vger.kernel.org>; Thu, 22 Jun 2017 15:38:22 -0700 (PDT)
Received: from HomePC.localdomain ([178.68.235.121])
        by smtp.gmail.com with ESMTPSA id n71sm764819lje.14.2017.06.22.15.38.20
        for <util-linux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Jun 2017 15:38:21 -0700 (PDT)
Date: Fri, 23 Jun 2017 01:38:12 +0300
From: Daniil Zhilin <just4steam778@gmail.com>
To: util-linux@vger.kernel.org
Subject: agetty doesn't handle the second backspace properly during login
Message-ID: <20170623013812.5cf11bec@HomePC.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello. When using the Colemak keyboard layout that assigns a second
backspace to Caps Lock, during TTY login this mapping generates '^H'
instead.

util-linux version 2.29.2-2 on Arch Linux.
