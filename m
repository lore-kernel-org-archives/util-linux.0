Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:53554 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755462AbcCUNEt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 21 Mar 2016 09:04:49 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0MEccf-1ab4YJ1EfR-00FjRe for
 <util-linux@vger.kernel.org>; Mon, 21 Mar 2016 14:04:46 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 0/5] minor cosmetics and build issues for non-Linux
Date: Mon, 21 Mar 2016 14:04:40 +0100
Message-Id: <1458565485-27856-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Ruediger Meier (5):
  build-sys: some libmount test progs are Linux only
  build-sys: pylibmount, mount context is Linux only
  sulogin: ignore missing WEXITED, add warning
  tests: skip ipcs test which require /proc
  ipcs: consolidate output header printing

 libmount/python/Makemodule.am |  6 ++++--
 libmount/python/pylibmount.c  |  2 ++
 libmount/python/pylibmount.h  |  4 ++++
 libmount/src/Makemodule.am    |  6 ++++--
 login-utils/sulogin.c         |  5 +++++
 sys-utils/ipcs.c              | 16 +++++++++++-----
 tests/ts/ipcs/functions.sh    |  2 ++
 7 files changed, 32 insertions(+), 9 deletions(-)

-- 
1.8.4.5

