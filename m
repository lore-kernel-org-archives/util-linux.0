Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34975 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932074AbdBKOK5 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 11 Feb 2017 09:10:57 -0500
Received: by mail-wm0-f66.google.com with SMTP id u63so11017835wmu.2
        for <util-linux@vger.kernel.org>; Sat, 11 Feb 2017 06:10:56 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 0/3] pull: blkreset and blkreport polishing
Date: Sat, 11 Feb 2017 14:10:49 +0000
Message-Id: <20170211141052.26154-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

I should have said this a bit earlier.  It is a pity there are now two new
blkre* tools instead of single 'zblkadm (reset|report)'.  A single command
would have less boilerplating going on, and would form logical path how to
add new features in future.

Oh well, let me propose couple to existing blkre* commands.  I think these
are reasonable changes in any case (will the tools are merged or not).

----------------------------------------------------------------
The following changes since commit 7ccc1643abdd0cb9780ca0304dfdcbc4c5b11eae:
  findmnt: use line separator for --poll output (2017-02-10 17:28:07 +0100)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git blkre
for you to fetch changes up to 70e7defd161f5a03a473256664e9f9c32504d410:
  bash-completion: add blkreset and blkreport completion (2017-02-11 13:58:25 +0000)
----------------------------------------------------------------

Sami Kerola (3):
  blkreport, blkreset: small code clean ups
  man: improve blkreport(8) and blkreset(8) manual pages
  bash-completion: add blkreset and blkreport completion

 bash-completion/blkreset | 34 ++++++++++++++++++++++++++++++++++
 sys-utils/blkreport.8    | 29 ++++++++++++++++++++++++++++-
 sys-utils/blkreport.c    | 43 +++++++++++++++++--------------------------
 sys-utils/blkreset.8     |  9 ++++-----
 sys-utils/blkreset.c     | 17 ++++++++---------
 5 files changed, 91 insertions(+), 41 deletions(-)
 create mode 100755 bash-completion/blkreset

-- 
2.11.1

