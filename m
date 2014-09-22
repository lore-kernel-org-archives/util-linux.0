Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:46819 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754519AbaIVToG (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Sep 2014 15:44:06 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by gateway2.nyi.internal (Postfix) with ESMTP id 5DE3620970
	for <util-linux@vger.kernel.org>; Mon, 22 Sep 2014 15:44:05 -0400 (EDT)
Message-Id: <1411415045.2373997.170469709.45708397@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: what precisely is partition_entry_lba?
Date: Mon, 22 Sep 2014 21:44:05 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Hi,

In libfdisk/src/gpt.c the function gpt_list_disklabel() prints
a GPT header, and one of the things it prints says:

_("Partitions entries LBA: %ju"), h->partition_entry_lba

In the struct this variable is described as:

uint64_t    partition_entry_lba; /* stat LBA of the partition entry array */

This doesn't make sense to me.  Shouldn't this say something
like "Starting block of the array of partition entries" instead?

All this use of 'lba' is confusing to me, as it stands for
"logical block addressing", and what seems to be meant
is simply "logical block" or "logical block number".  No?

Benno

-- 
http://www.fastmail.fm - The way an email service should be

