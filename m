Return-Path: <SRS0=YmJi=65=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D599FC433DF
	for <util-linux@archiver.kernel.org>; Fri, 15 May 2020 13:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD07720643
	for <util-linux@archiver.kernel.org>; Fri, 15 May 2020 13:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IBEBCXGS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgEONFQ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 15 May 2020 09:05:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43221 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726135AbgEONFQ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 15 May 2020 09:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589547915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=M7evnZmfPRLYPicMWMY5GjLVnNbNax7+rOU20233UpE=;
        b=IBEBCXGS1xS5oIwZg2ZsC0lVLfxFKIzV/Iz0wnG6LDwD8q84S1RJXCkubupnIJ8xrCCPEf
        zwJhKrAPoJnz7qgWsVX9e4p7OnnOvHBs8OY9JtmMfDzR0u5bbGgMVhf7OdaRX+O8SYzqER
        dMoi2sE94HxVRAU7QMV1YMSi+tMcBgg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-444H_oWvMIi68w5fYBOKfg-1; Fri, 15 May 2020 09:05:13 -0400
X-MC-Unique: 444H_oWvMIi68w5fYBOKfg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADE5C36267
        for <util-linux@vger.kernel.org>; Fri, 15 May 2020 13:05:12 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 15B176E70D
        for <util-linux@vger.kernel.org>; Fri, 15 May 2020 13:05:11 +0000 (UTC)
Date:   Fri, 15 May 2020 15:05:09 +0200
From:   Karel Zak <kzak@redhat.com>
To:     util-linux@vger.kernel.org
Subject: plan for v2.35.2
Message-ID: <20200515130509.cbkfyim7o7dchb25@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


I'd like to release v2.35.2 on Monday (and 2.36-rc1 later). See below
the current stable/v2.35 branch. Any objections and suggestions?

    Karel


Anatoly Pugachev (1):
      docs: Correct ChangeLog URL to history log.

Disconnect3d (1):
      Fix off by one when checking "/dev/mapper/" path

Gaël PORTAY (2):
      libfdisk: (script) fix segmentation fault
      lib/mangle: check for the NULL string argument

J William Piggott (1):
      hwclock: make glibc 2.31 compatible

Jakub Wilk (2):
      scriptlive: fix man page formatting
      scriptlive: fix typo

Jiaxun Yang (1):
      lscpu: Adapt MIPS cpuinfo

Johannes Thumshirn (1):
      blkzone: deny destructive ioctls on busy blockdev

Karel Zak (23):
      libfdisk: (script) accept sector-size, ignore unknown headers
      fstrim: do not use Protect setting in systemd service
      libfdisk: (script) fix memory leak
      sfdisk: fix ref-counting for the script
      lscpu: fix SIGSEGV on archs without drawers & books
      umount: don't try it as non-suid if not found mountinfo entry
      lsblk: fix -P regression from v2.34
      chsh: (man) fix default behavior description
      hwclock: fix audit exit status
      su, runuser: (man) add more info about PATH and PAM
      lscpu: use official name for HiSilicon tsv110
      libmount: improve smb{2,3} support
      libmount: smb2 is unsupported alias
      libfdisk: remove unwanted assert()
      pylibmount: cleanup and sync UL_RaiseExc
      eject: fix compiler warning [-Wformat-overflow]
      sfdisk: only report I/O errors on --move-data
      libfdisk: (script) fix partno_from_devname()
      docs: add swap to 1st fstab field
      libfdisk: fix partition calculation for BLKPG_* ioctls
      wipefs: fix man page --no-headings short option
      libblkid: fix fstatat() use in blkid__scan_dir()
      libblkid: fix compiler warning [-Wsign-compare]

Lukas Czerner (1):
      blkdiscard: (man) offset and length must be sector aligned

Mark Barbone (1):
      Fix typo in the mount (8) man page

Mark Hindley (1):
      tests: Fix for misc/fallocate test build failure.

Pali Rohár (2):
      libblkid: Fix UTF-16 support in function blkid_encode_to_utf8()
      exfat: Fix parsing exfat label

Ritika Srivastava (1):
      lsblk: Ignore hidden devices

Roberto Bergantinos Corpas (1):
      libmount: fix mount -a EBUSY for cifs

Sami Kerola (4):
      kill: include sys/types.h before checking SYS_pidfd_send_signal
      docs: kill.1 add note about shell-internal kill implementations
      ctrlaltdel: display error message indicated by errno
      write: fix potential string overflow

Sven Wiltink (1):
      lsblk: Fall back to ID_SERIAL

Tycho Andersen (1):
      libmount: do not unnecessarily chmod utab.lock

Wolfram Sang (1):
      bash-completion: umount explicitly needs gawk

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

