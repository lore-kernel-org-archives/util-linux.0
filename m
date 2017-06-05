Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:55612 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751181AbdFEXXi (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 5 Jun 2017 19:23:38 -0400
Received: from [192.168.3.12] (Athenae [192.168.3.12])
        by Ishtar.sc.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id v55N7t9W071126
        for <util-linux@vger.kernel.org>; Mon, 5 Jun 2017 16:07:57 -0700
Message-ID: <5935E44B.8000405@tlinx.org>
Date: Mon, 05 Jun 2017 16:07:55 -0700
From: L A Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Bug: mount doing bad security check: only root can use -types, (effective
 EUID is 5013)
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

mount is Using util-linux 2.30-rc2 (libmount 2.30.0: smack, btrfs, mtab, 
debug).

Trying to mount any file system, thinks I have bad UID:

Ishtar:/mnt# /bin/mount /dev/tmpfs /mnt/tmpfs -t tmpfs
mount: only root can use "--types" option (effective UID is 5013)
Ishtar:/mnt# echo "$UID $EUID"
0 0

The previous version of mount works fine -- so it seems clear that the
new version of mount is doing something wrong.

Someone else had a problem w/mount doing some bad check
that wasn't the case.  Think they had the right bits (CAP_SYS_ADMIN),
but the mount command was ignoring caps and looking for UID==0.

But in this case, it "double" shouldn't matter, since I'm
running as root.








