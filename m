Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f46.google.com ([74.125.82.46]:64073 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112Ab2LPKoI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Dec 2012 05:44:08 -0500
Received: by mail-wg0-f46.google.com with SMTP id dr13so2061690wgb.1
        for <util-linux@vger.kernel.org>; Sun, 16 Dec 2012 02:44:07 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [00/14]: pull: ipcs resubmission, bug fixes, minix todo, etc
Date: Sun, 16 Dec 2012 10:43:48 +0000
Message-Id: <1355654642-22106-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello Karel && all,

This review / pull request is partial resubmission.  The ipc stuff was
sent to list earlier, but it got to be modified after initial review so
here comes the modified version.

In these patches there are two documentation bug fixes (0001, 0005), and
one code bug fix (0013).  There is also one policy change (0008), which
makes tunelp not to be part of default build.  My feeling is that the
utility is not much in use.  Please correct if I am wrong, and drop the
patch.

Minix changes aimed to remove a TODO item.  I did not remove the task
yet, just in case someone wants to double check the code for that there
are no remaining variables using not-optimal types.

That was the week that was.


The following changes since commit 7cdfc45f99c04797aa0838310dae4e7bf95f6c9d:

  docs: fix typo (2012-12-14 16:12:47 +0100)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git 2012wk50

for you to fetch changes up to fa72dc4d91085705647b285e1b319ffc3bbe2daf:

  docs: fsck(8), mkfs(8): update manual references (2012-12-16 10:25:46 +0000)

----------------------------------------------------------------
Sami Kerola (14):
      docs: swapon.8 option name fix
      ipcs: assist debugging
      ipcs: add --human readable size conversion option
      ipcs: add --bytes size output option
      isosize: fix usage() -h option print out
      isosize: inform if file does not look like iso file system
      more: remove unnecessary variable
      tunelp: deprecation: remove command from default build
      minix: change types in header file
      minix: use off_t, size_t, etc appropriate types
      minix: replace magic constants with macro names
      docs: add missing exit value to fsck.minix(8)
      lib/ismounted: detect loopback mounts
      docs: fsck(8), mkfs(8): update manual references

 Documentation/deprecated.txt |   4 ++
 configure.ac                 |  10 ++++
 disk-utils/fsck.8            |  16 ++-----
 disk-utils/fsck.minix.8      |   6 +--
 disk-utils/fsck.minix.c      |  26 +++++-----
 disk-utils/isosize.c         |  31 ++++++++----
 disk-utils/minix_programs.h  |  40 ++++++++--------
 disk-utils/mkfs.8            |  10 ++--
 disk-utils/mkfs.minix.c      |  12 ++---
 lib/Makemodule.am            |   1 +
 lib/ismounted.c              |   8 +++-
 sys-utils/Makemodule.am      |   2 +
 sys-utils/ipcs.1             |   6 +++
 sys-utils/ipcs.c             | 112 +++++++++++++++++++++++++++----------------
 sys-utils/ipcutils.c         |  40 ++++++++++++++++
 sys-utils/ipcutils.h         |   9 ++++
 sys-utils/swapon.8           |   2 +-
 text-utils/more.c            |   4 +-
 18 files changed, 222 insertions(+), 117 deletions(-)
