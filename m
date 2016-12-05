Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f54.google.com ([74.125.82.54]:33886 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751418AbcLEQCa (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 5 Dec 2016 11:02:30 -0500
Received: by mail-wm0-f54.google.com with SMTP id u144so21439068wmu.1
        for <util-linux@vger.kernel.org>; Mon, 05 Dec 2016 08:02:29 -0800 (PST)
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: Michael Kerrisk <michael.kerrisk@gmail.com>
Subject: [GIT PULL] fixes for kill(1) manual page
Message-ID: <a7ced420-6853-13e3-2c87-1762324b4f1f@gmail.com>
Date: Mon, 5 Dec 2016 16:56:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

[Resending, this time with CC to the list...]

Hello Karel,

Some more fixes, mostly for kill(1), but one generic fix

Cheers,

Michael


The following changes since commit c7adc2f204f19167f781fa2ee739e0ca386fc4f5:

  chrt: default to SCHED_RR policy (2016-12-05 13:07:50 +0100)

are available in the git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/mtk/util-linux.git doc_fixes

for you to fetch changes up to 85c928caede29d8ac380182a34c81cd804cf3b6a:

  docs: kill(1): Wording fix (2016-12-05 16:51:16 +0100)

----------------------------------------------------------------
Michael Kerrisk (6):
      docs: various pages: Use "system call" not "syscall"
      docs: kill(1): Fix section reference for sigqueue(3) and add to SEE ALSO
      docs: kill(1): Add more detail on use of SIGTERM vs SIGKILL
      docs: kill(1): Rework notes on thread groups
      docs: kill(1): Formatting fixes
      docs: kill(1): Wording fix

 misc-utils/kill.1   | 61 ++++++++++++++++++++++++++++++++----------------------
 sys-utils/mount.8   |  7 ++++---
 sys-utils/setpriv.1 |  2 +-
 sys-utils/umount.8  |  2 +-
 sys-utils/unshare.1 |  2 +-
 5 files changed, 43 insertions(+), 31 deletions(-)
