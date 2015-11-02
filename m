Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40168 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752066AbbKBLIt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 2 Nov 2015 06:08:49 -0500
Date: Mon, 2 Nov 2015 12:08:47 +0100
From: Karel Zak <kzak@redhat.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.27.1
Message-ID: <20151102110754.GH19508@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The util-linux release v2.27.1 is available at

  ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.27

Feedback and bug reports, as always, are welcomed.

    Karel


util-linux 2.27.1 Release Notes
===============================

bash-completion:
   - curly brace missed for findmnt  [Alexander Kuleshov]
docs:
   - update AUTHORS file  [Karel Zak]
fdisk:
   - fix -N internal return code  [Karel Zak]
   - to recognize Intel Rapid Start hibernation partition  [Jörg Jenderek]
   - to recognize partition type 0xEA (Rufus)  [Jörg Jenderek]
include/pt-mbr-partnames:
   - remove '|' from partition type name  [Karel Zak]
ipcs:
   - fix ipc_sem_get_limits()  [Karel Zak]
lib/sysfs:
   - make sysfs_get_devname()/blkid_devno_to_wholedisk() more robust  [Karel Zak]
libblkid:
   - (promise raid) cleanup code  [Karel Zak]
   - make XFS Log visible for wipefs  [Karel Zak]
libfdisk:
   - (gpt) control ranges in set_partition  [Karel Zak]
   - add more debug message to resize code  [Karel Zak]
   - fix partition move/resize code  [Karel Zak]
libmount:
   - (monitor) don't check for regular mtab  [Karel Zak]
   - (monitor) remove unnecessary epoll EPOLLPRI  [Karel Zak]
   - fix uid= and gid= translation  [Karel Zak]
   - follow docs with parse-error callback return code  [Karel Zak]
libuuid:
   - fix buffer overflow with long paths  [Karel Zak]
logger:
   - fix messages separation on UNIX socket  [Karel Zak]
mount, umount, swapon, fsck, lsblk, findmnt:
   - ignore malformed lines  [Karel Zak]
po:
   - merge changes  [Karel Zak]
   - update cs.po (from translationproject.org)  [Petr Písař]
   - update de.po (from translationproject.org)  [Philipp Thomas]
   - update pt_BR.po (from translationproject.org)  [Rafael Ferreira]
   - update ru.po (from translationproject.org)  [Evgeniy Yakushev]
   - update zh_CN.po (from translationproject.org)  [Wylmer Wang]
script:
   - be pedantic and use "%"SCNi64  [Karel Zak]
   - don't assume that time_t is compatible with long  [Isaac Dunham]
tests:
   - add missing files  [Karel Zak]
   - replace username with tag in logger test  [Karel Zak]
   - update and extend logger tests  [Karel Zak]
uuidd:
   - improve socket activation error messaging  [Sami Kerola]
zramctl:
   - fix lists of the all devices  [Karel Zak]


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
