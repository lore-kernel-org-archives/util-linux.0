Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f54.google.com ([74.125.82.54]:46321 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935574Ab3DHTdN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Apr 2013 15:33:13 -0400
Received: by mail-wg0-f54.google.com with SMTP id a12so6065045wgh.21
        for <util-linux@vger.kernel.org>; Mon, 08 Apr 2013 12:33:12 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 00/14] [pull] smatch scan, and manual tooling
Date: Mon,  8 Apr 2013 20:32:45 +0100
Message-Id: <1365449579-13238-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel and others,

Yet another set of small fixes, which hopefully can be considered to be
taken to upstream before release.  There are couple patches that was
discussed earlier [0001 & 0003], and some few which Karel outsourced to
me [0008, 0012].  The rest of these patches are reactions to static
analyser, or test tools.


The following changes since commit 0540ea544d4b459bc148d29645225190b76ca8b7:

  libblkid: clean up DBG() (2013-04-08 18:22:13 +0200)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git 2013wk14

for you to fetch changes up to f4fe2ca9aba1d98e5bb9f7b52dfdefebef0a66d6:

  docs: add fsck.cramfs manual page (2013-04-08 20:20:27 +0100)

----------------------------------------------------------------
Sami Kerola (14):
      setarch: clean up usage()
      bash-completion: setarch: use correct list for architectures
      bash-completion: swapon: add options and fix argument
      various: fix variable and function declarations [smatch scan]
      various: fix shadow declarations [smatch scan]
      libmount, col: remove redundant null checks [smatch scan]
      libblkid: number of functions should not be declared extern [smatch scan]
      tools: add checks to manual page test script
      docs: mount.8: make propagation flags adjustable [checkmans.sh]
      docs: col.1: fix manual page name section [checkmans.sh]
      docs: remove repeated words [checkmans.sh]
      tools: make checkmans.sh to find missing manuals
      docs: add mkfs.cramfs manual page
      docs: add fsck.cramfs manual page

 bash-completion/setarch       |   9 +--
 bash-completion/swapon        |  19 ++++--
 disk-utils/Makemodule.am      |   2 +
 disk-utils/elvtune.8          |   2 +-
 disk-utils/fsck.cramfs.8      |  57 ++++++++++++++++++
 disk-utils/fsck.minix.c       |   3 +-
 disk-utils/mkfs.cramfs.8      |  90 ++++++++++++++++++++++++++++
 fdisks/fdiskdoslabel.c        |  38 ++++++------
 fdisks/sfdisk.c               |   8 +--
 lib/mbsalign.c                |   4 +-
 libblkid/src/dev.c            |  10 ++--
 libblkid/src/devname.c        |   6 +-
 libblkid/src/tag.c            |  10 ++--
 libfdisk/src/alignment.c      |   5 +-
 libmount/src/context_umount.c |   6 +-
 libmount/src/tab.c            |   8 +--
 libuuid/man/uuid_generate.3   |   2 +-
 misc-utils/findmnt.c          |   6 +-
 sys-utils/cytune.8            |   2 +-
 sys-utils/mount.8             |   9 ++-
 sys-utils/setarch.c           |  44 +++++++-------
 term-utils/wall.c             |  10 ++--
 text-utils/col.1              |   2 +-
 text-utils/col.c              |   7 +--
 text-utils/rev.c              |  12 ++--
 text-utils/tailf.c            |  10 ++--
 tools/checkmans.sh            | 134 ++++++++++++++++++++++++++++++++++--------
 27 files changed, 379 insertions(+), 136 deletions(-)
 create mode 100644 disk-utils/fsck.cramfs.8
 create mode 100644 disk-utils/mkfs.cramfs.8

