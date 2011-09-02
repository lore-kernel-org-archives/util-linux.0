Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ew0-f46.google.com ([209.85.215.46]:34048 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933132Ab1IBG0T (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 2 Sep 2011 02:26:19 -0400
Received: by ewy4 with SMTP id 4so1364560ewy.19
        for <util-linux@vger.kernel.org>; Thu, 01 Sep 2011 23:26:17 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 2 Sep 2011 14:26:17 +0800
Message-ID: <CAHQM782fzMjh+XAiTwea_02+qFQ-N-Z+Th3mox0HPkbWnwsV1Q@mail.gmail.com>
Subject: agetty not show username as I input on a serial term
From: xinglp <xinglp@gmail.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I'm using util-linux-2.20.

/etc/inittab has the line below:
s0:2345:respawn:/sbin/agetty ttyS0 9600 --long-hostname --noclear

When I  login  on a serial term,  I type username, but nothing appear
on the screen, just as input password.

Only when input a wrong password, and try again, I can see the
username as I typed,
but that was done by /bin/login

It looks like the "ECHO bit in termios.c_cflag" was not properly set
before the get_logname() been called.

called at term-utils/agetty.c line 391
