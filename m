Return-Path: <SRS0=qI5U=TW=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88D1C072B5
	for <util-linux@archiver.kernel.org>; Wed, 22 May 2019 02:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B9720862
	for <util-linux@archiver.kernel.org>; Wed, 22 May 2019 02:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="ebHzZO+z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ECnuBYlc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfEVC7o (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 21 May 2019 22:59:44 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:47305 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727733AbfEVC7o (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 21 May 2019 22:59:44 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 2F08420F20;
        Tue, 21 May 2019 22:59:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 21 May 2019 22:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        9BeZf3sgrasiJQ0ZFM1s57gTbJcyrYtNaNhKxR2PBu0=; b=ebHzZO+zyPBuKAah
        L8ouGEfeTsYuXrKLXxBZ+g9pIFIQjDUnNuCQtReZgp14BHqfC/ryxs15/IhT6wIf
        MrqucrO3ixnKTnl3GBAK4QTomE6WKsJrc9YYpnQFGZr32OHd3SsumTxw9CCDFy7X
        FyqwWoQ90enTd2nOGEX6VGpiXrgEoHOuEVDeu+G0qm6KRN8Cs3DRb0oPNRa7dJas
        VfKmBnDF2esyo/+Gh1JtaOMMCkUEbj4wsN2r97X08LVLCGk6PMu91AEcNHoACPvR
        vwx5/De8C6KmM9YRb6MArpoTpUYX30FWfhohT/oTwZiXNuwsGsJY3PTMI/FThasL
        B4AmqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=9BeZf3sgrasiJQ0ZFM1s57gTbJcyrYtNaNhKxR2PB
        u0=; b=ECnuBYlcBKFjG6tUOf/YQ2eG1qtGoMS1/SbRh+4cX9LFvjYOgoAxTNi6L
        ung6PVE2SfrH34Pu8LSoE0EFwc+XtUkGcPDx2IsG1itdMSb0EzQD5dV8hLmRteuT
        LjKPWRWwAnlf8dz9P5g4ncQ2LnTaInxcAkdqk1HNY6X8mgg+XVHsst1ncVO0Jhed
        /G5dFSo1XEi1Re6IU5lyCYFUvapco5wScWZVcj1MXRyQWeGEdaPshNMYcMuQEenS
        ukPac1+v3pfulk1/0q6tuTngqWkWU84ozHcoFZGKeQejmu0IBx8v04prNltEFodr
        SnKTnlh63w+Dq2g8P/3MYx1b8h2gg==
X-ME-Sender: <xms:HrvkXA85tk67a72SSqCPm5gE4tQV8OnvcSOOh0pZhXUeYzJRzrIKWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudduuddgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtofgggfesthejredtredtjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucfkphepuddukedrvddtke
    drheeirdduuddvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgr
    fidrnhgvthenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:HrvkXM-60neVQa3lElcIZFyN45hfi_jWy4B74ghzr0Dw9-oYMTlU0g>
    <xmx:HrvkXBBxDtPpGQOfHANhYhaGTtUk5w7p2MnutD09s2BwvElJexoagg>
    <xmx:HrvkXEyNeQCa_PkQpcWQsm_1bWkikDmjmYtDDjzFvlIUSVzxJGAPvg>
    <xmx:H7vkXMLJvcT2WODHYgI5YSITzsHdMgcedywqJb1z2al18gGmBdY4zw>
Received: from pluto.themaw.net (unknown [118.208.56.112])
        by mail.messagingengine.com (Postfix) with ESMTPA id 024B2380084;
        Tue, 21 May 2019 22:59:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by pluto.themaw.net (Postfix) with ESMTP id EBA661C005D;
        Wed, 22 May 2019 10:59:38 +0800 (AWST)
Message-ID: <17de51282f3c3fafd3e99bff5aeb49d17e70b603.camel@themaw.net>
Subject: Re: Using the upcoming fsinfo()
From:   Ian Kent <raven@themaw.net>
To:     L A Walsh <lkml@tlinx.org>
Cc:     Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Date:   Wed, 22 May 2019 10:59:38 +0800
In-Reply-To: <5CE44FA5.9000700@tlinx.org>
References: <6f811f1739162f229e25ed0755e2eb45a76f4c41.camel@themaw.net>
         <20190513090823.2qys6sv4tspbr3b2@ws.net.home>
         <466a727a4f4a51c3ad953d2151c9ef19a2259d69.camel@themaw.net>
         <20190515114538.bgtfh6rudcyvrmn2@ws.net.home>
         <c6baaf226834e7238807fa469335c79eeadb4f34.camel@themaw.net>
         <5CE44FA5.9000700@tlinx.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, 2019-05-21 at 12:21 -0700, L A Walsh wrote:
> On 2019/05/15 17:13, Ian Kent wrote:
> > And, as I mentioned above, there's the needed ->fsinfo() super operation
> > to cover the use of the existing ->show_options() operation (provided
> > by pretty much all file systems) to get the file system specific options.
> > 
> > So there's quite a bit of detail to be worked out for fsinfo() to be
> > able to correctly provide all mount information.
> > 
> > But, hey, that was the point of doing this now.
> >   
> 
> ----
> 	Maybe this is already planned behind the scenes, but I wanted to
> throw out my own suggestion -- and that is to start with the new 
> system call usage in its own cmdline tool that can be used just to call
> or exercise the new call -- effectively allowing calling the new kernel call
> from any shell based program -- allowing for a passthrough type operation.

I hadn't planned on producing a utility but I do have code that I've
been using to learn how to use the call.

I could turn that into a utility for use from scripts at some point.

> 
> 	This serves to workout that the call always returns what you 
> expect it to, familiarity with the new call and how it works as well as
> developing a first interface to construct and parse calls-to and 
> output-from the call.

Avoiding having to parse string output (from the proc file system
mount tables) is one of the key reasons to use a system call for
this.

So this isn't the point of doing it.

The work for this (and some other new system calls) is being done
in the kernel so the issue isn't to work out what the system call
returns as much as it is to ensure the system call provides what's
needed, implement things that aren't yet done and work out ways of
providing things that are needed but can't yet be provided.

> 
> 	From there -- those first options could be moved to only 
> be used with '--raw' or '--direct' switch with a new switch associated
> with, perhaps another util that may eventually be replaced  with this
> code that uses the new utility.
> 
> 	All of that could be done along with a continuing build and
> release of the older tools until such time as the new call-using
> tool replaces all of the old tool to whatever standard is wanted.

I haven't looked at the tools at all.

It may be worth looking at them but fork and exec a program then
parse text output isn't usually the way these utilities should
work.

> 
> 	That way, it could allow not disturbing old code
> while code is developed for using the new interface, allowing for
> a seamless switch sometime later with the old progs being left around
> for a release with some 'old' prefix and eventually not built by default
> and moved to the project's "attic" later on.
> 
> 	This can allow for an extended period of feedback & development
> until all users are comfy w/the new tool (which might, in some cases,
> have an option to generate the same output as the old tool (but using
> the new call) for older scripts that might be less easy to update.
> 
> Anyway, just my general caution in code rewrites replacing old libs & utils.
> And again, please forgive my saying something that may be self-evident,
> standard procedure, or already planned, but just not detailed on list.

The focus is on eliminating the need to read the proc file system
mount tables including getting the mount information for any single
mount.

When these tables are large and there's a fair bit of mount/umount
activity this can be a significant problem.

Getting this information usually means reading on average half of
the whole mount table every time and it's not possible to get info.
on a single mount without doing this.

Ian

