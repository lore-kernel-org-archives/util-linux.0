Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41233 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755718AbbBCMZU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 3 Feb 2015 07:25:20 -0500
Date: Tue, 3 Feb 2015 13:24:46 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: cfdisk: miscellaneous problems
Message-ID: <20150203122446.GB6862@ws.net.home>
References: <1422909321.2943422.222132517.7C4A7C3F@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422909321.2943422.222132517.7C4A7C3F@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 02, 2015 at 09:35:21PM +0100, Benno Schulenberg wrote:
> 1) If on my disk I delete the extended partition sda4, and then try
> to create a partition of 0 bytes (entering a bare 0 at the prompt),
> the response is: "Minimum size is 1 bytes."  What it problably means
> is: 1 sector, in my case 512 bytes (which I confirmed by trying 511
> and 512).
> 
> 2) When instead of 0 I enter 1, the response is: "Too small partition
> size specified."  But now it has *exited* from the size prompt.  This
> is inconsistent.  Upon any invalid entry it shows a message and stays
> at the prompt, but when the number is too small (but not zero) it
> exits.

This all is the same issue, the code checked for "1" rather than for
sector size. It should be fixed now.

> 3) When I try to create a partition of size 12J (typo for K), it says
> "Failed to parse size." but replaces what I typed with the amount
> of free space, leaving me puzzled about what I typed wrong.  It
> should instead leave at the prompt whatever I typed, so I can
> correct it.

Fixed.

> 4) Okay, now I create sda4 as a primary partition of 12K.  It gets
> created, but the shown size is 0 sectors and 0 bytes.  ??

Yeah, libfdisk align and of the partition, unfortunately for very
small sizes (smaller than gain used for alignment) it does not make
sense.

Fixed.

> 5) In the remaining free space I try to create another partition, of
> whatever size cfdsik itself suggests.  Nothing is created and there
> is no error message.  (In my opinion cfdisk shouldn't even ask for
> a size in this situation, but say that no more partitions can be
> created.  Maybe even the Free space should be labeled as Unusable
> free space instead.)

I guess it was problem with free space calculation. It should be fixed now.

> 6) Delete sda4 again and create a primary sda4 of 12M.  Then in the
> remaining free space try to create another partition of whatever size
> cfdisk proposes.  The response is (all on one line):
> "Impossible to create another primary partition. If you want to create more partitions, you must replace a primary partition wit"
> On my terminal the message is truncated.  On an 80-character device
> the message would read:
> "Impossible to create another primary partition. If you want to create more parti"
> More parties?  Of course!  :)  But not very helpful.  An upcoming patch
> will suggest a shorter one.

I'm going to merge it. Thanks!

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
