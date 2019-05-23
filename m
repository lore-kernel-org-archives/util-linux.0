Return-Path: <SRS0=E45D=TX=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07078C282CE
	for <util-linux@archiver.kernel.org>; Thu, 23 May 2019 01:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF5020B1F
	for <util-linux@archiver.kernel.org>; Thu, 23 May 2019 01:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="HSDUEmm4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zy2oojh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbfEWB2B (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 22 May 2019 21:28:01 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:56565 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727305AbfEWB2A (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 22 May 2019 21:28:00 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 76C0020E15;
        Wed, 22 May 2019 21:27:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 22 May 2019 21:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        nhPU2A1ONnILsRGHFBF/CnooJaV7DJUsYsqOJvT2POQ=; b=HSDUEmm4drojrKHT
        dTb3n9STWg7n3ZY3MkN7IsRs1H0Ax8Ed4UcHadC9s5MdxyNs5FjK3w63y1b913y9
        q/V4YLgGzjnAepgZBRbR4LK2pVG0DF117Hli2P+YdP29++4d9F0P0ICjm2StRWZw
        izqpEo4nx7+fsatSu1wohY094DbE+Y7jHcu1SnfP/BRqr8yR3/VtAYXVz+kn+szf
        sy3zZ8W3wHWPfHmFRV7BdCQZ9K0W8qfKKMzSVhRmvl1k3oUA+vu5swrQQECn20Af
        lfUxNdFmh3TB2gkvONcOvc1IyX0vIEJRAsbQqCjgNACGhbEQqI2iXyNmNTGdEKqq
        +YJFXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=nhPU2A1ONnILsRGHFBF/CnooJaV7DJUsYsqOJvT2P
        OQ=; b=zy2oojh3X7X4hUnFMfYuiPDqPf67CmaB67/nOkLl8SF0bsOPkUz3SyREh
        GRRPfeyfIMw/N5ZqemSDzFTsPl9rycvq5sn6o1ejVA0+d+5pIqdq9DFLhxrMxnu7
        DTDB+9PplIeL6DtqY96W3L/CWXy4N/hVregQkPyRQ/r54MPoJF26I/FhK+sNNHb4
        Iu1JEFImWKDeDzHuVA5NvhKrvsj5gxNJ7bl1oubqUomEVYnBKQ4/nFHp4SBRFxf/
        tE4324FNf3lnVTD3wBEofNuqqLHlHrzbSTM3UNrt5ma4QXZJT85nyY1QX3CTVDSZ
        cNwDbY0lsXGlZDeaBL6WWjc99Y2hA==
X-ME-Sender: <xms:H_flXG335CCvkcXI0Iv-A6fNjoZagP-FLk0P8tiz2i2R8a6ql3hAfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddufedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtofgggfesthekredtredtjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucfkphepuddukedrvddtle
    drudejkedrfeehnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgr
    fidrnhgvthenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:H_flXNCObyRt9BzqJ9s2H2wQQUf3waYVImRSc3IwPL6hXheyejOScw>
    <xmx:H_flXHbuSw5J3IUKyBP6zlkyv02h1ttvJdy5aURGHp-5wTGrS3pfgg>
    <xmx:H_flXBadNumtJl7ihh3h8cCO_V7vS8fYXsfwPFkVFFlXHlr4ivKmWg>
    <xmx:H_flXFNVpEd6gMVg4Ph96gkk4KN26kH_BQFDLKtuJAxhcGMRhnduTg>
Received: from pluto.themaw.net (unknown [118.209.178.35])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8E1FD380084;
        Wed, 22 May 2019 21:27:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by pluto.themaw.net (Postfix) with ESMTP id E51E31C0050;
        Thu, 23 May 2019 09:27:54 +0800 (AWST)
