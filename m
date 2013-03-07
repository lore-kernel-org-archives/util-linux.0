Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f175.google.com ([74.125.82.175]:57056 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758218Ab3CGX1a (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 7 Mar 2013 18:27:30 -0500
Received: by mail-we0-f175.google.com with SMTP id x8so317813wey.20
        for <util-linux@vger.kernel.org>; Thu, 07 Mar 2013 15:27:29 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 0/7] kill: modernization after undeprecation
Date: Thu,  7 Mar 2013 23:27:17 +0000
Message-Id: <1362698844-21292-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel, et.al.,

Here are few patches to kill which was undeprecated late last year, see
commit 32fca0e9c49599667d19f157fade6fa46908271a.  I had a look of the
command and decided it should get the same usage(), coding style, etc,
fixes that are done to other commands earlier.

The only notable change in this series is second last patch which will
make kill to use pid_t.  I am sure that is better than having int
representing pids, altough int might often work.  The patch also makes
some pid_t's to be casted long which may be a bit overkill.  Perhaps it
is better to grant enough head room to pid space than cry when type wrap
results to kill of arbitrary process(es).


The following changes since commit 02658d9bb56976b462724b306e9e1f4385ef4b93:

  tests: make utmpdump TZ independent (2013-03-04 13:10:09 +0100)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git 2013wk09

for you to fetch changes up to 4f6dba8146a461dee9e62b5cf5ff62425ad01681:

  docs: add long options and tidy up kill.1 (2013-03-07 23:08:53 +0000)

----------------------------------------------------------------
Sami Kerola (7):
      kill: add long options
      kill: align with howto-usage-function.txt
      kill: use libc error printing facilities and exit values
      kill, procs: fix coding style
      kill, procs: move function declarations to kill.h
      kill, procs: use pid_t for pids
      docs: add long options and tidy up kill.1

 misc-utils/kill.1  |  88 ++++++-----
 misc-utils/kill.c  | 442 ++++++++++++++++++++++++++---------------------------
 misc-utils/kill.h  |   8 +-
 misc-utils/procs.c | 170 +++++++++++----------
 4 files changed, 360 insertions(+), 348 deletions(-)

