Return-Path: util-linux-owner@vger.kernel.org
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:46536 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756329AbbKRQEl (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 18 Nov 2015 11:04:41 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 63EB72079B
	for <util-linux@vger.kernel.org>; Wed, 18 Nov 2015 11:04:40 -0500 (EST)
Message-Id: <1447862680.1454629.443346489.1A298B99@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: cfdisk cuts lines for logical partitions too short
Date: Wed, 18 Nov 2015 17:04:40 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Hi Karel,

In 2.27, the highlight bar of cfdisk is three or four characters
shorter than the width of the screen -- for logical partitions.
I noticed because on a 100-column terminal two letters of a
translation were bitten off.

The culprit is commit ed99eac0e2a83a315c7cf5d8a461df16b3106596.
Before that, the lines were full length.


Btw, in current git, running ./cfdisk aborts here with:

  lt-cfdisk: libblkid/src/probe.c:638: mmap_buffer: 
  Assertion `map_off + map_len >= real_off + len' failed.


Benno

-- 
http://www.fastmail.com - Choose from over 50 domains or use your own

