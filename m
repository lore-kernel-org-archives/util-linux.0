Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94134C433E0
	for <util-linux@archiver.kernel.org>; Fri, 12 Feb 2021 15:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5948E64E57
	for <util-linux@archiver.kernel.org>; Fri, 12 Feb 2021 15:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhBLPEy (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 12 Feb 2021 10:04:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37528 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230105AbhBLPEu (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 12 Feb 2021 10:04:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613142201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=JhAp9Dkg4RRdpdBWiCoCFdcpso2FfEPdKgKKWApZlQU=;
        b=QFRRG6emAaqjjoA+B5PlO39K+1SOEJpyUU+sd0N7+SQ1cJCtDTgYpIn3xqB3XXp4koHOUV
        gYX6g8Nw1jFtx2qyoI3IAkoZEbITw+CPJfO51ZFakUYoRQbWHzKLL9Imbim9Cnhz6NT/DT
        XbKTUaTVoLzKowUaW+PNTYP6fcHKLqs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-mP_OdMD9NdOC4DzwWgLBbQ-1; Fri, 12 Feb 2021 10:03:13 -0500
X-MC-Unique: mP_OdMD9NdOC4DzwWgLBbQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 834E1107ACC7;
        Fri, 12 Feb 2021 15:03:12 +0000 (UTC)
Received: from ws.net.home (ovpn-117-0.ams2.redhat.com [10.36.117.0])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 993C219811;
        Fri, 12 Feb 2021 15:03:11 +0000 (UTC)
Date:   Fri, 12 Feb 2021 16:03:09 +0100
From:   Karel Zak <kzak@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.36.2
Message-ID: <20210212150309.dk7pnsjc4gk66m7u@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


The util-linux stable maintenance release v2.36.2 is available at
 
  http://www.kernel.org/pub/linux/utils/util-linux/v2.36/
 
Feedback and bug reports, as always, are welcomed.
 
  Karel


util-linux 2.36.2 Release Notes
===============================

agetty:
   - tty eol defaults to REPRINT  [Sami Loone]
blkdiscard:
   - fix compiler warnings [-Wmaybe-uninitialized]  [Karel Zak]
build-sys:
   - do not build plymouth-ctrl.c w/ disabled plymouth  [Pino Toscano]
configure:
   - test -a|o is not POSIX  [Issam E. Maghni]
docs:
   - update AUTHORS file  [Karel Zak]
fsck.cramfs:
   - fix fsck.cramfs crashes on blocksizes > 4K  [ToddRK]
fstab:
   - fstab.5 NTFS and FAT volume IDs use upper case  [Heinrich Schuchardt]
github:
   - remove cifuzz from stable branch  [Karel Zak]
hwclock:
   - do not assume __NR_settimeofday_time32  [Pino Toscano]
   - fix compiler warnings [-Wmaybe-uninitialized]  [Karel Zak]
lib/caputils:
   - add fall back for last cap using prctl.  [Érico Rolim]
lib/loopdev:
   - make is_loopdev() more robust  [Karel Zak]
lib/procutils:
   - add proc_is_procfs helper.  [Érico Rolim]
   - improve proc_is_procfs(), add test  [Karel Zak]
lib/signames:
   - change license to public domain  [Karel Zak]
libblkid:
   - drbdmanage  use blkid_probe_strncpy_uuid instead of blkid_probe_set_id_label  [Pali Rohár]
   - make gfs2 prober more extendible  [Karel Zak]
libfdisk:
   - (dos) fix last possible sector calculation  [Karel Zak]
   - (script) ignore empty values for start and size  [Gaël PORTAY]
   - ignore 33553920 byte optimal I/O size  [Ryan Finnie]
libmount:
   - (py) do not use pointer as an integer value  [Karel Zak]
   - add vboxsf, virtiofs to pseudo filesystems  [Shahid Laher]
   - do not canonicalize ZFS source dataset  [Karel Zak]
   - don't use "symfollow" for helpers on user mounts  [Karel Zak]
   - fix /{etc,proc}/filesystems use  [Karel Zak]
login:
   - use full tty path for PAM_TTY  [Karel Zak]
losetup:
   - fix wrong printf() format specifier for ino_t data type  [Manuel Bentele]
lsblk:
   - read SCSI_IDENT_SERIAL also from udev  [Karel Zak]
lslogins:
   - call close() for usable FD [coverity scan]  [Karel Zak]
po:
   - add sr.po (from translationproject.org)  [Мирослав Николић]
   - merge changes  [Karel Zak]
   - update hr.po (from translationproject.org)  [Božidar Putanec]
   - update sv.po (from translationproject.org)  [Sebastian Rasmussen]
rfkill:
   - stop execution when rfkill device cannot be opened  [Sami Kerola]
script:
   - fix compiler warnings [-Wmaybe-uninitialized]  [Karel Zak]
scriptlive:
   - fix compiler warnings [-Wmaybe-uninitialized]  [Karel Zak]
setpriv:
   - allow using [-+]all for capabilities.  [Érico Rolim]
   - small clean-up.  [Érico Rolim]
su:
   - use full tty path for PAM_TTY  [Karel Zak]
switch_root:
   - check if mount point to move even exists  [Thomas Deutschmann]
sys-utils:
   - mount.8  fix a typo  [Eric Biggers]
tests:
   - add checksum for cramfs/mkfs for LE 16384 (ia64)  [Anatoly Pugachev]
   - be explicit with file permissions for cramfs  [Karel Zak]
   - don't rely on scsi_debug partitions  [Karel Zak]
umount:
   - ignore --no-canonicalize,-c for non-root users  [Karel Zak]

- Show the 'r' option in the help menu  [Vincent McIntyre]

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

