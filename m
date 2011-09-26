Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:27636 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751281Ab1IZKwm (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 26 Sep 2011 06:52:42 -0400
Date: Mon, 26 Sep 2011 12:52:38 +0200
From: Karel Zak <kzak@redhat.com>
To: xinglp <xinglp@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: agetty not show username as I input on a serial term
Message-ID: <20110926105238.GA1982@nb.net.home>
References: <CAHQM782fzMjh+XAiTwea_02+qFQ-N-Z+Th3mox0HPkbWnwsV1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHQM782fzMjh+XAiTwea_02+qFQ-N-Z+Th3mox0HPkbWnwsV1Q@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Sep 02, 2011 at 02:26:17PM +0800, xinglp wrote:
> When I  login  on a serial term,  I type username, but nothing appear
> on the screen, just as input password.

[...]

> It looks like the "ECHO bit in termios.c_cflag" was not properly set
> before the get_logname() been called.

The code incorrectly checks c_cflag, but the ECHO is c_lflag flag
constant.

See the patch below. Thanks!

    Karel


>From b9261127260ff2a8efbdc6e5f9d00ec7f736b445 Mon Sep 17 00:00:00 2001
From: Karel Zak <kzak@redhat.com>
Date: Mon, 26 Sep 2011 12:34:10 +0200
Subject: [PATCH] agetty: test ECHO on c_lflag

Reported-by: xinglp <xinglp@gmail.com>
Addresses: http://bugzilla.redhat.com/show_bug.cgi?id=739522
Signed-off-by: Karel Zak <kzak@redhat.com>
---
 term-utils/agetty.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 8398015..75c2b14 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -1466,7 +1466,7 @@ static char *get_logname(struct options *op, struct termios *tp, struct chardata
 			case '#':
 				cp->erase = ascval; /* set erase character */
 				if (bp > logname) {
-					if ((tp->c_cflag & (ECHO)) == 0)
+					if ((tp->c_lflag & ECHO) == 0)
 						write_all(1, erase[cp->parity], 3);
 					bp--;
 				}
@@ -1475,7 +1475,7 @@ static char *get_logname(struct options *op, struct termios *tp, struct chardata
 			case '@':
 				cp->kill = ascval;		/* set kill character */
 				while (bp > logname) {
-					if ((tp->c_cflag & (ECHO)) == 0)
+					if ((tp->c_lflag & ECHO) == 0)
 						write_all(1, erase[cp->parity], 3);
 					bp--;
 				}
@@ -1487,7 +1487,7 @@ static char *get_logname(struct options *op, struct termios *tp, struct chardata
 					break;
 				if ((size_t)(bp - logname) >= sizeof(logname) - 1)
 					log_err(_("%s: input overrun"), op->tty);
-				if ((tp->c_cflag & (ECHO)) == 0)
+				if ((tp->c_lflag & ECHO) == 0)
 					write_all(1, &c, 1);	/* echo the character */
 				*bp++ = ascval;			/* and store it */
 				break;
-- 
1.7.6


