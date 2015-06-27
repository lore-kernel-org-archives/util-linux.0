Return-Path: util-linux-owner@vger.kernel.org
Received: from que31.charter.net ([209.225.8.23]:43884 "EHLO que31.charter.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751249AbbF0AvJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 26 Jun 2015 20:51:09 -0400
To: util-linux@vger.kernel.org
Subject: [PATCH] wall: Print time and date (rather than just time) in wall banner
Message-Id: <E1Z8e57-0003js-1r@bb>
From: Dave Rutherford <dave@evilpettingzoo.com>
Date: Fri, 26 Jun 2015 20:34:53 -0400
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

This is a simple change to print the date and time in the wall banner.
Previously just the time was printed.  This made more sense during the era
of scarce and/or real terminals with interactive sessions of brief usage,
when a terminal was likely to be attended, but makes less sense in the era
of long-lived x-terminals, screen sessions, and so forth.  The latter may
be left open for days or weeks at a time, and returning to one it may no
longer be obvious just when a wall message was sent.  This can be relevant.

This adds the seconds and the date (locale-appropriate format) to the
wall banner, if any.

Regards,
   Dave Rutherford <dave@evilpettingzoo.com>


$ diff -u term-utils/wall.c.orig term-utils/wall.c
--- term-utils/wall.c.orig      2015-06-25 04:31:10.957160529 -0400
+++ term-utils/wall.c   2015-06-26 01:45:04.150729302 -0400
@@ -238,8 +238,9 @@
                sprintf(lbuf, _("Broadcast Message from %s@%s"),
                              whom, hostname);
                fprintf(fp, "%-79.79s\007\007\r\n", lbuf);
-               sprintf(lbuf, "        (%s) at %d:%02d ...",
-                             where, lt->tm_hour, lt->tm_min);
+               cnt = sprintf(lbuf, "        (%s) at ", where);
+               mbuf = lbuf + cnt;
+               strftime(mbuf, 79-cnt, "%T %x ...", lt);
                fprintf(fp, "%-79.79s\r\n", lbuf);
        }
        fprintf(fp, "%79s\r\n", " ");

