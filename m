Return-Path: util-linux-owner@vger.kernel.org
Received: from g4t0014.houston.hp.com ([15.201.24.17]:28823 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754497AbaA1VfV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 28 Jan 2014 16:35:21 -0500
Message-ID: <1390944918.11839.11.camel@buesod1.americas.hpqcorp.net>
Subject: Re: fdisk: add GPT partition types for plain dm-crypt and LUKS
From: Davidlohr Bueso <davidlohr@hp.com>
To: Christoph Anton Mitterer <calestyo@scientia.net>
Cc: util-linux@vger.kernel.org, Phillip Susi <psusi@ubuntu.com>
Date: Tue, 28 Jan 2014 13:35:18 -0800
In-Reply-To: <1390943356.7021.7.camel@heisenberg.scientia.net>
References: <1390934933.15213.17.camel@heisenberg.scientia.net>
	 <52E819BF.4090503@ubuntu.com>
	 <1390943356.7021.7.camel@heisenberg.scientia.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, 2014-01-28 at 22:09 +0100, Christoph Anton Mitterer wrote:
> On Tue, 2014-01-28 at 15:57 -0500, Phillip Susi wrote:
> > Why?
> Sure... some people (including myself) have pointed out arguments in the
> thread over at the dm-crypt mailinglist, like:
> - for plain dm-crypt it's a "good" way to make it recognisable
> - partitioning tools can use it to hint what a partition contains
> - and after all, partition types do exist, whether they make sense and
> are used or not... and I think it's better to have some standardised
> value which people may set (if they want) even if it's nowhere used,..
> instead of having them set something which may actually cause issues
> even if only in the future.
> 
> > Linux doesn't use partition IDs.
> Phew... that's not fully true... not even for the kernel which I think
> still contains the code to do MD auto assembly with 0.9 superblocks when
> some MBR partition type is set...
> 
> And there are probably many tools (fdisk ;-) ) out there which some how
> use or at least display the types.

I don't have any particular objections to this.

