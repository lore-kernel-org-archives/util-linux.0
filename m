Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36738 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbdDBP6P (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 2 Apr 2017 11:58:15 -0400
Received: by mail-wr0-f196.google.com with SMTP id k6so26013924wre.3
        for <util-linux@vger.kernel.org>; Sun, 02 Apr 2017 08:58:14 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: pull: tailf: remove deprecated utility
Date: Sun,  2 Apr 2017 16:58:10 +0100
Message-Id: <20170402155810.3839-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel and Ruediger,

March 2017 is gone, it is time to remove this utility as scheduled in 
earlier commit, and promised in manual page.

Reference: 3f8478a71ccde6883d4c81b7e65561a106653b28

To avoid sending a long trivial change to all subscribers please pull it 
from my remote instead.

----------------------------------------------------------------
The following changes since commit eff2c9a42621b4cba81a81bc78f431b00e8a2968:
  tests: add --mountpoint to findmnt calls (2017-03-31 14:00:24 +0200)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git tailf-removal
for you to fetch changes up to 70ca1a77721b41f2355eeb00d4e55e13dba3e313:
  tailf: remove deprecated utility (2017-04-02 16:51:00 +0100)
----------------------------------------------------------------
Sami Kerola (1):
      tailf: remove deprecated utility

 .gitignore                                         |   1 -
 Documentation/deprecated.txt                       |   5 -
 bash-completion/Makemodule.am                      |   3 -
 bash-completion/tailf                              |  28 --
 configure.ac                                       |   7 -
 tests/commands.sh                                  |   1 -
 tests/expected/build-sys/config-all                |   1 -
 tests/expected/build-sys/config-all-devel          |   1 -
 tests/expected/build-sys/config-all-non-nls        |   1 -
 tests/expected/build-sys/config-audit              |   1 -
 tests/expected/build-sys/config-chfnsh-libuser     |   1 -
 tests/expected/build-sys/config-chfnsh-no-password |   1 -
 tests/expected/build-sys/config-chfnsh-pam         |   1 -
 tests/expected/build-sys/config-core               |   1 -
 tests/expected/build-sys/config-devel              |   1 -
 tests/expected/build-sys/config-devel-new-mount    |   1 -
 tests/expected/build-sys/config-devel-non-docs     |   1 -
 tests/expected/build-sys/config-non-libblkid       |   1 -
 tests/expected/build-sys/config-non-libmount       |   1 -
 tests/expected/build-sys/config-non-libs           |   1 -
 tests/expected/build-sys/config-non-libsmartcols   |   1 -
 tests/expected/build-sys/config-non-libuuid        |   1 -
 tests/expected/build-sys/config-non-nls            |   1 -
 tests/expected/build-sys/config-selinux            |   1 -
 tests/expected/build-sys/config-slang              |   1 -
 tests/expected/build-sys/config-static             |   1 -
 tests/ts/tailf/simple                              |  40 ---
 text-utils/Makemodule.am                           |   7 -
 text-utils/tailf.1                                 |  73 -----
 text-utils/tailf.c                                 | 295 ---------------------
 30 files changed, 480 deletions(-)
 delete mode 100644 bash-completion/tailf
 delete mode 100755 tests/ts/tailf/simple
 delete mode 100644 text-utils/tailf.1
 delete mode 100644 text-utils/tailf.c
