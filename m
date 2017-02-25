Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:51123 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751568AbdBYScf (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 25 Feb 2017 13:32:35 -0500
Subject: [V2 0/4] hwclock: remove date(1)
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <ee9e12b4-a921-b47e-975d-53a5b8575361@gmx.com>
Date: Sat, 25 Feb 2017 13:25:37 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


* The last commit/patch adds hwclock-date.c
   I added this file in case testers do not have 'bison' installed. It
   may, or may not, need to be tracked depending on how it is to be
   maintained. The 'c' file probably should be included in the
   distributed source archive to avoid the bison dependency.  Karel, I
   don't know if you want to create a separate clean and build target
   for hwclock-date.c, or how you want to handle this. So, if you don't
   mind, I'll leave this detail to you.

   Testers that want to build it can:
   $ cd sys-utils/
   $ rm hwclock-date.c 
   $ bison -o hwclock-date.c hwclock-date.y

   It does require bison 2.0 or newer, yacc won't work.

 ---

The following changes since commit 7ab6461fae3848ea85f494f29e26229717685ae3:

  docs: add note about branches to README (2017-02-24 14:19:04 +0100)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git hwclock-date2m

for you to fetch changes up to 46f1d03062ff66125f38abafd922412b6c182f49:

  hwclock: add sys-utils/hwclock-date.c (2017-02-24 14:41:32 -0500)

----------------------------------------------------------------
J William Piggott (4):
      hwclock: use parse_datetime function
      build-system: add hwclock-date
      hwclock: add hwclock-date files
      hwclock: add sys-utils/hwclock-date.c

 include/cctype.h         |  357 ++++
 sys-utils/Makemodule.am  |    1 +
 sys-utils/hwclock-date.c | 4307 ++++++++++++++++++++++++++++++++++++++++++++++
 sys-utils/hwclock-date.y | 2427 ++++++++++++++++++++++++++
 sys-utils/hwclock.c      |  104 +-
 sys-utils/hwclock.h      |   10 +
 6 files changed, 7107 insertions(+), 99 deletions(-)
 create mode 100644 include/cctype.h
 create mode 100644 sys-utils/hwclock-date.c
 create mode 100644 sys-utils/hwclock-date.y
