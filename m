Return-Path: elseifthen@gmx.com
Subject: [PATCH 0/4] Pull Request
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, junk@gmx.li
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <50c7367a-c086-2c18-af81-9f86f1c2560a@gmx.com>
Date: Wed, 26 Apr 2017 23:29:40 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


 sys-utils/hwclock.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

The following changes since commit 85bfb519afcbccccb63849b1a348dde76ff6bb83:

  switch_root: unlink files without _DIRENT_HAVE_D_TYPE (2017-04-26 11:23:50 +0200)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git 170419

for you to fetch changes up to 57415653a667cf2442d019f62287534931ab3da4:

  hwclock: use a consistent name for --predict (2017-04-26 23:19:56 -0400)

----------------------------------------------------------------
J William Piggott (4):
      hwclock: extra messages for debug only
      hwclock: make clock test mode message consistent
      hwclock: remove unneeded braces
      hwclock: use a consistent name for --predict

 sys-utils/hwclock.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)
