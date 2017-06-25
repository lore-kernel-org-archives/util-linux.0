Return-Path: elseifthen@gmx.com
Subject: [PATCH 0/4] pull request
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <e5059958-a9b9-2ff4-f1b8-6122520bacac@gmx.com>
Date: Sun, 25 Jun 2017 17:45:56 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


* Rudi didn't like cluttering boilerplate.c with seldom used USAGE_*
  constants and I don't disagree with that point. I do think they should
  be in the file for new contributor discovery purposes. As a compromise
  I added the missing ones as a comment.

* the newly added USAGE_COLUMNS could be used in disk-utils/fdisk-list.c:432
  if Karel wants to drop the ' (for -o)'. I did not change it.

* I couldn't test the blkzone change to USAGE_COMMANDS, but I expect it to
  be okay.
   configure: WARNING: linux/blkzoned.h header not found; not building blkzone


The following changes since commit 2a14beb4e9c6cdf4466993741d86e45dd57ddef3:

  agetty: fix login name DEL/CTRL^U issue (2017-06-23 14:26:47 +0200)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git 170622

for you to fetch changes up to 7948117da5654311dba59b256d9a017d56877592:

  Docs: move option naming to howto-contribute.txt (2017-06-24 15:22:49 -0400)

----------------------------------------------------------------
J William Piggott (4):
      include/c.h: add USAGE_COMMANDS and USAGE_COLUMNS
      Docs: add a comment for constants to boilerplate.c
      Docs: update howto-usage-function.txt
      Docs: move option naming to howto-contribute.txt

 Documentation/boilerplate.c            |  8 +--
 Documentation/howto-contribute.txt     | 25 +++++++++
 Documentation/howto-usage-function.txt | 97 +++++++++++++---------------------
 disk-utils/sfdisk.c                    |  2 +-
 include/c.h                            |  4 +-
 login-utils/lslogins.c                 |  6 +--
 misc-utils/findmnt.c                   |  3 +-
 sys-utils/blkzone.c                    |  2 +-
 sys-utils/lscpu.c                      |  3 +-
 sys-utils/lsmem.c                      |  5 +-
 sys-utils/wdctl.c                      |  3 +-
 11 files changed, 78 insertions(+), 80 deletions(-)
