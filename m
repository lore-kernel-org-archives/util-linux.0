Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:43116 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753941Ab2JBIFn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 2 Oct 2012 04:05:43 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 5DD30A24CA
	for <util-linux@vger.kernel.org>; Tue,  2 Oct 2012 10:05:42 +0200 (CEST)
Date: Tue, 2 Oct 2012 10:05:13 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 2/3] fdisk: add GPT support
Message-ID: <20121002080513.GA779@foxbat.suse.cz>
References: <1345550602.2664.6.camel@offbook>
 <20120927120314.GB18644@x2.net.home>
 <1348782668.2541.17.camel@offbook>
 <20121001072542.GC9064@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121001072542.GC9064@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 01, 2012 at 09:25:42AM +0200, Karel Zak wrote:
> On Thu, Sep 27, 2012 at 11:51:08PM +0200, Davidlohr Bueso wrote:
> > On another note, I am a bit concerned about dealing with writing changes
> > on disks with hybrid MBRs and not transforming it the standard
> > protective. We need to be able to do so. Any thoughts are appreciated.
> 
>  From my point of view hybrid MBRs is nonsense and it's also against
>  UEFI standard (there should be protective MBR and GPT, nothing
>  other). I don't see a problem to ignore hybrid MBR at all.

+1. While there might be (unfortunately) use cases for hybrid MBRs, I
believe fdisk should _by default_ just ignore such crap and always write
proper protective MBR according to the standard (vanilla parted does
the same).

Some sort of support for hybrid MBRs could be eventually implemented
later.

My 2c,

        Petr

-- 
Petr Uzel
IRC: ptr_uzl @ freenode
