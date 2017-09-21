Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45036 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751617AbdIUKCx (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 21 Sep 2017 06:02:53 -0400
Date: Thu, 21 Sep 2017 12:02:48 +0200
From: Karel Zak <kzak@redhat.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux stable v2.30.2
Message-ID: <20170921100248.yzese7tkikyapxqo@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


The util-linux stable maintenance release v2.30.2 is available at
 
  http://www.kernel.org/pub/linux/utils/util-linux/v2.30/
 
Feedback and bug reports, as always, are welcomed.
 

util-linux 2.30.2 Release Notes
===============================

blockdev:
   - document --setro more properly  [Karel Zak]
cfdisk:
   - add missing 0x7F key mapping  [Karel Zak]
dmesg:
   - fix delimiter calculation  [Karel Zak]
docs:
   - update AUTHORS file  [Karel Zak]
fstab(5):
   - mention how tabs are escaped  [Andreas Henriksson]
lib/randutils:
   - improve getrandom() usage  [Karel Zak]
   - reset lose counter  [Karel Zak]
   - Fall back gracefully when kernel doesn't support getrandom(2).  [Christopher James Halse Rogers]
   - More paranoia in getrandom() call.  [Christopher James Halse Rogers]
libblkid:
   - don't check for size on UBI (char dev)  [Karel Zak]
   - fix compiler warning [-Wformat-truncation=]  [Karel Zak]
libfdisk:
   - (dos) use size-=1 when alignment not used later  [Karel Zak]
   - (gpt) fix size-1 error  [Karel Zak]
   - fix fdisk_reset_partition() leaking *_chs strings.  [Vaclav Dolezal]
   - fix two potential memory errors.  [Vaclav Dolezal]
login:
   - use IPv4 on IPv4-mapping-to-IPv6  [Karel Zak]
lslogins:
   - be more explicit with -g in man page  [Karel Zak]
   - ignore non-existing users  [Karel Zak]
po:
   - fix ipcrm translation error fr.po  [Karel Zak]
   - merge changes  [Karel Zak]
   - update cs.po (from translationproject.org)  [Petr Písař]
   - update es.po (from translationproject.org)  [Antonio Ceballos Roa]
   - update fr.po (from translationproject.org)  [Stéphane Aulery]
swaplabel:
   - fix --disable-libuuid compilation  [Karel Zak]
wdctl:
   - do not call fsync(2) when closing watchdog device  [Sami Kerola]

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
