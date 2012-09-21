Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:7010 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756284Ab2IULM7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 21 Sep 2012 07:12:59 -0400
Date: Fri, 21 Sep 2012 13:12:53 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/3] fdisk: add guid
Message-ID: <20120921111253.GA18699@x2.net.home>
References: <1345550594.2664.5.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1345550594.2664.5.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 21, 2012 at 02:03:14PM +0200, Davidlohr Bueso wrote:
>  fdisks/cfdisk.c         |    2 +-
>  fdisks/common.h         |   16 ++++-
>  fdisks/fdiskbsdlabel.h  |   38 +++++-----
>  fdisks/fdisksgilabel.c  |   38 +++++-----
>  fdisks/fdisksunlabel.c  |   34 ++++----
>  fdisks/i386_sys_types.c |  198 +++++++++++++++++++++++-----------------------
>  6 files changed, 169 insertions(+), 157 deletions(-)
[....]
> +
> +/* Globally unique identifier */
> +struct fdisk_guid {
> +	uint32_t   time_low;
> +	uint16_t   time_mid;
> +	uint16_t   time_hi_and_version;
> +	uint8_t    clock_seq_hi;
> +	uint8_t    clock_seq_low;
> +	uint8_t    node[6];
> +};
>  
>  struct systypes {
> -	unsigned char type;
> -	char *name;
> +	uint16_t          type;
> +	struct fdisk_guid guid;
> +	const char        *name;
>  };

I don't like this hack. On all places in fdisk where we need systypes
is available fdisk_context struct where is ideal place to store label
specific stuff (ideally by any label specific function in fdisk_label).

>  #ifdef	DKTYPENAMES
>  static struct systypes xbsd_fstypes[] = {
> -        {BSD_FS_UNUSED, "unused"},
> -	{BSD_FS_SWAP,   "swap"},
> -	{BSD_FS_V6,     "Version 6"},
> -	{BSD_FS_V7,     "Version 7"},
> -	{BSD_FS_SYSV,   "System V"},
> -	{BSD_FS_V71K,   "4.1BSD"},
> -	{BSD_FS_V8,     "Eighth Edition"},
> -	{BSD_FS_BSDFFS, "4.2BSD"},

it's really strange to modify  BSD or DOS stuff when we need to add
GPT. All what we need is to move this stuff to label specific files
and make generic API for the structs. It's better to to this work now
than modify all the entries and later fix the API.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
