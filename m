Return-Path: util-linux-owner@vger.kernel.org
Received: from nagini.codelibre.net ([80.68.93.164]:59483 "EHLO
	nagini.codelibre.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522Ab1K0W2Z (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 27 Nov 2011 17:28:25 -0500
Date: Sun, 27 Nov 2011 22:19:56 +0000
From: Roger Leigh <rleigh@codelibre.net>
To: util-linux@vger.kernel.org
Subject: Using /etc/fstab.d
Message-ID: <20111127221956.GF17458@codelibre.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi folks,

I noticed that support had recently been added for /etc/fstab.d.
In Debian, we're configuring with --enable-libmount-mount, but
I'm not seeing it being used; strace shows no opendir/stat calls
for it.  Is anything else necessary to enable it, or is it not
yet actually used by mount?

I've just created a file /etc/fstab.d/test.fstab, and then
tried "mount /foo", where /foo would be the entry in test.fstab,
but don't see anything happening.


Thanks,
Roger

-- 
  .''`.  Roger Leigh
 : :' :  Debian GNU/Linux             http://people.debian.org/~rleigh/
 `. `'   Printing on GNU/Linux?       http://gutenprint.sourceforge.net/
   `-    GPG Public Key: 0x25BFB848   Please GPG sign your mail.
