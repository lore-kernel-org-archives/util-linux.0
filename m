Return-Path: <SRS0=qI5U=TW=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BF5C282CE
	for <util-linux@archiver.kernel.org>; Wed, 22 May 2019 13:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C182089E
	for <util-linux@archiver.kernel.org>; Wed, 22 May 2019 13:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="sR+EvAis";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="18t9EXP4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbfEVNOo (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 22 May 2019 09:14:44 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48731 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728827AbfEVNOn (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 22 May 2019 09:14:43 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id D68D223AB2;
        Wed, 22 May 2019 09:14:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 22 May 2019 09:14:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        XyyslKWy9qQpGNlBt/4/amD3Evkhehm3JT/kOyWplTc=; b=sR+EvAisrRr0ycUe
        k07v1lywWska98MG9dkEF/TR1iUfjRAKV2uA79gNnS5ytQBdJ8soDc7vQOP+CUaB
        aXO2gADQB/xWO8aYbiOVF4cmNjKOCIz3yB3c06Izgp5j7iETmrgyusOOhsYJeKLP
        Ni9Hl14qfCYSHGvwaUxbclD6CoW91vUcLlTOKSo4PI+8x6QPqQZ5KSA//9P5HAlw
        0O4QnD2C3GLgCoCAcxkI6eGq1XWogEOGgI9gEGe6DWWAQE7Lfy3zJ+C5et8mjD9W
        pFS892BRUI5L3BHOYnzAPycZg4fSyDxbQOj92+mv1c5RjVDOT08clhacxoG8eO7e
        4+Xc8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=XyyslKWy9qQpGNlBt/4/amD3Evkhehm3JT/kOyWpl
        Tc=; b=18t9EXP4/XvWHz+coDDBNCWbP1SZBNvVcDNQggPJo/GRj5h+rWPNSMH20
        T9CPUzmkFFiMx8W4cS5peaQGMsENauJnsaOrUdQ2GscSGpPTvdRSVborV2evRgv3
        YLcR6c92NNY/5c+aljoM3uG/TM3HcbXK9iGoeIbL4EGjHAJAJSQila4Pq+lUH0jD
        B//OFW369RtSy0n9RIJVoFrllJeKFnMv/0sI9J3HVWgO05x5AEse3NCfNqcyczHw
        sc5TmI4OewQdiGinfcFn738XjrA22KWlvYSoOTH+unYOmcS6cXJSWWmpj/T35sMg
        0HUd8Ir14T43U8cTheYkH56RAJhPQ==
X-ME-Sender: <xms:QkvlXB_Y_l7hh3B4IXzHa0qlUkhApn3qF1EKPCbH9qKVRRINO4Z8Rw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudduvddgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtofgggfesthekredtredtjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucfkphepuddukedrvddtle
    drudejkedrfeehnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgr
    fidrnhgvthenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:QkvlXJ_UZiiDa_DrCfoPBWMMLHTo9sJWBnsflDi_7INdCfUvnKBZBQ>
    <xmx:QkvlXKBODj3r8csv1nze7Qi5EdKTb7ACcWmdagaHCzbWyPptDIQ9Pw>
    <xmx:QkvlXJxDOiQMWJRlfy1Oqr4L0sSL_uhf2dWs4ddnwBKaZd4PO_1lbA>
    <xmx:QkvlXNI6NeadYARz2kGZIROvUkDF80WOCCK4zyjJ_vao7JDymJ8R7w>
Received: from pluto.themaw.net (unknown [118.209.178.35])
        by mail.messagingengine.com (Postfix) with ESMTPA id 84D88380087;
        Wed, 22 May 2019 09:14:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by pluto.themaw.net (Postfix) with ESMTP id 05A781C0133;
        Wed, 22 May 2019 21:14:37 +0800 (AWST)
Message-ID: <562668febcf41e61ab2477235ee7ce4610bc1e8d.camel@themaw.net>
Subject: Re: Using the upcoming fsinfo()
From:   Ian Kent <raven@themaw.net>
To:     L A Walsh <lkml@tlinx.org>, Karel Zak <kzak@redhat.com>,
        util-linux@vger.kernel.org
Date:   Wed, 22 May 2019 21:14:37 +0800
In-Reply-To: <5CE4CFEF.5020100@tlinx.org>
References: <6f811f1739162f229e25ed0755e2eb45a76f4c41.camel@themaw.net>
         <20190513090823.2qys6sv4tspbr3b2@ws.net.home>
         <466a727a4f4a51c3ad953d2151c9ef19a2259d69.camel@themaw.net>
         <20190515114538.bgtfh6rudcyvrmn2@ws.net.home>
         <c6baaf226834e7238807fa469335c79eeadb4f34.camel@themaw.net>
         <5CE44FA5.9000700@tlinx.org>
         <17de51282f3c3fafd3e99bff5aeb49d17e70b603.camel@themaw.net>
         <5CE4CFEF.5020100@tlinx.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, 2019-05-21 at 21:28 -0700, L A Walsh wrote:
