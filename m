Return-Path: util-linux-owner@vger.kernel.org
Received: from smtprelay-h21.telenor.se ([195.54.99.196]:46073 "EHLO
	smtprelay-h21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092AbaHXQFS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 24 Aug 2014 12:05:18 -0400
Received: from ipb5.telenor.se (ipb5.telenor.se [195.54.127.168])
	by smtprelay-h21.telenor.se (Postfix) with ESMTP id 3EA7E14275
	for <util-linux@vger.kernel.org>; Sun, 24 Aug 2014 18:05:15 +0200 (CEST)
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH 0/4] Patches for kFreeBSD support from Debian
Date: Sun, 24 Aug 2014 18:04:40 +0200
Message-Id: <1408896284-14467-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello!

This is the patch set that has been shipping since forever
in Debian (minus the last one from me, which is new).
The patches where against util-linux 2.20.x before
I rebased them against current master.

I've failed to get the original patch authors to sign off
and submit their own patches, but as discussed on irc
I'm forwarding them to you 'as is'.


Andreas Henriksson (1):
  kFreeBSD: add hacks in ipcrm to avoid FTBFS

Aurelien Jarno (1):
  remaining kFreeBSD hackery for building.

Christoph Egger (1):
  Fixing FTBFS on !linux (Debian util-linux 2.20.1-1.2)

Robert Millan (1):
  Report correct disk size on GNU/kFreeBSD. Thanks Tuco.

 include/ttyutils.h       | 40 ++++++++++++++++++++++++++++++++++++++++
 lib/blkdev.c             |  4 ++++
 sys-utils/ipcrm.c        |  7 +++++++
 sys-utils/ipcs.c         |  2 ++
 term-utils/Makemodule.am |  1 +
 term-utils/agetty.c      | 16 ++++++++++++++++
 6 files changed, 70 insertions(+)

-- 
2.1.0.rc1

