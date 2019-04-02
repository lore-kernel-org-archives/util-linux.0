Return-Path: <SRS0=BORA=SE=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C34C4360F
	for <util-linux@archiver.kernel.org>; Tue,  2 Apr 2019 11:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF2F6208E4
	for <util-linux@archiver.kernel.org>; Tue,  2 Apr 2019 11:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbfDBLdr (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:33:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36028 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbfDBLdr (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 2 Apr 2019 07:33:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3614730FE5D1
        for <util-linux@vger.kernel.org>; Tue,  2 Apr 2019 11:33:47 +0000 (UTC)
Received: from ws.net.home (ovpn-204-222.brq.redhat.com [10.40.204.222])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A24B75D9C4
        for <util-linux@vger.kernel.org>; Tue,  2 Apr 2019 11:33:46 +0000 (UTC)
Date:   Tue, 2 Apr 2019 13:33:44 +0200
From:   Karel Zak <kzak@redhat.com>
To:     util-linux@vger.kernel.org
Subject: plan for v2.33.2
Message-ID: <20190402113344.jl46ousxqquk6lfl@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-1108-40af05
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 02 Apr 2019 11:33:47 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


I'd like to release v2.33.2 on Friday, see below the current
stable/v2.33. Comments & objections?

    Karel


Andreas Schwab (1):
      setarch: don't return address of automatic variable

Fabian.Kirsch@dlr.de (1):
      libfdisk: sanity check, to prevent overlapping partitions from being partly reported as free

Icenowy Zheng (1):
      libfdisk: (gpt) add HiFive Unleashed bootloader partition UUIDs

Johannes Nixdorf (1):
      build-sys: fix crypt() detection without -lcrypt

Juerg Haefliger (1):
      libfdisk: (dos) Use strtoul to parse the label-id

Karel Zak (9):
      whereis: search in /(s)bin before /usr/lib
      losetup: use offset in warn_size() calculation
      logger: (man) make more obvious that --server/socket is required
      sfdisk: fix logical partition resize when start specified
      wall: remove unnecessary warning
      lscpu: document --hex output regression (since v2.30)
      su: be sensitive to another SIGCHLD ssi_codes
      blkid: (man) cleanup return code section
      su: change error message

Marcos Paulo de Souza (1):
      fstrim: Remove commnet about vfat not supporting fstrim

Patrick Steinhardt (1):
      last: do not use non-standard __UT_NAMESIZE

Peter Wu (1):
      mount.8: clarify (no)suid behavior on file capabilities

Sami Kerola (5):
      bash-completion: umount support relative path and ~ as home shorthands
      last: fix wtmp user name buffer overflow [asan]
      readprofile: check input file is not empty [asan]
      include: add no return function attribute
      include/path.h: remove duplicate header inclusion

Stanislav Brabec (4):
      mount: Do not call mnt_pretty_path() on net file systems.
      agetty: Fix input of non-ASCII characters in get_logname()
      agetty: Switch to 8-bit processing in get_logname() for UTF-8 terminals
      libmount: Recognize more fuse filesystems as pseudofs and netfs

dana (1):
      column: Address fill-order confusion in documentation

edupont (1):
      Typo in configuration help

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
