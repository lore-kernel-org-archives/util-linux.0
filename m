Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qw0-f46.google.com ([209.85.216.46]:53049 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726Ab1GYWmr convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 25 Jul 2011 18:42:47 -0400
Received: by qwk3 with SMTP id 3so2282086qwk.19
        for <util-linux@vger.kernel.org>; Mon, 25 Jul 2011 15:42:46 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Date: Tue, 26 Jul 2011 00:42:46 +0200
Message-ID: <CAG27Bk0EkOe=dbt88PFtDKwyo9+0mZPaysVh0eM9BjWu4X8+vQ@mail.gmail.com>
Subject: [git pull] hwclock fixes
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The following changes since commit 63de90d44f4f05a1f48942148edcf1740ba4a623:

  libmount: cleanup docs (2011-07-23 01:27:39 +0200)

are available in the git repository at:
  https://github.com/kerolasa/lelux-utiliteetit hwclock

Sami Kerola (11):
      hwclock: remove clock-ppc.c
      hwclock: remove misleading information
      hwclock: coding style clean up
      hwclock: include-what-you-use header check
      hwclock: move path definitions to pathnames.h
      hwclock: remove inb & outb functions
      hwclock: fix compiler warnings
      hwclock: remove goto statement
      hwclock: add variable initialization
      hwclock: move long options away from global scope
      hwclock: validate numeric option arguments

 configure.ac           |    2 -
 hwclock/Makefile.am    |    4 +-
 hwclock/README.hwclock |   10 -
 hwclock/clock-ppc.c    |  459 ---------
 hwclock/clock.h        |   20 +-
 hwclock/cmos.c         |  936 +++++++++---------
 hwclock/hwclock.c      | 2654 ++++++++++++++++++++++++------------------------
 hwclock/kd.c           |  239 +++---
 hwclock/rtc.c          |  565 ++++++-----
 include/pathnames.h    |    9 +
 10 files changed, 2223 insertions(+), 2675 deletions(-)
 delete mode 100644 hwclock/clock-ppc.c

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
