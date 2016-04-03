Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35026 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbcDCIff (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Apr 2016 04:35:35 -0400
Received: by mail-lf0-f66.google.com with SMTP id c62so17666711lfc.2
        for <util-linux@vger.kernel.org>; Sun, 03 Apr 2016 01:35:34 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 0/3] pull: chrt fixes
Date: Sun,  3 Apr 2016 09:35:26 +0100
Message-Id: <1459672529-2278-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

This pull request comes a little late to be part of the upcoming release,
but perhaps at least the two first changes could be included.  If the
usability improvement is included the new translation string will not going
to have change being translated by v2.28 gets out.  Other than that this is
a trival change set.

----------------------------------------------------------------
The following changes since commit e9cd2e2bd9ec91a0b1050c4aa79555d142985924:
  libmount: Fix possible NULL dereference in get_btrfs_fs_root() (2016-03-31 11:45:55 +0200)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git chrt
for you to fetch changes up to cbeda6d13b98cc63abdd15639ff173b3c2bb8dad:
  chrt: validate priority before trying to use it (2016-04-03 09:26:20 +0100)
----------------------------------------------------------------

Sami Kerola (3):
  chrt: make --sched-* short options to require an argument
  bash-completion: update chrt completion
  chrt: validate priority before trying to use it

 bash-completion/chrt | 40 +++++++++++++++++++++++++++-------------
 schedutils/chrt.c    |  8 ++++++--
 2 files changed, 33 insertions(+), 15 deletions(-)

-- 
2.8.0

