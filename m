Return-Path: util-linux-owner@vger.kernel.org
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:37040 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751576AbbLCTCx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 3 Dec 2015 14:02:53 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 3BD5D203AF
	for <util-linux@vger.kernel.org>; Thu,  3 Dec 2015 14:02:52 -0500 (EST)
Message-Id: <1449169371.410693.457284137.08FE0BCD@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
Cc: Karel Zak <kzak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <1447862680.1454629.443346489.1A298B99@webmail.messagingengine.com>
References: <1447862680.1454629.443346489.1A298B99@webmail.messagingengine.com>
Subject: Re: cfdisk cuts lines for logical partitions too short
Date: Thu, 03 Dec 2015 20:02:51 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Wed, Nov 18, 2015, at 17:04, Benno Schulenberg wrote:
> In 2.27, the highlight bar of cfdisk is three or four characters
> shorter than the width of the screen -- for logical partitions.
> I noticed because on a 100-column terminal two letters of a
> translation were bitten off.
> 
> The culprit is commit ed99eac0e2a83a315c7cf5d8a461df16b3106596.
> Before that, the lines were full length.

Ping?


> Btw, in current git, running ./cfdisk aborts here with:
> 
>   lt-cfdisk: libblkid/src/probe.c:638: mmap_buffer: 
>   Assertion `map_off + map_len >= real_off + len' failed.

Okay.  That works now.

Benno

-- 
http://www.fastmail.com - Access all of your messages and folders
                          wherever you are

