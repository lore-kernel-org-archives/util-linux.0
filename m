Return-Path: util-linux-owner@vger.kernel.org
Received: from mailout.micron.com ([137.201.242.129]:21660 "EHLO
        mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751887AbdKNAph (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 13 Nov 2017 19:45:37 -0500
From: <jgroves@micron.com>
To: Karel Zak <kzak@redhat.com>
CC: <util-linux@vger.kernel.org>, <John@Groves.net>,
        John Groves <jgroves@micron.com>
Subject: [PATCH 0/2] libblkid: recognize Micron mpool formatted devices
Date: Mon, 13 Nov 2017 18:45:11 -0600
Message-ID: <1510620313-6045-1-git-send-email-jgroves@micron.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: John Groves <jgroves@micron.com>

This patch adds libblkid recognition of Micron mpool formatted devices.
It also adds a very simple crc32c() function, for use by probe_mpool().

If there are objections to adding crc32c, I can re-submit without it, or
make it static for probe_mpool(). I would prefer not to go without crc32c
validation, because the only remaining check would be the magic number.

Review comments and/or questions welcome.

Thanks,

John Groves (2):
  Add simple crc32c() function
  Add support for Micron mpool formatted drives

 include/crc32c.h                       |   9 +++
 lib/Makemodule.am                      |   1 +
 lib/crc32c.c                           | 102 +++++++++++++++++++++++++++++++++
 libblkid/src/Makemodule.am             |   1 +
 libblkid/src/superblocks/mpool.c       |  74 ++++++++++++++++++++++++
 libblkid/src/superblocks/superblocks.c |   3 +-
 libblkid/src/superblocks/superblocks.h |   1 +
 7 files changed, 190 insertions(+), 1 deletion(-)
 create mode 100644 include/crc32c.h
 create mode 100644 lib/crc32c.c
 create mode 100644 libblkid/src/superblocks/mpool.c

-- 
2.9.3

