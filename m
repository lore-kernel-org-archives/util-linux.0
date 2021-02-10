Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECECC433E0
	for <util-linux@archiver.kernel.org>; Wed, 10 Feb 2021 16:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 560CE64E85
	for <util-linux@archiver.kernel.org>; Wed, 10 Feb 2021 16:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbhBJQbz (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 10 Feb 2021 11:31:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38068 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232583AbhBJQbZ (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 10 Feb 2021 11:31:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612974595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=aJLFPVL5I+OqpQQpcRfO4taAVVgjF8XWzzuBahP0bW8=;
        b=YJIYR4jevuMUMg75U/G/PvoigTT06ABiitN7ziZXC9Z7aiL0GFoNSkMWineUc1Hfcy9BQj
        eOZEUnrrBOoBK40A2zpXYkKY0xMq9OLYb96XCNLKYJkRYVcbd1/ym0xhbY4lhRSJ/XBbTP
        UfA+/Ymdf32SSWBWBQjZ2rgz7JCfhxQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-0A0uVjsuNbK15uTvdOhlnQ-1; Wed, 10 Feb 2021 11:29:50 -0500
X-MC-Unique: 0A0uVjsuNbK15uTvdOhlnQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84D38107ACF3
        for <util-linux@vger.kernel.org>; Wed, 10 Feb 2021 16:29:49 +0000 (UTC)
Received: from ws.net.home (ovpn-117-0.ams2.redhat.com [10.36.117.0])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 043185C1BD
        for <util-linux@vger.kernel.org>; Wed, 10 Feb 2021 16:29:48 +0000 (UTC)
Date:   Wed, 10 Feb 2021 17:29:46 +0100
From:   Karel Zak <kzak@redhat.com>
To:     util-linux@vger.kernel.org
Subject: v2.36.2 plan
Message-ID: <20210210162946.3ng5utpjradpqkuj@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


 Hi,

 I'd like to release stable maintenance v2.36.2 on Friday.

 All is already in stable/v2.36 branch:
 https://github.com/karelzak/util-linux/tree/stable/v2.36

 See log below, comments & objections?

  Karel


blkdiscard:
   - fix compiler warnings [-Wmaybe-uninitialized]  [Karel Zak]
build-sys:
   - do not build plymouth-ctrl.c w/ disabled plymouth  [Pino Toscano]
configure:
   - test -a|o is not POSIX  [Issam E. Maghni]
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
umount:
   - ignore --no-canonicalize,-c for non-root users  [Karel Zak]
cfdisk:
   - Show the 'r' option in the help menu  [Vincent McIntyre]

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

