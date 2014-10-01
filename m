Return-Path: util-linux-owner@vger.kernel.org
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50606 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750884AbaJATm2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 1 Oct 2014 15:42:28 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by gateway2.nyi.internal (Postfix) with ESMTP id 9BA1A208EC
	for <util-linux@vger.kernel.org>; Wed,  1 Oct 2014 15:34:15 -0400 (EDT)
Message-Id: <1412192055.2499261.174054405.71B41E75@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Karel Zak <kzak@redhat.com>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <20141001075939.GF26272@x2.net.home>
References: <1411415045.2373997.170469709.45708397@webmail.messagingengine.com>
 <20141001075939.GF26272@x2.net.home>
Subject: Re: what precisely is partition_entry_lba?
Date: Wed, 01 Oct 2014 21:34:15 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Wed, Oct 1, 2014, at 09:59, Karel Zak wrote:
> On Mon, Sep 22, 2014 at 09:44:05PM +0200, Benno Schulenberg wrote:
> > uint64_t    partition_entry_lba; /* stat LBA of the partition entry array */
> > 
> > This doesn't make sense to me.  Shouldn't this say something
> > like "Starting block of the array of partition entries" instead?
> 
> EFI standard:
> 
> "The start of the GPT Partition Entry Array is located at the LBA
>  indicated by the Partition Entry LBA field."

Okay.  Then at least the relevant comment needs to be typo-fixed.
(Upcoming patch will do also that.)

> > All this use of 'lba' is confusing to me, as it stands for
> > "logical block addressing", and what seems to be meant
> > is simply "logical block" or "logical block number".  No?
> 
> Well, "LBA" is usually used as unit (especially in storage slang).
> Don't think about it as about abbreviation :-)

I can't -- my brain always auto-expands abbrevs.  :)

Well, I will just have to expand it as "Logical Block Address",
even though the word "Address" is completely superfluous.

> IMHO the fdisk message "Partitions entries LBA: %ju" is fine,

Not quite.  It would have to be either "Partitions entry" (where
one entry contains several paritions) or "Partition entries), where
each entry contains one partition, which is of course the case);
"Partitions entries" is nonsense in English.  Upcoming patch
makes the correction.

Benno

-- 
http://www.fastmail.fm - Access all of your messages and folders
                          wherever you are

