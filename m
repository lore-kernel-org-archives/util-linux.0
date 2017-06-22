Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:57742 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751858AbdFVCht (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 21 Jun 2017 22:37:49 -0400
Received: from tenfore.ga-group.nl ([92.195.15.151]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LcVOE-1e6WD634B4-00jnpK for
 <util-linux@vger.kernel.org>; Thu, 22 Jun 2017 04:37:46 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 00/13] usage cleanup part 1
Date: Thu, 22 Jun 2017 04:37:33 +0200
Message-Id: <1498099066-24235-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This is pull request #467 on github
https://github.com/karelzak/util-linux/pull/467

The major goal is to avoid printing usage/help messages on stderr.

This is the preparing first part of a bigger patch-set. There are
some minor bug fixes and finally we add --help options to all our
commands (just 5 commands were missing it).

The next completing patch-set (part 2) will be more invasive but
even more trivial.

Ruediger Meier (13):
  uuidd: remove unused define
  misc: remove superfluous null pointer checks for optarg
  misc: fix some broken exit codes
  blkid: use errtryhelp instead of errtryh
  dmesg: do not accept any non-option arguments
  setarch: print usage error if no argument given
  setarch: use errtryhelp()
  fsck: add --help and --version
  login: add --help and --version
  whereis: add --help and --version
  more: add --help and --version
  mkfs.cramfs: add --help and --version
  misc: no more errtryh()

 disk-utils/fsck.8        |  6 ++++++
 disk-utils/fsck.c        | 29 +++++++++++++++++++++--------
 disk-utils/fsck.cramfs.c |  2 +-
 disk-utils/mkfs.cramfs.8 |  8 ++++----
 disk-utils/mkfs.cramfs.c | 35 ++++++++++++++++++++++++-----------
 include/c.h              |  6 ------
 login-utils/chsh.c       |  2 --
 login-utils/login.1      |  5 ++++-
 login-utils/login.c      | 28 ++++++++++++++++++++++------
 login-utils/lslogins.c   | 15 ++++++---------
 misc-utils/blkid.c       |  8 ++++----
 misc-utils/findfs.c      |  4 ++--
 misc-utils/test_uuidd.c  | 25 ++++++++++++++-----------
 misc-utils/uuidd.c       |  6 ------
 misc-utils/whereis.1     |  6 ++++++
 misc-utils/whereis.c     | 48 +++++++++++++++++++++++++++++++++++-------------
 sys-utils/dmesg.c        |  4 +---
 sys-utils/setarch.c      | 22 ++++++----------------
 text-utils/hexdump.c     |  2 +-
 text-utils/more.1        |  6 ++++++
 text-utils/more.c        | 29 ++++++++++++++++++++++-------
 21 files changed, 185 insertions(+), 111 deletions(-)

-- 
1.8.5.6

