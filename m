Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35584 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760521Ab3DBTnE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 2 Apr 2013 15:43:04 -0400
Received: by mail-wi0-f181.google.com with SMTP id hj8so816120wib.2
        for <util-linux@vger.kernel.org>; Tue, 02 Apr 2013 12:43:02 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 00/13] pull: fixes in preparation to v2.23 release
Date: Tue,  2 Apr 2013 20:42:44 +0100
Message-Id: <1364931777-2645-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello Karel, and others.

While doing the bash-completion patches I ran many of the commands, and
found few inconveniences.  These fixes are an attempt to take care most
of them, and hopefully most, if not all, of them get merged before next
release is out.


The following changes since commit c7e76cd145b0c40e1d346203f3222f5937146939:

  lsblk: add --paths (2013-03-29 17:16:09 +0100)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git 2013wk13

for you to fetch changes up to 6329a948bdf6f2b12a6ec3caa568f5c71e7bbbfd:

  logger: make local sockets to try both stream and datagram (2013-04-02 20:28:51 +0100)

----------------------------------------------------------------
Sami Kerola (13):
      docs: fix type in mkfs.8
      newgrp: use xstrdup to check allocation succeeded
      agetty: add -h and -V options
      dmesg: fix usage() output consistancy
      fsfreeze: tell user when mandatory option is not specified
      losetup: allow -j option argument to be relative path
      lscpu: fix error message
      partx: remove deprecated option from usage()
      setarch: add option to list settable architectures
      setterm: fix various color option argument lists
      vipw: add usage() function
      chrt: make command syntax easier to understand in usage()
      logger: make local sockets to try both stream and datagram

 disk-utils/mkfs.8    |  1 -
 disk-utils/partx.c   |  1 -
 login-utils/newgrp.c |  3 ++-
 login-utils/vipw.c   | 23 +++++++++++++---
 misc-utils/logger.c  | 42 +++++++++++++++++------------
 schedutils/chrt.1    | 11 +++++---
 schedutils/chrt.c    |  4 +--
 sys-utils/dmesg.c    |  4 +--
 sys-utils/fsfreeze.c | 25 +++++++++++++-----
 sys-utils/losetup.c  | 13 ++++++---
 sys-utils/lscpu.c    |  2 +-
 sys-utils/setarch.8  |  3 +++
 sys-utils/setarch.c  | 18 ++++++++++---
 term-utils/agetty.c  |  5 ++--
 term-utils/setterm.c | 74 ++++++++++++++++++++++++++--------------------------
 15 files changed, 144 insertions(+), 85 deletions(-)


