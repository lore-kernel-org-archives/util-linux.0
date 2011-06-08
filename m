Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60681 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090Ab1FHWxT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 8 Jun 2011 18:53:19 -0400
Received: by iwn34 with SMTP id 34so829962iwn.19
        for <util-linux@vger.kernel.org>; Wed, 08 Jun 2011 15:53:18 -0700 (PDT)
From: Josiah Worcester <josiahw@gmail.com>
To: util-linux@vger.kernel.org
Cc: Josiah Worcester <josiahw@gmail.com>
Subject: [PATCH 0/6] Build with musl libc
Date: Wed,  8 Jun 2011 16:52:42 -0600
Message-Id: <1307573568-23643-1-git-send-email-josiahw@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I was trying to build util-linux with the musl libc (http://www.etalabs.net/musl/),
and found that a few patches were needed. These seem to just be some minor cleanups
in most cases. I'm a bit dubious of the hwclock patch, though, as it seems at least
a little bit hackish.

Josiah Worcester (6):
  fdisk, display, hexdump.h: Use standard C types instead of u_int,
    u_char, u_long, etc.
  fsck, checktty, flock: Use more portable includes.
  checktty: Use NGROUPS_MAX instead of NGROUPS
  lib/tt.c: Fix mbs_width macro for systems without WIDECHAR    
  test_sysinfo: Use CHAR_BIT*sizeof(void*) instead of __WORDSIZE.
  hwclock: Don't use asm/io.h if sys/io.h can't be found

 fdisk/fdiskbsdlabel.c        |   34 +++++++++++++++++-----------------
 fsck/fsck.c                  |    2 +-
 hwclock/cmos.c               |    7 ++++++-
 lib/tt.c                     |    2 +-
 login-utils/checktty.c       |    7 +++++--
 sys-utils/flock.c            |    2 ++
 tests/helpers/test_sysinfo.c |    2 +-
 text-utils/display.c         |   32 ++++++++++++++++----------------
 text-utils/hexdump.h         |    4 ++--
 9 files changed, 51 insertions(+), 41 deletions(-)

-- 
1.7.5.3

