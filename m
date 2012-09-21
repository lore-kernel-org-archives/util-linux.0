Return-Path: util-linux-owner@vger.kernel.org
Received: from fencepost.gnu.org ([208.118.235.10]:58195 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754707Ab2IUNFo (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 21 Sep 2012 09:05:44 -0400
Date: Fri, 21 Sep 2012 09:05:43 -0400
From: Davidlohr Bueso <dave@gnu.org>
To: Karel Zak <kzak@redhat.com>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/3] fdisk: add guid
Message-ID: <20120921130543.GA643@gnu.org>
References: <1345550594.2664.5.camel@offbook>
 <20120921111253.GA18699@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120921111253.GA18699@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Sep 21, 2012 at 01:12:53PM +0200, Karel Zak wrote:
> On Tue, Aug 21, 2012 at 02:03:14PM +0200, Davidlohr Bueso wrote:
> >  fdisks/cfdisk.c         |    2 +-
> >  fdisks/common.h         |   16 ++++-
> >  fdisks/fdiskbsdlabel.h  |   38 +++++-----
> >  fdisks/fdisksgilabel.c  |   38 +++++-----
> >  fdisks/fdisksunlabel.c  |   34 ++++----
> >  fdisks/i386_sys_types.c |  198 +++++++++++++++++++++++-----------------------
> >  6 files changed, 169 insertions(+), 157 deletions(-)
> [....]
> > +
> > +/* Globally unique identifier */
> > +struct fdisk_guid {
> > +	uint32_t   time_low;
> > +	uint16_t   time_mid;
> > +	uint16_t   time_hi_and_version;
> > +	uint8_t    clock_seq_hi;
> > +	uint8_t    clock_seq_low;
> > +	uint8_t    node[6];
> > +};
> >  
> >  struct systypes {
> > -	unsigned char type;
> > -	char *name;
> > +	uint16_t          type;
> > +	struct fdisk_guid guid;
> > +	const char        *name;
> >  };
> 
> I don't like this hack. On all places in fdisk where we need systypes
> is available fdisk_context struct where is ideal place to store label
> specific stuff (ideally by any label specific function in fdisk_label).
>

While this patchset was still being developed this was one of the things
Petr and I discussed. Since systypes is usable throughout all of fdisk
I did plan to add it to the fdisk_context structure (with basically the same
members this patch uses - type, guid and name).

 
> >  #ifdef	DKTYPENAMES
> >  static struct systypes xbsd_fstypes[] = {
> > -        {BSD_FS_UNUSED, "unused"},
> > -	{BSD_FS_SWAP,   "swap"},
> > -	{BSD_FS_V6,     "Version 6"},
> > -	{BSD_FS_V7,     "Version 7"},
> > -	{BSD_FS_SYSV,   "System V"},
> > -	{BSD_FS_V71K,   "4.1BSD"},
> > -	{BSD_FS_V8,     "Eighth Edition"},
> > -	{BSD_FS_BSDFFS, "4.2BSD"},
> 
> it's really strange to modify  BSD or DOS stuff when we need to add
> GPT. All what we need is to move this stuff to label specific files
> and make generic API for the structs. It's better to to this work now
> than modify all the entries and later fix the API.
> 

Well ideally we could have a unique systypes than can be used by all labels,
instead of defining it per-label, like what we currently have in DOS, BSD, GPT, SUN.
If needed, we can also limit the scope of each label to use only the systypes it needs from
that structure. Any thoughts?

I honestly don't see much difference between doing it before or after GPT, since all the other
labels need to be adapted anyway. 

Thanks.
