Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp1.ono.com ([62.42.230.162]:20677 "EHLO smtp1.ono.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780AbbFFEZn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 6 Jun 2015 00:25:43 -0400
From: Guillem Jover <guillem@hadrons.org>
To: util-linux@vger.kernel.org
Cc: Steven Chamberlain <steven@pyro.eu.org>
Subject: [PATCH 0/3] Handle lack of F_DUPFD_CLOEXEC support
Date: Sat,  6 Jun 2015 06:19:04 +0200
Message-Id: <1433564347-9515-1-git-send-email-guillem@hadrons.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi!

These patches make the code gracefully handle missing F_DUPFD_CLOEXEC
support at build and run-time. This affects at least current GNU/kFreeBSD
systems. I've included the last patch so that GNU/kFreeBSD systems can
immediately benefit from F_DUPFD_CLOEXEC before glibc is updated there,
but if you prefer to omit that one out of disgust, that would be fine I
guess.

While the actual problem is that sysfs code is being built and used on
non-Linux systems, it is too entrenched to get rid of it w/o substantial
amounts of work. Also GNU/kFreeBSD does have limited sysfs support via
the compat linsysfs, so it might not be entirely useless there. But it
certainly is not useful on GNU/Hurd though, at least not currently.

The patches were tested by Steven Chamberlain.

Thanks,
Guillem

Guillem Jover (3):
  lib/fileutils: Add new dup_fd_cloexec function
  lib/sysfs: Use dup_fd_cloexec instead of direct call to fcntl
  include/c: Define F_DUPFD_CLOEXEC on kFreeBSD systems if missing

 include/c.h         |  6 ++++++
 include/fileutils.h |  1 +
 lib/fileutils.c     | 30 ++++++++++++++++++++++++++++++
 lib/sysfs.c         |  2 +-
 4 files changed, 38 insertions(+), 1 deletion(-)

-- 
2.2.1.209.g41e5f3a

