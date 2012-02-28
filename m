Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48599 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754730Ab2B1Qp0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 28 Feb 2012 11:45:26 -0500
Received: by vcqp1 with SMTP id p1so2644946vcq.19
        for <util-linux@vger.kernel.org>; Tue, 28 Feb 2012 08:45:25 -0800 (PST)
MIME-Version: 1.0
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 00/13] Initial import of sulogin
Date: Tue, 28 Feb 2012 11:45:08 -0500
Message-Id: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is an initial stab at importing sulogin from sysvinit and making it a bit
more universal. I've removed the distro specific code and brought the rest of
it more in line with the style of the remainder of the repo. I've also added
internationalization and cleaned up the manpage.

Dave Reisner (13):
  fstab.5: fix misspelling of deprecated
  sulogin: initial import from sysvinit
  sulogin.8: refactor manpage
  sulogin: whitespace fixes
  sulogin: replace older signal() with sigaction()
  sulogin: remove CHECK_{DES,MD5} defines
  sulogin: remove USE_ONELINE and SANE_TIO defines
  sulogin: use size_t for iterator to avoid cast
  sulogin: get rid of calls to /bin/sash
  sulogin: use pathnames.h for file locations
  sulogin: header/include cleanup
  sulogin: use a more standard usage output
  sulogin: add i18n strings

 login-utils/Makefile.am |    6 +-
 login-utils/sulogin.8   |   60 +++++
 login-utils/sulogin.c   |  556 +++++++++++++++++++++++++++++++++++++++++++++++
 mount/fstab.5           |    2 +-
 4 files changed, 622 insertions(+), 2 deletions(-)
 create mode 100644 login-utils/sulogin.8
 create mode 100644 login-utils/sulogin.c

-- 
1.7.9.2

