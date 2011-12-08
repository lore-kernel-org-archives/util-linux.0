Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:19406 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750773Ab1LHMEl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 8 Dec 2011 07:04:41 -0500
Date: Thu, 8 Dec 2011 13:04:38 +0100
From: Karel Zak <kzak@redhat.com>
To: Andrew Walrond <andrew@walrond.org>
Cc: util-linux@vger.kernel.org
Subject: Re: agetty problem after upgrading v2.19.1 -> v2.20.1
Message-ID: <20111208120438.GB8278@nb.redhat.com>
References: <20111203171658.GA9780@golden.localdomain> <20111204120548.GA23245@golden.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111204120548.GA23245@golden.localdomain>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Dec 04, 2011 at 12:05:49PM +0000, Andrew Walrond wrote:
> After reading the following from Andries Brouwer's excellent "The Linux Kernel",
>      http://www.win.tue.nl/~aeb/linux/lk/lk-10.html#ss10.3
> 
> >
> > How does one get a controlling terminal? Nobody knows, this is a great mystery.
> >
> > The System V approach is that the first tty opened by the process becomes its controlling tty.
> >
> > The BSD approach is that one has to explicitly call
> >
> >    ioctl(fd, TIOCSCTTY, ...);
> >
> > to get a controlling tty.
> >
> > Linux tries to be compatible with both, as always, and this results in a very obscure complex of conditions. Roughly:
> >
> > The TIOCSCTTY ioctl will give us a controlling tty, provided that (i) the current process is a session leader, and (ii) it does not yet have a controlling tty, and (iii) maybe the tty should not already control some other session; if it does it is an error if we aren't root, or we steal the tty if we are all-powerful.
> >
> > Opening some terminal will give us a controlling tty, provided that (i) the current process is a session leader, and (ii) it does not yet have a controlling tty, and (iii) the tty does not already control some other session, and (iv) the open did not have the O_NOCTTY flag, and (v) the tty is not the foreground VT, and (vi) the tty is not the console, and (vii) maybe the tty should not be master or slave pty." 
> >
> 
> it seems obvious that agetty is always going to fail unless it has
> already been made a session leader by the caller. Indeed, modifying
> init to call setsid() before exec'ing agetty makes everything work

 BTW, what initd are using?

> again.  What's not so obvious to me is whether agetty should always
> expect this, or become a session leader of it's own accord.

 I think this (session initialization) belongs to login(1) rather than
 to getty -- so it's should be optional and not strictly required.
 Note that agetty before v2.20 was without TIOCSCTTY at all.

 I have committed the patch below. Try it.

 Thanks for your report!

    Karel



>From 1593b134ebf596ae7a2b1e73f2dcc8c4e7febddd Mon Sep 17 00:00:00 2001
From: Karel Zak <kzak@redhat.com>
Date: Thu, 8 Dec 2011 11:39:05 +0100
Subject: [PATCH] agetty: don't use log_err() for non-fatal errors

The TIOCSCTTY ioctl requires that caller is session leader -- so it
depends on initd (or we have to add setsid() to aggety). It seems that the
traditional way is to setup tty in agetty and session in login(1).

It means that all session related things (TIOCSCTTY, vhangup, ...) in the
command agetty should be optional. (Note that vhangup() is called when
--hangup is explicitly specified on command line, so log_err() makes
sense there.)

Reported-by: Andrew Walrond <andrew@walrond.org>
Signed-off-by: Karel Zak <kzak@redhat.com>
---
 term-utils/agetty.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 079a737..3500a8e 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -925,7 +925,7 @@ static void open_tty(char *tty, struct termios *tp, struct options *op)
 
 		if (((tid = tcgetsid(fd)) < 0) || (pid != tid)) {
 			if (ioctl(fd, TIOCSCTTY, 1) == -1)
-				log_err("/dev/%s: cannot get controlling tty: %m", tty);
+				log_warn("/dev/%s: cannot get controlling tty: %m", tty);
 		}
 
 		if (op->flags & F_HANGUP) {
@@ -950,7 +950,7 @@ static void open_tty(char *tty, struct termios *tp, struct options *op)
 			log_err(_("/dev/%s: cannot open as standard input: %m"), tty);
 		if (((tid = tcgetsid(STDIN_FILENO)) < 0) || (pid != tid)) {
 			if (ioctl(STDIN_FILENO, TIOCSCTTY, 1) == -1)
-				log_err("/dev/%s: cannot get controlling tty: %m", tty);
+				log_warn("/dev/%s: cannot get controlling tty: %m", tty);
 		}
 
 	} else {
-- 
1.7.6.4