Message-ID: <0fd03768de7481948f435b9a5cd3a8c1e9ec8edb.camel@themaw.net>
Subject: Re: Using the upcoming fsinfo()
From:   Ian Kent <raven@themaw.net>
To:     Karel Zak <kzak@redhat.com>
Cc:     L A Walsh <lkml@tlinx.org>, util-linux@vger.kernel.org
Date:   Thu, 23 May 2019 09:27:54 +0800
In-Reply-To: <20190522135510.cpd2abfddfgmqzhb@ws.net.home>
References: <6f811f1739162f229e25ed0755e2eb45a76f4c41.camel@themaw.net>
         <20190513090823.2qys6sv4tspbr3b2@ws.net.home>
         <466a727a4f4a51c3ad953d2151c9ef19a2259d69.camel@themaw.net>
         <20190515114538.bgtfh6rudcyvrmn2@ws.net.home>
         <c6baaf226834e7238807fa469335c79eeadb4f34.camel@themaw.net>
         <5CE44FA5.9000700@tlinx.org>
         <17de51282f3c3fafd3e99bff5aeb49d17e70b603.camel@themaw.net>
         <5CE4CFEF.5020100@tlinx.org>
         <562668febcf41e61ab2477235ee7ce4610bc1e8d.camel@themaw.net>
         <20190522135510.cpd2abfddfgmqzhb@ws.net.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, 2019-05-22 at 15:55 +0200, Karel Zak wrote:
> On Wed, May 22, 2019 at 09:14:37PM +0800, Ian Kent wrote:
> > On Tue, 2019-05-21 at 21:28 -0700, L A Walsh wrote:
> > > On 2019/05/21 19:59, Ian Kent wrote:
> > > > I hadn't planned on producing a utility but I do have code that I've
> > > > been using to learn how to use the call.
> > > > 
> > > > I could turn that into a utility for use from scripts at some point.
> > > >   
> > > 
> > > ---
> > >      not required, but thought it might allow for more types of
> > > tests/usages.
> > > If it is really of limited or no benefit, I'm not gonna lose sleep.
> > > > Avoiding having to parse string output (from the proc file system
> > > > mount tables) is one of the key reasons to use a system call for
> > > > this.
> > > > 
> > > > So this isn't the point of doing it.
> > > >   
> > > 
> > > I get that....this wasn't intended as an 'endpoint' just a way for those
> > > not
> > > implementing and using the calls to get a feel for the call.Â  It may
> > > not serve
> > > a useful purpose in this case, but some system calls have direct
> > > user-utils that
> > > are very useful.Â  The lack of a system util to manipulate the pty calls
> > > forced
> > > me to write a few-line 'C' prog just to make 1 call to approve
> > > something.Â  Eventually switched to a more robust interface in perl.
> > 
> > We will see, I will end up with something that's more or less example
> > usage anyway.
> 
> I'd like to write something like "mountsh" one day. The idea is to
> have very low-level tool that is able to provide command line
> interface to the all fragments of the new mount API in the same
> granularity as provided by kernel (mount(8) is too high-level in this
> case).

There's fairly simple example usage of several of the mount-api
calls in samples/vfs/test-fsmount.c.

There's the in kernel mount-api documentation at
Documentation/filesystems/mount_api.txt although that's more
oriented to usage within the kerenl.

I was wondering if kernel file systems that have not been converted
to use the new api (but use the legacy mount-api kernel code) will
work properly with the new mount-api? I think they would have to
for the mount-api to be viable but I'm not sure.

LOL, I remember, all those years ago, when you set out to write
libmount and I wanted to convert autofs to use it.

Sadly I got swamped with other work and ended up more concerned
about eliminating proc mount table usage wherever possible in
autofs but with the fsinfo() and mpount-api changes I should be
able to change autofs to use libmount.

After all these years I'll finally be able to get meaningful
error codes that I simply can't get from mount(8) or mount.nfs(8).

The autofs kernel module has been capable of passing these back to
user space for years now and there shouldn't be too many autofs
user space changes needed.

But there's a lot of work to be done on libmount and we absolutely
must keep libmount stable all the way so it's a big challenge.

> 
> Anyway, the primary goal is to use the new syscalls on standard
> places (e.g. libmount) where it improves performance.
> 
> > > I.e. why not subdirs for 'by-mountpoint', or by-device, or
> > > whole-dev-vs.partition, or by UUID....like some things are listed
> > > in /dev.  That would allow you to narrow in on the mount you want for
> > > doing whatever.
> > 
> > TBH, I can't see that amount of code being added to the VFS
> > for this.
> > 
> > Simple annoyances like some mounts won't have a UUID, or won't
> > have partition devices associated with them will also cause
> > inconsistent views of the mounts.
> 
> or more filesystems mounted on the same mountpoint, mountpoint is
> deleted, etc...
> 
>     Karel
> 

