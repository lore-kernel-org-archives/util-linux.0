Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f174.google.com ([209.85.212.174]:60228 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbaGMUZF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Jul 2014 16:25:05 -0400
Received: by mail-wi0-f174.google.com with SMTP id d1so1574617wiv.13
        for <util-linux@vger.kernel.org>; Sun, 13 Jul 2014 13:25:02 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 00/14] pull: some minor fixes
Date: Sun, 13 Jul 2014 21:24:39 +0100
Message-Id: <1405283093-28182-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi all,

Here is bunch of small fixes some more significant than other.  Many of
the code changes are outcome of reading cppcheck(1) analysis, which is
not attributed in commit messages.  Perhaps that is ok, if not I'll add
something to the text about the fact when requested so.

The fixes can be also pulled from my github branch minor-fixes, find the
details from bottom of this mail if you prefer using remote repository.


Sami Kerola (14):
  textual: fix some typos
  cal: remove unnused structure and definition
  setterm: remove unnecessary variable
  lscpu: avoid use of bzero() in favor of memset()
  cfdisk: add braces to ensure operation order
  fdformat: match variable and print format types
  mkfs.cramfs: use defined failure name rather than magic value
  fdisk: avoid code duplication
  dmesg: avoid unnecessary variable assignment
  setpriv: avoid alloca() use xmalloc() instead
  whereis: avoid printing uninitialized string
  libfdisk: do not do the same thing twice in single if statement
  libsmartcols: avoid variable dereference after release
  lscpu: avoid double free

 disk-utils/cfdisk.c        | 2 +-
 disk-utils/fdformat.c      | 4 ++--
 disk-utils/fdisk.c         | 9 ++++-----
 disk-utils/mkfs.cramfs.c   | 6 ++----
 lib/strutils.c             | 2 +-
 libfdisk/src/dos.c         | 2 +-
 libfdisk/src/partition.c   | 2 +-
 libmount/src/tab.c         | 2 +-
 libsmartcols/src/line.c    | 2 +-
 libsmartcols/src/version.c | 2 +-
 login-utils/last.c         | 2 +-
 misc-utils/cal.c           | 5 -----
 misc-utils/whereis.c       | 3 +--
 sys-utils/dmesg.c          | 3 ++-
 sys-utils/fstrim.c         | 2 +-
 sys-utils/lscpu-dmi.c      | 2 +-
 sys-utils/lscpu.c          | 2 +-
 sys-utils/setpriv.c        | 4 +++-
 term-utils/setterm.c       | 3 +--
 19 files changed, 26 insertions(+), 33 deletions(-)

The following changes since commit 8b9d1474a4bef66ca0c05a7ebd2341bb02016e24:

  build-sys: release++ (v2.25-rc2) (2014-07-02 11:40:19 +0200)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git 

for you to fetch changes up to 4e6604e51a5460653cd1189c51f5935ae0cde550:

  lscpu: avoid double free (2014-07-13 18:35:39 +0100)

-- 
2.0.1

