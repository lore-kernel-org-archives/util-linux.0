Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61463 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823Ab1KSVnf convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 19 Nov 2011 16:43:35 -0500
Received: by yenq3 with SMTP id q3so3606715yen.19
        for <util-linux@vger.kernel.org>; Sat, 19 Nov 2011 13:43:35 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Date: Sat, 19 Nov 2011 22:43:35 +0100
Message-ID: <CAG27Bk2uza2TVvZguXRcWbg58NJ=Fpo3608c9rRyBhynNM2h-w@mail.gmail.com>
Subject: [pull] login-utils maintenance fixes
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

This is mostly boring series of maintenance fixes to utilities, which
does not even compile by default.

The following changes since commit 47104bae8975511383bcef5c96545f03bb4e4cce:

  fdisk: split delete_partition() off from dos_delete_partition()
(2011-11-14 15:07:28 +0100)

are available in the git repository at:
  https://github.com/kerolasa/lelux-utiliteetit login-utils

Sami Kerola (21):
      chfn: align with howto-usage-function.txt
      chfn: use libc error printing facilities
      chsh: align with howto-usage-function.txt
      chsh: use libc error printing facilities
      vipw: use libc error printing facilities
      vipw: stop printing non-sense version string
      newgrp: add version and help options
      login: add version printing option
      chfn, chsh, setpwnam: use stdbool.h
      chsh: build bug: do not override config.h definition
      chfn, chsh: share require password error print definition
      build-sys: trust autotools setting *_SOURCES definitions
      islocal: fix coding style
      logindefs: fix coding style
      newgrp: fix coding style
      selinux_utils: fix coding style
      setpwnam: fix coding style
      vipw: fix coding style
      last: possible buffer overflow fixed [smatch scan]
      setpwnam: remove non-ANSI definitions [smatch scan]
      last: fix few compiler warnings

 login-utils/Makefile.am     |    2 +-
 login-utils/chfn.c          |  713 ++++++++++++++++++++++---------------------
 login-utils/chregpw.h       |   16 +
 login-utils/chsh.c          |  578 +++++++++++++++++------------------
 login-utils/islocal.c       |   79 +++---
 login-utils/last.c          |    8 +-
 login-utils/login.1         |    3 +
 login-utils/login.c         |    5 +-
 login-utils/logindefs.c     |   42 ++--
 login-utils/newgrp.c        |  209 ++++++++------
 login-utils/selinux_utils.c |   91 +++---
 login-utils/setpwnam.c      |  312 ++++++++++----------
 login-utils/vipw.c          |  210 ++++++-------
 13 files changed, 1152 insertions(+), 1116 deletions(-)
 create mode 100644 login-utils/chregpw.h

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
