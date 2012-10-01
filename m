Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:28328 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821Ab2JAHZs (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 1 Oct 2012 03:25:48 -0400
Date: Mon, 1 Oct 2012 09:25:42 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 2/3] fdisk: add GPT support
Message-ID: <20121001072542.GC9064@x2.net.home>
References: <1345550602.2664.6.camel@offbook>
 <20120927120314.GB18644@x2.net.home>
 <1348782668.2541.17.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348782668.2541.17.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Sep 27, 2012 at 11:51:08PM +0200, Davidlohr Bueso wrote:
> >     - remove global label-specific variables (e.g. gpt ents[])
> 
> Do you mean this?
>  static struct gpt_header *pheader = NULL;
>  static struct gpt_header *bheader = NULL;
>  static struct gpt_entry *ents = NULL;

 yes, and also many others in fdisk{dos,bsd,...}.c files

> If so, the reason for it being global is that it's accessed by the
> fdisk_label struct members, which, as you know, callers/users cannot
> know of label-specific stuff (only fdisk_context).

 Think about it as about a shared library. Maybe one day we will want
 to support work with more contexts of more labels, nested partition
 tables (bsd within dos) etc. And it's also about code readability.

 We have everywhere fdisk_context, so fix this problem should not be a
 problem.

> >     - add '<something>' to fdisk menu to print details about selected
> >       partition (uuid, type uuid, type name, name, etc...)
> > 
> >     - add '<something>' to menu to print details about the partition
> >       table (header, backup header, locations, number of allocated
> >       entries, used entries, offset of entry table and offset and size
> >       of data area, etc.)
> 
> Perhaps in verify?

 Maybe. It would be nice to have a way how to get all possible
 information about PT.

> On another note, I am a bit concerned about dealing with writing changes
> on disks with hybrid MBRs and not transforming it the standard
> protective. We need to be able to do so. Any thoughts are appreciated.

 From my point of view hybrid MBRs is nonsense and it's also against
 UEFI standard (there should be protective MBR and GPT, nothing
 other). I don't see a problem to ignore hybrid MBR at all.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
