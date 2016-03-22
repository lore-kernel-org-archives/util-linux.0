Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:50384 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751384AbcCVQxQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 22 Mar 2016 12:53:16 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0M7Y9j-1ZoeIn29Rv-00xKbC for
 <util-linux@vger.kernel.org>; Tue, 22 Mar 2016 17:53:14 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 0/3] setarch: test improvements
Date: Tue, 22 Mar 2016 17:53:10 +0100
Message-Id: <1458665593-7963-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

As discussed this patch-set tries to fix tests if --uname-2.6 is not
supported and to debug systems where --uname-2.6 even segfaults.

Ruediger Meier (3):
  build-sys: ignore vim .swp files
  setarch: add "exec" message to --verbose
  tests: improve setarch tests regarding --uname-2.6 issues

 .gitignore                  |  1 +
 sys-utils/setarch.c         |  7 ++++--
 tests/expected/misc/setarch | 19 +++++++++++++++-
 tests/ts/misc/setarch       | 54 +++++++++++++++++++++++++++++++++++++--------
 4 files changed, 69 insertions(+), 12 deletions(-)

-- 
1.8.4.5

