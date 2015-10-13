Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33254 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932079AbbJML3V (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 13 Oct 2015 07:29:21 -0400
Received: by wicge5 with SMTP id ge5so53233658wic.0
        for <util-linux@vger.kernel.org>; Tue, 13 Oct 2015 04:29:20 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 0/8] [pull] various changes, uuid tests, ctrlaltdel improvements and so on
Date: Tue, 13 Oct 2015 12:29:06 +0100
Message-Id: <1444735754-18976-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel,

You mentioned something about uuid tests, so I wrote couple.  They do not
test any randomness aspects of the commands, but general execution and
request flow, so not 100% perfect but much better than no tests at all.

The ctrlaltdel(8) has a new feature in these changes - when ran without
arguments it will display what is the CAD function.  Basically this is the
same thinking pattern that we applied earlier to swapon(8).

The rest of the pull is minor updateds touching last(1), and nologin(1).

----------------------------------------------------------------
The following changes since commit d5b7d2912afceac3774d1aaea9e8486b54d4e9e9:
  libblkid: make XFS Log visible for wipefs (2015-10-13 12:02:17 +0200)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git various
for you to fetch changes up to 150029cf0057a5f1278a2abb40753c321126be74:
  ctrlaltdel: display setting when ran without arguments (2015-10-13 12:17:07 +0100)
----------------------------------------------------------------

Sami Kerola (8):
  last: display input file in usage() according to command name
  nologin: require /etc/nologin.txt to be file
  libuuid: add uuid_generate_file() function
  tests: add uuidgen check
  tests: add uuidd check
  ctrlaltdel: improve error messaging
  docs: update ctrlaltdel.8 man page
  ctrlaltdel: display setting when ran without arguments

 include/pathnames.h         |   3 ++
 libuuid/man/uuid_generate.3 |  11 +++++++
 libuuid/src/gen_uuid.c      |  21 +++++++++++++
 libuuid/src/libuuid.sym     |   8 +++++
 libuuid/src/uuid.h          |   2 ++
 login-utils/last.c          |  17 +++++-----
 login-utils/nologin.c       |   5 ++-
 misc-utils/Makemodule.am    |  10 ++++++
 misc-utils/uuidd.c          |  16 ++++++++++
 misc-utils/uuidgen.c        |  24 ++++++++++++++
 sys-utils/ctrlaltdel.8      |  26 +++++++++------
 sys-utils/ctrlaltdel.c      |  75 ++++++++++++++++++++++++++++++++++----------
 tests/commands.sh           |   2 ++
 tests/expected/uuid/uuidd   |   7 +++++
 tests/expected/uuid/uuidgen |   6 ++++
 tests/ts/uuid/0x00000000    | Bin 0 -> 16 bytes
 tests/ts/uuid/0xdeadbeef    |   1 +
 tests/ts/uuid/0xffffffff    |   1 +
 tests/ts/uuid/uuidd         |  33 +++++++++++++++++++
 tests/ts/uuid/uuidgen       |  30 ++++++++++++++++++
 20 files changed, 261 insertions(+), 37 deletions(-)
 create mode 100644 tests/expected/uuid/uuidd
 create mode 100644 tests/expected/uuid/uuidgen
 create mode 100644 tests/ts/uuid/0x00000000
 create mode 100644 tests/ts/uuid/0xdeadbeef
 create mode 100644 tests/ts/uuid/0xffffffff
 create mode 100755 tests/ts/uuid/uuidd
 create mode 100755 tests/ts/uuid/uuidgen

-- 
2.6.1

