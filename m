Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60309 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753925AbaHFN1q (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 6 Aug 2014 09:27:46 -0400
Date: Wed, 6 Aug 2014 15:27:27 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>, Benno Schulenberg <bensberg@justemail.net>
Subject: add one-line descriptions to each program usage()
Message-ID: <20140806132727.GI19820@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


See commit:

https://github.com/stevenhoneyman/util-linux/commit/d5b828e418102b354025bbf7f91b2dcdfc1f4e66

the idea is to add one-line descriptions to each program usage().

Comments?

 IMHO it's not so bad idea, the description will be translated, and
 --help output more informative. Note that for example coreutils use it
 too.

 Anyway, the patch is not ready. I don't like the command name in the
 description -- it's redundant.

 Maybe it would be better to move the description above Options
 section. Something like

---
 Usage:
   fdisk [options] <disk>      change partition table
   fdisk [options] -l [<disk>] list partition table(s)

 Manipulate and list disk partition table.       <---!

 Options:
    -b, --sector-size <size>      physical and logical sector size
    ...
---

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
