Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:13672 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750850AbaJAH7o (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 1 Oct 2014 03:59:44 -0400
Date: Wed, 1 Oct 2014 09:59:39 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: what precisely is partition_entry_lba?
Message-ID: <20141001075939.GF26272@x2.net.home>
References: <1411415045.2373997.170469709.45708397@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1411415045.2373997.170469709.45708397@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Sep 22, 2014 at 09:44:05PM +0200, Benno Schulenberg wrote:
> 
> Hi,
> 
> In libfdisk/src/gpt.c the function gpt_list_disklabel() prints
> a GPT header, and one of the things it prints says:
> 
> _("Partitions entries LBA: %ju"), h->partition_entry_lba
> 
> In the struct this variable is described as:
> 
> uint64_t    partition_entry_lba; /* stat LBA of the partition entry array */
> 
> This doesn't make sense to me.  Shouldn't this say something
> like "Starting block of the array of partition entries" instead?

EFI standard:

"The start of the GPT Partition Entry Array is located at the LBA
 indicated by the Partition Entry LBA field."

> All this use of 'lba' is confusing to me, as it stands for
> "logical block addressing", and what seems to be meant
> is simply "logical block" or "logical block number".  No?

Well, "LBA" is usually used as unit (especially in storage slang).
Don't think about it as about abbreviation :-)


IMHO the fdisk message "Partitions entries LBA: %ju" is fine, it's
better to follow commonly terminology.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