> On 2019/05/21 19:59, Ian Kent wrote:
> > I hadn't planned on producing a utility but I do have code that I've
> > been using to learn how to use the call.
> > 
> > I could turn that into a utility for use from scripts at some point.
> >   
> 
> ---
>      not required, but thought it might allow for more types of
> tests/usages.
> If it is really of limited or no benefit, I'm not gonna lose sleep.
> > Avoiding having to parse string output (from the proc file system
> > mount tables) is one of the key reasons to use a system call for
> > this.
> > 
> > So this isn't the point of doing it.
> >   
> 
> I get that....this wasn't intended as an 'endpoint' just a way for those
> not
> implementing and using the calls to get a feel for the call.Â  It may
> not serve
> a useful purpose in this case, but some system calls have direct
> user-utils that
> are very useful.Â  The lack of a system util to manipulate the pty calls
> forced
> me to write a few-line 'C' prog just to make 1 call to approve
> something.Â  Eventually switched to a more robust interface in perl.

We will see, I will end up with something that's more or less example
usage anyway.

There will be a fairly complex example in the kernel source tree too,
along with other examples, in the samples/vfs directory.

> > The work for this (and some other new system calls) is being done
> > in the kernel so the issue isn't to work out what the system call
> > returns as much as it is to ensure the system call provides what's
> > needed, implement things that aren't yet done and work out ways of
> > providing things that are needed but can't yet be provided.
> >   
> 
> ----
>   No basic testing that the kernel call is producing exactly what you are
> expecting is needed, I take it.

Right, that's why I have written some code.

> >   
> > > 	From there -- those first options could be moved to only 
> > > be used with '--raw' or '--direct' switch with a new switch associated
> > > with, perhaps another util that may eventually be replaced  with this
> > > code that uses the new utility.
> > > 
> > > 	All of that could be done along with a continuing build and
> > > release of the older tools until such time as the new call-using
> > > tool replaces all of the old tool to whatever standard is wanted.
> > >     
> > 
> > I haven't looked at the tools at all.
> > 
> > It may be worth looking at them but fork and exec a program then
> > parse text output isn't usually the way these utilities should
> > work.
> >   
> 
> ----
>   That wasn't what I meant -- just that if you implement functionality in
> a test prog, eventually you would be able to library-ize the call for other
> purposes.Â  I got the impression th

Yes, the investigative code I write will make it's way into
whatever is done.

> > The focus is on eliminating the need to read the proc file system
> > mount tables including getting the mount information for any single
> > mount.
> > 
> > When these tables are large and there's a fair bit of mount/umount
> > activity this can be a significant problem.
> > 
> > Getting this information usually means reading on average half of
> > the whole mount table every time and it's not possible to get info.
> > on a single mount without doing this.
> >   
> 
> ----
>     That sounds like a deficiency in the way mount tables are displayed.

Displayed is probably not the right word, generated is closer to
what happens in the kernel.

> 
> Just like you can look at all net-io with a device name in column 0,
> there's another directory where each device is a filename entry and by
> looking at that
> you can just look at the stats of that 1 file.
> 
> Block devices have the same type of all-or-single readouts as well.
> 
> So why not mounts?

That's worth some thought but I don't think it will work in
this case.

People will take a copy of the information provided in proc
and then use it to lookup a mount. So you still need to read
the list of mounts in the kernel to generate that to find the
piece of information you need that identifies a mount.

And you would still need to traverse the list of mounts to
generate any given view of this information on every access
too so there's not much to be gained since that's what causes
the problem with heavy mount table usage in the first place.

It's not like a fairly static device that will stay around
for a reasonable amount of time, and where the code to
maintain the proc or sysfs entries is local to a particular
driver or file system so the code is localized to a particular
sub-system and therefore reasonably maintainable.

In this case the list of mounts is present in the core VFS
and the VFS needs to cater for all the places where mounts
can be made and accessed.

And there can be significant and frequent changes to mount
information which is another reason it needs to be generated
on access.

Keep in mind the goal of the mount structures is not to make
information about them available but to make the operations
that need to be done on them doable in a sensible amount of
time.

> 
> I.e. why not subdirs for 'by-mountpoint', or by-device, or
> whole-dev-vs.partition, or by UUID....like some things are listed
> in /dev.  That would allow you to narrow in on the mount you want for
> doing whatever.

TBH, I can't see that amount of code being added to the VFS
for this.

Simple annoyances like some mounts won't have a UUID, or won't
have partition devices associated with them will also cause
inconsistent views of the mounts.

It's unlikely anyone would be willing to do it if only because
it would make an already complex body of code much, much harder
to maintain.

A system call is a simpler way to make this available while also
being a fairly concentrated body of code which is much easier to
maintain.

Don't forget that any given process can have a different view of
the list of mounts based on mount namespace which is one thing
that makes the VFS mount code quite complex.

Ian

