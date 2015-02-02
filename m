Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:42489 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754435AbbBBUfW (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 2 Feb 2015 15:35:22 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id D79C320AFF
	for <util-linux@vger.kernel.org>; Mon,  2 Feb 2015 15:35:21 -0500 (EST)
Message-Id: <1422909321.2943422.222132517.7C4A7C3F@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: cfdisk: miscellaneous problems
Date: Mon, 02 Feb 2015 21:35:21 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


After the recent fixes, I notice some different problems in cfdisk.

1) If on my disk I delete the extended partition sda4, and then try
to create a partition of 0 bytes (entering a bare 0 at the prompt),
the response is: "Minimum size is 1 bytes."  What it problably means
is: 1 sector, in my case 512 bytes (which I confirmed by trying 511
and 512).

2) When instead of 0 I enter 1, the response is: "Too small partition
size specified."  But now it has *exited* from the size prompt.  This
is inconsistent.  Upon any invalid entry it shows a message and stays
at the prompt, but when the number is too small (but not zero) it
exits.

3) When I try to create a partition of size 12J (typo for K), it says
"Failed to parse size." but replaces what I typed with the amount
of free space, leaving me puzzled about what I typed wrong.  It
should instead leave at the prompt whatever I typed, so I can
correct it.

4) Okay, now I create sda4 as a primary partition of 12K.  It gets
created, but the shown size is 0 sectors and 0 bytes.  ??

5) In the remaining free space I try to create another partition, of
whatever size cfdsik itself suggests.  Nothing is created and there
is no error message.  (In my opinion cfdisk shouldn't even ask for
a size in this situation, but say that no more partitions can be
created.  Maybe even the Free space should be labeled as Unusable
free space instead.)

6) Delete sda4 again and create a primary sda4 of 12M.  Then in the
remaining free space try to create another partition of whatever size
cfdisk proposes.  The response is (all on one line):
"Impossible to create another primary partition. If you want to create more partitions, you must replace a primary partition wit"
On my terminal the message is truncated.  On an 80-character device
the message would read:
"Impossible to create another primary partition. If you want to create more parti"
More parties?  Of course!  :)  But not very helpful.  An upcoming patch
will suggest a shorter one.

Benno

-- 
http://www.fastmail.com - Does exactly what it says on the tin

