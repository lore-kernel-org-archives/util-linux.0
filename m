Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:52636 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752472AbbDWXqL (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 23 Apr 2015 19:46:11 -0400
Message-ID: <55398435.4090504@gmx.com>
Date: Thu, 23 Apr 2015 19:45:57 -0400
From: J William Piggott <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>, Isaac Dunham <ibid.ag@gmail.com>
CC: util-linux@vger.kernel.org
Subject: [PATCH 0/1] hwclock: Remove TZUTC
References: <1429764592-15947-1-git-send-email-ibid.ag@gmail.com>
In-Reply-To: <1429764592-15947-1-git-send-email-ibid.ag@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


The patch that introduced TZUTC should have been rejected.
Mr. Parmelee misunderstood how to use and configure the
zoneinfo 'right' database. This was likely due to the 'right'
database being undocumented. I added information about the
database to the hwclock(8) man-page, and intended to remove
the TZUTC environment variable from hwclock when refactoring.
Since this regression needs to be addressed, it might as well
be removed now.

TZUTC is undocumented and should be safe to remove.



The following changes since commit e2381bdac86bb5fc27fe12ff9994268ea68888dc:

  tests: fix sfdisk GPT test (2015-04-23 15:08:26 +0200)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git 423

for you to fetch changes up to 6b32ffc5f04869da3f8b4460f216e320df0f911a:

  hwclock: Remove TZUTC (2015-04-23 16:26:25 -0400)

----------------------------------------------------------------
J William Piggott (1):
      hwclock: Remove TZUTC

 sys-utils/hwclock.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

