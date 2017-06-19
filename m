Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:58239 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752891AbdFSAfo (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 18 Jun 2017 20:35:44 -0400
Subject: [PATCH 00/12] pull request
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
Date: Sun, 18 Jun 2017 20:35:25 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


The following changes since commit 998ae28704281303b9131c717ec30e39ca8d62f8:

  Merge branch 'some-fixes' of https://github.com/rudimeier/util-linux (2017-06-16 10:50:24 +0200)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git 170427

for you to fetch changes up to f7aaa75d6e9b70564114d20fbe2163c7c989fa55:

  hwclock: remove unused stdarg.h (2017-06-18 20:21:27 -0400)

----------------------------------------------------------------
J William Piggott (12):
      hwclock: remove dead code in usage()
      hwclock: update usage() to util-linux style
      hwclock: update usage() FILE name
      hwclock: add usage() functions heading
      include: update pathnames.h
      hwclock: use RTC in help output
      hwclock: update --help content and grammar
      hwclock: slice up the usage text
      hwclock: add --update-drift check
      Docs: update howto-usage-function.txt
      hwclock: remove unused usage() FILE argument
      hwclock: remove unused stdarg.h

 Documentation/boilerplate.c            |   3 +
 Documentation/howto-usage-function.txt |  12 ++--
 include/c.h                            |   7 ++-
 include/pathnames.h                    |  21 +++----
 sys-utils/hwclock.8.in                 |   3 +-
 sys-utils/hwclock.c                    | 109 +++++++++++++--------------------
 6 files changed, 67 insertions(+), 88 deletions(-)

