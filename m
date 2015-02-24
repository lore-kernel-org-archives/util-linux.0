Return-Path: util-linux-owner@vger.kernel.org
Received: from cthulhu.worldbroken.com ([173.230.133.178]:46242 "EHLO
	cthulhu.worldbroken.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082AbbBXRYf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 24 Feb 2015 12:24:35 -0500
From: wfp5p@worldbroken.com
To: util-linux@vger.kernel.org
Subject: [PATCH 0/8] fix spelling/typos in man pages
Date: Tue, 24 Feb 2015 12:15:15 -0500
Message-Id: <1424798123-11044-1-git-send-email-wfp5p@worldbroken.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Bill Pemberton <wfp5p@worldbroken.com>

A few spelling and typo fixes in man pages.

Bill Pemberton (8):
  runuser.1: fix spelling implemenation -> implementation
  scriptreplay.1: fix spelling overide -> override
  unshare.1: fix spelling permamently -> permanently
  last.1: fix spelling preferrable -> preferable
  lslogins.1: fix spelling priviliges -> privileges
  hwclock.8.in: fix spelling transfered -> transferred
  prlimit.1: fix typo umlimited -> unlimited
  agetty.8: fix typo unnsupported -> unsupported

 login-utils/last.1        | 2 +-
 login-utils/lslogins.1    | 2 +-
 login-utils/runuser.1     | 2 +-
 sys-utils/hwclock.8.in    | 2 +-
 sys-utils/prlimit.1       | 2 +-
 sys-utils/unshare.1       | 2 +-
 term-utils/agetty.8       | 2 +-
 term-utils/scriptreplay.1 | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.1.0

