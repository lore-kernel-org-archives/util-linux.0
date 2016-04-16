Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34600 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbcDPSeN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 16 Apr 2016 14:34:13 -0400
Received: by mail-wm0-f65.google.com with SMTP id n3so14006954wmn.1
        for <util-linux@vger.kernel.org>; Sat, 16 Apr 2016 11:34:12 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 0/7]: ubuntu bug tracker fixes
Date: Sat, 16 Apr 2016 19:34:05 +0100
Message-Id: <1460831649-11484-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

Here are four patches that I wrote after looking Ubuntu bug tracker.

https://launchpad.net/ubuntu/+source/util-linux/+bugs?search=Search&field.status=New&orderby=importance&start=0 

The patches are in same branch as few other changes that I wrote this week. 
But as everyone can see I'm not resubmitting the three first changes to
avoid unnecessary noise.


----------------------------------------------------------------
The following changes since commit a772281dff903b9e761c4d8a6c2ecad7d5f944ba:
  libmount: make kernel_fs_postparse() more robust (2016-04-15 14:48:29 +0200)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git 2016wk15
for you to fetch changes up to ceac24ce1d41903f73f2e96993333708ce97ca3b:
  mount: try to tell what mount was doing when it failed (2016-04-16 19:05:58 +0100)
----------------------------------------------------------------

Sami Kerola (7):
  docs: optinal option arguments should be long-only
  script: close file descriptors on exec
  sulogin: make fopen O_CLOEXEC specifier usage portable
  script: avoid trying fclose(NULL)
  script: check status of writes when closing outputs
  dmesg: --notime should not suppress --show-delta
  mount: try to tell what mount was doing when it failed

 Documentation/boilerplate.c            | 10 +++++-----
 Documentation/howto-man-page.txt       | 22 ++++++++++++++++++++--
 Documentation/howto-usage-function.txt |  2 +-
 login-utils/sulogin-consoles.c         |  4 ++--
 sys-utils/dmesg.c                      |  1 -
 sys-utils/mount.c                      |  9 +++++++--
 term-utils/script.c                    | 20 ++++++++++++--------
 7 files changed, 47 insertions(+), 21 deletions(-)

-- 
2.8.0

