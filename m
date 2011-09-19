Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:34160 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753172Ab1ISN3Q (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 19 Sep 2011 09:29:16 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 673068EE5B
	for <util-linux@vger.kernel.org>; Mon, 19 Sep 2011 15:29:15 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Subject: [PATCH 0/7] sfdisk improvements
Date: Mon, 19 Sep 2011 15:29:08 +0200
Message-Id: <1316438955-20790-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi all,


First two patches are just minor fixes unrelated to the rest.


Third one makes sfdisk not to issue a fatal warning (overridable, though),
if the partition does not start/end on the cylinder boundary and
the unit specified is other than cylinders. These days,
we shouldn't care about the CHS that much IMO...


The last 4 sfdisk patches are followup to
http://www.spinics.net/lists/util-linux-ng/msg04760.html
http://www.spinics.net/lists/util-linux-ng/msg04761.html

The goal these patches is to use 64 bit integer types in sfdisk to
represent the sector numbers. This makes it easy to check if the numbers
overflew the DOS pt limit, which is 2^32. I also tried to detect the overflow
right at the moment when it happens (like Karel suggested), but this turned out
to be ugly.

I decided to use unsigned long long to represent the 64-bit integers,
which might not be the best choice (maybe we should use off_t or uint64_t
instead??). Comments are welcomed.

Thanks,


Petr Uzel (7):
  sfdisk: file descriptor is of int type
  sfdisk: fix weird indentation in msdos_partition()
  sfdisk: make the cylinder boundary check less fatal
  sfdisk: get_disksize() returns long long
  sfdisk: introduce get_ull() function
  sfdisk: use unsigned long long to internally represent sector number
  sfdisk: warn if partition exceeds partition table limits

 fdisk/sfdisk.c |  165 +++++++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 121 insertions(+), 44 deletions(-)

-- 
1.7.3.4

