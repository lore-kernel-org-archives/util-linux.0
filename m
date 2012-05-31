Return-Path: util-linux-owner@vger.kernel.org
Received: from fallback7.mail.ru ([94.100.176.135]:43910 "EHLO
	fallback7.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755897Ab2EaL6U (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Thu, 31 May 2012 07:58:20 -0400
Received: from smtp14.mail.ru (smtp14.mail.ru [94.100.176.91])
	by fallback7.mail.ru (mPOP.Fallback_MX) with ESMTP id 188B6981B45D
	for <util-linux-ng@vger.kernel.org>; Thu, 31 May 2012 15:52:37 +0400 (MSK)
Received: from [195.98.167.2] (port=43033 helo=superman)
	by smtp14.mail.ru with esmtpa (envelope-from <Athlon_@mail.ru>)
	id 1Sa3vL-0006w6-Jr
	for util-linux-ng@vger.kernel.org; Thu, 31 May 2012 15:52:15 +0400
From: "Athlon" <Athlon_@mail.ru>
To: <util-linux-ng@vger.kernel.org>
Subject: agetty: Incorrect handling of backspace characters 0x08, '#'
Date: Thu, 31 May 2012 15:51:44 +0400
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAAG61h4y0sXBFo4qW1m85MLbigAAAEAAAABADOXpxCm5HqJIMZeq/+PoBAAAAAA==@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Package: util-linux
Version: 2.21
Severity: normal

Hello.

Bug description:
1. Run agetty on a virtual console (tty1, ...).
2. Type in username: "root"
3. Input Alt+8 or #. The backspace character will proceed correctly, but it
will be printed as is instead of printing "\b \b".

Function get_logname (agetty.c) erases characters only if ECHO flag is off.
...
			case BS:
			case DEL:
			case '#':
				cp->erase = ascval; /* set erase character
*/
			if (bp > logname) {
					if ((tp->c_lflag & ECHO) == 0)
						write_all(1,
erase[cp->parity], 3);
					bp--;	
			}
...

But when running agetty on a virtual console function termio_init calls
reset_vc, that sets
tp->c_lflag |=  (ISIG | ICANON | IEXTEN | ECHO|ECHOE|ECHOK|ECHOKE);

So, backspace characters will be echoed on the console: "\b" moves cursor
left and '#' will be printed as is.


