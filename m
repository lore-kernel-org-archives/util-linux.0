Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:31375 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752416Ab1HPM5n (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 16 Aug 2011 08:57:43 -0400
Date: Tue, 16 Aug 2011 14:57:38 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [patches] small fixes to some messages and man pages, and some
	questions
Message-ID: <20110816125738.GC14535@nb.net.home>
References: <1313094127.6807.140258128661629@webmail.messagingengine.com> <20110815133430.GG1843@nb.net.home> <1313433269.27812.140258129893485@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313433269.27812.140258129893485@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 15, 2011 at 08:34:29PM +0200, Benno Schulenberg wrote:
> 
> > > Also I do not understand the descriptions of the new options --nested,
> > > --chained, and --onesector.  [...]
> > 
> > The original comment from code: 
> > 
> > /* [...]
> > NESTED: every partition is contained in the surrounding partitions
> >    and is disjoint from all others.
> 
> I still fail to understand. 

 The each logical partition is defined by extended partition table
 (EBR) http://en.wikipedia.org/wiki/Extended_boot_record

 EBR contains usually two partitions:
    1/ data partition (used as a logical partition)
    2/ extended partition (used as a pointer to the next EBR)

 so if you have 5 logical partitions then there is usually 5 small
 partition tables and 5 extended partitions :-) The partitions are
 usually NESTED. 
 
 The top-level (outermost) extended partition is the partition 
 visible for end-users in fdisk output.

> If "contained in the surrounding partitions"
> means "contained in the containing partitions", it says nothing.  If it
> means "contained in the partitions that come before and after", this
> seems impossible to me.  The only way I can make sense of the
> above comment is to read it as follows:
> 
> NESTED: every extended partition is contained within a surrounding
> extended partition [except of course the outermost one] and is disjoint
> from all other extended partitions at the same nesting level.
> 
> (Here I take "disjoint" to mean "does not overlap", but then I still fail
> to understand how "mutually disjoint" is different.)

 NESTED: every extended partition is contained within a parental 
         extended partition. 

 IMHO nothing other is usable in Linux.

> 
> > CHAINED: every data partition is contained in the surrounding partitions
> >    and disjoint from all others, but extended partitions may lie outside
> 
> Is a data partition the same as a logical partition?

Yes. 

IMHO the comment is mess as well as the implementation :-) Don't think
about it too much. We need to rewrite sfdisk and cfdisk....

> >    scriptreplay [options] [-t] timingfile [typescript [divisor]]

 Fixed in the usage().

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
