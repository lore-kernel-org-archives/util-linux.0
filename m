Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:49418 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752015AbbAUSC5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 21 Jan 2015 13:02:57 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0MYOkT-1YI1x03fn7-00V59K for
 <util-linux@vger.kernel.org>; Wed, 21 Jan 2015 19:02:56 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 0/5] some build fixes, noticed with icc
Date: Wed, 21 Jan 2015 19:02:49 +0100
Message-Id: <1421863374-9953-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This is pull request #146 on github
https://github.com/karelzak/util-linux/pull/146 

Ruediger Meier (5):
  tests: python tests should not remove user's LD_LIBRARY_PATH
  build-sys: avoid icc warnings "ignoring unknown option"
  build-sys: free() needs stdlib.h
  build-sys: fix UL_SCANF_TYPE_MODIFIER for icc
  build: fix printf warnings for icc (-Wformat-security)

 configure.ac        | 4 ++++
 m4/compiler.m4      | 7 +++++++
 sys-utils/ipcrm.c   | 2 +-
 sys-utils/lscpu.c   | 8 ++++----
 sys-utils/rtcwake.c | 2 +-
 tests/functions.sh  | 4 ++--
 6 files changed, 19 insertions(+), 8 deletions(-)

-- 
1.8.4.5

