Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24CFC433EF
	for <util-linux@archiver.kernel.org>; Mon, 31 Jan 2022 00:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344999AbiAaAVc (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 30 Jan 2022 19:21:32 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:33180 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbiAaAVc (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 30 Jan 2022 19:21:32 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5D35B1F37B
        for <util-linux@vger.kernel.org>; Mon, 31 Jan 2022 00:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643588491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+9SMs6GxzrI3v5CMW1pfoKXxaJpR3LvI6jlyZDvVCp8=;
        b=C343yOWgDxKpdli0hLDL4jQiMQ1xl89oO1eu17g8jV3MwNfILSl+lWsS2ziuUJevAIznil
        C5VVBSYDj+ltsimu/FGVHaJH4zWRiaNXqXpQmzB5dqfbkexeMWoTLgHs0u4TfO4+PRjMtH
        7o0NiAFGn7SoU1ewfZK38nH0DcgwLNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643588491;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+9SMs6GxzrI3v5CMW1pfoKXxaJpR3LvI6jlyZDvVCp8=;
        b=fx3z8c4Ymq1PEyeEeB9KSZkuEnN1VxcXqN0cPjZzTo9CTxH79Tq9qpi+QMBG6ir7NWgJkp
        p/yRZt7GPWgLoiBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4341413638
        for <util-linux@vger.kernel.org>; Mon, 31 Jan 2022 00:21:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XBTrDYsr92GjTAAAMHmgww
        (envelope-from <sbrabec@suse.cz>)
        for <util-linux@vger.kernel.org>; Mon, 31 Jan 2022 00:21:31 +0000
Message-ID: <823c644a-9eec-4832-0f52-e5e9419aad95@suse.cz>
Date:   Mon, 31 Jan 2022 01:21:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
To:     util-linux@vger.kernel.org
Content-Language: en-US
From:   Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] fstrim: Add fstab option x-fstrim.notrim
Organization: SUSE Linux, s. r. o.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Sometimes it makes sense to skip fstrim for selected file mounts, but
still be able to use fstrim.service.

Add a possibility to specify "x-fstrim.notrim" in fstab.

Do not use "notrim", as it collides with the kernel rbd driver.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
  sys-utils/fstrim.8.adoc | 4 +++-
  sys-utils/fstrim.c      | 2 ++
  2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/sys-utils/fstrim.8.adoc b/sys-utils/fstrim.8.adoc
index b2c1fce22..66387ba35 100644
--- a/sys-utils/fstrim.8.adoc
+++ b/sys-utils/fstrim.8.adoc
@@ -29,7 +29,7 @@ Running *fstrim* frequently, or even using *mount -o 
discard*, might negatively
  The _offset_, _length_, and _minimum-size_ arguments may be followed 
by the multiplicative suffixes KiB (=1024), MiB (=1024*1024), and so on 
for GiB, TiB, PiB, EiB, ZiB and YiB (the "iB" is optional, e.g., "K" has 
the same meaning as "KiB") or the suffixes KB (=1000), MB (=1000*1000), 
and so on for GB, TB, PB, EB, ZB and YB.

  *-A, --fstab*::
-Trim all mounted filesystems mentioned in _/etc/fstab_ on devices that 
support the discard operation. The root filesystem is determined from 
kernel command line if missing in the file. The other supplied options, 
like *--offset*, *--length* and *--minimum*, are applied to all these 
devices. Errors from filesystems that do not support the discard 
operation, read-only devices, autofs and read-only filesystems are 
silently ignored.
+Trim all mounted filesystems mentioned in _/etc/fstab_ on devices that 
support the discard operation. The root filesystem is determined from 
kernel command line if missing in the file. The other supplied options, 
like *--offset*, *--length* and *--minimum*, are applied to all these 
devices. Errors from filesystems that do not support the discard 
operation, read-only devices, autofs and read-only filesystems are 
silently ignored. Filesystems with "x-fstrim.notrim" mount option are 
skipped.

  *-a, --all*::
  Trim all mounted filesystems on devices that support the discard 
operation. The other supplied options, like *--offset*, *--length* and 
*--minimum*, are applied to all these devices. Errors from filesystems 
that do not support the discard operation, read-only devices and 
read-only filesystems are silently ignored.
@@ -47,6 +47,8 @@ The number of bytes (after the starting point) to 
search for free blocks to disc
  Specifies a colon-separated list of files in fstab or kernel mountinfo 
format. All missing or empty files are silently ignored. The evaluation 
of the _list_ stops after first non-empty file. For example:
  +
  *--listed-in /etc/fstab:/proc/self/mountinfo*.
++
+Filesystems with "x-fstrim.notrim" mount option are skipped.

  *-m, --minimum* _minimum-size_::
  Minimum contiguous free range to discard, in bytes. (This value is 
internally rounded up to a multiple of the filesystem block size.) Free 
ranges smaller than this will be ignored and *fstrim* will adjust the 
minimum if it's smaller than the device's minimum, and report that 
(fstrim_range.minlen) back to userspace. By increasing this value, the 
*fstrim* operation will complete more quickly for filesystems with badly 
fragmented freespace, although not all blocks will be discarded. The 
default value is zero, discarding every free block.
diff --git a/sys-utils/fstrim.c b/sys-utils/fstrim.c
index 88397f0ec..cbe1c76d0 100644
--- a/sys-utils/fstrim.c
+++ b/sys-utils/fstrim.c
@@ -224,6 +224,8 @@ static int is_unwanted_fs(struct libmnt_fs *fs, 
const char *tgt)
          return 1;
      if (mnt_fs_match_options(fs, "ro"))
          return 1;
+    if (mnt_fs_match_options(fs, "+x-fstrim.notrim"))
+        return 1;

      fd = open(tgt, O_PATH);
      if (fd < 0)
-- 
2.31.1
-- 

Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Křižíkova 148/34 (Corso IIa)                    tel: +420 284 084 060
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76

