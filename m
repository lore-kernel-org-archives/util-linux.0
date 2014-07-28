Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:26176 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751674AbaG1LMV (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 28 Jul 2014 07:12:21 -0400
Date: Mon, 28 Jul 2014 13:12:14 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: kerolasa@gmail.com, Util-Linux <util-linux@vger.kernel.org>
Subject: Re: hwclock --compare segfaults when run as normal user
Message-ID: <20140728111214.GI8533@x2.net.home>
References: <1406378420.29449.145898149.3B1EDA38@webmail.messagingengine.com>
 <CAG27Bk2SkstBkDGR9EiP0UENK1qag0VZ31tLZsjvgCxRss2bpw@mail.gmail.com>
 <1406390709.8686.145937949.0F0BF57C@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406390709.8686.145937949.0F0BF57C@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jul 26, 2014 at 06:05:09PM +0200, Benno Schulenberg wrote:
> 
> On Sat, Jul 26, 2014, at 16:48, Sami Kerola wrote:
> > On 26 July 2014 13:40, Benno Schulenberg <bensberg@justemail.net> wrote:
> > > On my system there is no /etc/adjtime file, and then:
> > >
> > > $ ./hwclock --compare
> > > Segmentation fault
> > 
> > I tried to reproduce the issue without success. If you have core file

because you have RTC and Benno has cmos I guess

> > could you try to gdb backtrace it?

> 
> (gdb) run --compare
> Starting program: /home/ben/util-linux-2.25/hwclock --compare
> 
> Program received signal SIGSEGV, Segmentation fault.
> 0x0804cf71 in outb () at /usr/include/sys/io.h:99
> 99	  __asm__ __volatile__ ("outb %b0,%w1": :"a" (__value), "Nd" (__port));
> 
> (gdb) bt
> #0  0x0804cf71 in outb () at /usr/include/sys/io.h:99
> #1  cmos_read () at sys-utils/hwclock-cmos.c:348
> #2  atomic () at sys-utils/hwclock-cmos.c:307
> #3  hclock_read () at sys-utils/hwclock-cmos.c:456

 I have no way how to to test it, but can you try the patch below?

  Karel


>From 8fe55779b04e961d9e99bba7e1df382b71b63095 Mon Sep 17 00:00:00 2001
From: Karel Zak <kzak@redhat.com>
Date: Mon, 28 Jul 2014 13:00:54 +0200
Subject: [PATCH] hwclock: check for permissions before use clock interface

Reported-by: Benno Schulenberg <bensberg@justemail.net>
Signed-off-by: Karel Zak <kzak@redhat.com>
---
 sys-utils/hwclock.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index a934ace..474e04f 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1495,6 +1495,9 @@ static int compare_clock (const bool utc, const bool local_opt)
 	bool hclock_valid = FALSE, universal, first_pass = TRUE;
 	int rc;
 
+	if (ur->get_permissions())
+		return EX_NOPERM;
+
 	/* dummy call for increased precision */
 	gettimeofday(&tv, NULL);
 
@@ -1893,7 +1896,7 @@ int main(int argc, char **argv)
 	}
 
 	if (!(show | set | systohc | hctosys | systz | adjust | getepoch
-	      | setepoch | predict))
+	      | setepoch | predict | compare))
 		show = 1;	/* default to show */
 
 	if (getuid() == 0)
-- 
1.9.3
