Return-Path: util-linux-owner@vger.kernel.org
Received: from gimli.pitney-fabs.co.uk ([87.106.140.52]:49090 "EHLO
	gimli.pitney-fabs.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753329Ab1LCRug (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 3 Dec 2011 12:50:36 -0500
Received: from host81-139-106-247.in-addr.btopenworld.com ([81.139.106.247] helo=golden.localdomain)
	by gimli.pitney-fabs.co.uk with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <walrond.andrew@gimli.pitney-fabs.co.uk>)
	id 1RWtCv-0000yP-0w
	for util-linux@vger.kernel.org; Sat, 03 Dec 2011 17:17:02 +0000
Date: Sat, 3 Dec 2011 17:16:59 +0000
From: Andrew Walrond <andrew@walrond.org>
To: util-linux@vger.kernel.org
Subject: agetty problem after upgrading v2.19.1 -> v2.20.1
Message-ID: <20111203171658.GA9780@golden.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


After upgrading from v2.19.1 to v2.20.1 I can't login from the terminal anymore and I see lots of these in the syslog:

Dec 03 16:57:11 [agetty] /dev/ttyS0: cannot get controlling tty: Operation not permitted

So having a quick look at the git logs I see this commit

commit 3aa6b68f7e19fa3e1c2bba75bee921a98b7b46af
Author: Werner Fink <werner@suse.de>
Date:   Mon May 9 15:52:36 2011 +0200

    agetty: proper session on the terminal line
    
    Ensure a proper session on the terminal line, that is do a
    vhangup() and become the controlling terminal.  After this
    determine if the terminal line a virtual console by using
    the ioctl TIOCMGET to get the status modem bits of a serial
    line which is a invalid argument on a virtual console.
    
    Signed-off-by: Werner Fink <werner@suse.de>

and these relevant changes:

-           /* Open the tty as standard input. */
+         if (((tid = tcgetsid(fd)) < 0) || (pid != tid)) {
+                 if (ioctl (fd, TIOCSCTTY, 1) == -1)
+                         log_err("/dev/%s: cannot get controlling tty: %m", tty);
+         }
+
+         if (op->flags & F_HANGUP) {
+                 /*
+                  * vhangup() will replace all open file descriptors in the kernel
+                  * that point to our controlling tty by a dummy that will deny
+                  * further reading/writing to our device. It will also reset the
+                  * tty to sane defaults, so we don't have to modify the tty device
+                  * for sane settings. We also get a SIGHUP/SIGCONT.
+                  */
+                 if (vhangup())
+                         log_err("/dev/%s: vhangup() failed: %m", tty);
+                 (void)ioctl(fd, TIOCNOTTY);
+         }
+
+         (void) close(fd);
                close(STDIN_FILENO);
                errno = 0;
 
                debug("open(2)\n");
-           if (open(tty, O_RDWR | O_NONBLOCK, 0) != 0)
-                   log_err(_("/dev/%s: cannot open as standard input: %m"),
-                         tty);
+         if (open(buf, O_RDWR|O_NOCTTY|O_NONBLOCK, 0) != 0)
+                 log_err(_("/dev/%s: cannot open as standard input: %m"), tty);
+         if (((tid = tcgetsid(STDIN_FILENO)) < 0) || (pid != tid)) {
+                 if (ioctl (STDIN_FILENO, TIOCSCTTY, 1) == -1)
+                         log_err("/dev/%s: cannot get controlling tty: %m", tty);
+         }
+

which all looks pretty valid to me, but is obviously the source of my problems.
So, before I do a brain dump and reload the knotty TTY knowledge back in to my brain to investigate, does anything obvious occur to anyone?

TIA

Andrew Walrond
