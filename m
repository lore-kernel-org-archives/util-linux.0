Return-Path: <SRS0=XXA/=TQ=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887B7C04E53
	for <util-linux@archiver.kernel.org>; Thu, 16 May 2019 01:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3216120843
	for <util-linux@archiver.kernel.org>; Thu, 16 May 2019 01:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="AZJln6WO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ElhLFFMh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfEPBqc (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 15 May 2019 21:46:32 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45915 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726591AbfEPANi (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 15 May 2019 20:13:38 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 3070E24583;
        Wed, 15 May 2019 20:13:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 15 May 2019 20:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        CVBFKsiQjRokhVbV6TYhX7XuLQuywPcf3zEepqX/ME4=; b=AZJln6WOdDqYq8gs
        +kiFewbi0xAqVKtKDATEV9CRoRh0pFjajiVb2Ur9N7yMQEGnXJX4qGylUqj2fX/D
        mBDONB1yIYrrBzQ3P/5eKOFlUqPicT5jj/+8Dk5xVfujHNRZSZyIgnCAj8k/Z4AO
        170E5C1hszunnc+j3ti3mhl/Oz9p/7tIrBt2tduqzHcV0TH8KqI8Uzf1onqmbXwg
        ehWdMoCmwfYfrGgT0KDnPM/i6qApJyFoCR+/kYyUTuBeseujCf2qzO/IrZwgGsjW
        hxxDA14q3eKMAM6BkIFIXuHYV7+R92MRQtln3kipVI2u3m/mxElOsTLg/ItH+ckJ
        mOyh0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=CVBFKsiQjRokhVbV6TYhX7XuLQuywPcf3zEepqX/M
        E4=; b=ElhLFFMhSyqnPTFLU4IbfT9la40Nrx2hlYILW9xwy82d5wEtgeAMlihaZ
        k5QSoqlAMb9AmM08u414MFmc+6eX8spfkFf3yiGqN7IxU9fquy7OMG93nydEfzAi
        TJYcxecp3r/nYSuzWwZz2LdMN0F6JEew858RdP0DrmQzB3bUK6gtWmXfnuh7Esjr
        MIiK44c2Lz2hIb6dMchVpkmR1pFdDjm7ECtgqUmD70UPEW+YECws8vUTGhjnBXam
        KJUahJ5eG8mRDm+Kq4OtQ3Y3/PHJpIoG9wiEoTUPN098m0wclPyE5XKv5k/CXTHU
        UeTWUHXt3RTT3oCjW/lG6TugpqgnA==
X-ME-Sender: <xms:MKvcXC8IvPohgHvSSETGuyrueEM7ET2nPnBXX4DrJqKHM4p1f0xj5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrleelgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftgfoggfgsehtjeertdertdejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecukfhppeduudekrddvtdekrd
    ehiedrudduvdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgif
    rdhnvghtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:MKvcXBLHLlFa-qtYorGF1ncIX4euRSGLzniMDRuIEcgm-8fOX4rB5g>
    <xmx:MKvcXPJ1ybd6Q7T4pTWjs3UymdhkYW-27Uc59KgQG-cyXdfCnngHjQ>
    <xmx:MKvcXOBYEYp_8HsfUrmjBe6ey2YdAUem6cXfuX4BDSxH7skblekUAw>
    <xmx:MavcXCf0orD-i5zQsM_vtQP5eU-IZZDHCI7RxE24Zm4qRhYGzG-mBA>
Received: from pluto.themaw.net (unknown [118.208.56.112])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2F3F380059;
        Wed, 15 May 2019 20:13:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by pluto.themaw.net (Postfix) with ESMTP id 9290B1C012F;
        Thu, 16 May 2019 08:13:32 +0800 (AWST)
Message-ID: <c6baaf226834e7238807fa469335c79eeadb4f34.camel@themaw.net>
Subject: Re: Using the upcoming fsinfo()
From:   Ian Kent <raven@themaw.net>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Date:   Thu, 16 May 2019 08:13:32 +0800
In-Reply-To: <20190515114538.bgtfh6rudcyvrmn2@ws.net.home>
References: <6f811f1739162f229e25ed0755e2eb45a76f4c41.camel@themaw.net>
         <20190513090823.2qys6sv4tspbr3b2@ws.net.home>
         <466a727a4f4a51c3ad953d2151c9ef19a2259d69.camel@themaw.net>
         <20190515114538.bgtfh6rudcyvrmn2@ws.net.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, 2019-05-15 at 13:45 +0200, Karel Zak wrote:
> On Tue, May 14, 2019 at 08:23:02AM +0800, Ian Kent wrote:
> > On Mon, 2019-05-13 at 11:08 +0200, Karel Zak wrote:
> > > The nice place where is ugly overhead with the current mountinfo is
> > > context_umount.c code, see lookup_umount_fs() and
> > > mnt_context_find_umount_fs(). In this code we have mountpoint and we
> > > need more information about it (due to redirection to umount.<type>
> > > helpers, userspace mount options, etc.). It sounds like ideal to use
> > > mnt_fsinfo_fill_fs() if possible.
> > 
> > That sounds like an ideal opportunity for improvement by using
> > fsinfo(). I'll look there too.
> 
> Yes.
> 
> > > The most visible change will be to use mnt_fsinfo_fill_table() with in
> > > mnt_table_parse_file() if the file name is "/proc/self/mountinfo".
> > > This will be huge improvement as we use this function in systemd on
> > > each mount table change...
> > > 
> > > The question is how easily will be to replace mountinfo with fsinfo().
> 
> Now when I think about it I'm not sure if create complete mount table
> by fsinfo() is the right way. Maybe many fsinfo() calls will be more
> slow than generate mountinfo file in kernel and read() in userspace.
> Not sure.

I'm not sure about the comparison in overhead of this either.

But it's something that needs to be done to get familiar with how
to use fsinfo() and to work out what else needs to be done.

As you know this has already shown that getting file system specific
options isn't working yet for most file systems and I'll need to
implement the missing ->fsinfo() super block operation for (at least
some, probably many) file systems just to continue the work.

There is a slightly less obvious difference using fsinfo() over
the proc file system to get the whole mount table.

When you open a proc file system mount table the kernel takes locks
that will prevent (at least) mount, umount and remount actions until
the proc file is closed.

With fsinfo() the locks need to be taken but at a much finer
granularity so mount actions can continue in parallel.

There's a price for that locking improvement though, if your trying
to get a whole consistent mount table you need to check it hasn't
changed while you read it and if it has you need to start over.

So getting the whole table with fsinfo() will definitely need to be
evaluated against using the proc file system.

But there's quite a lot of processing that happens when the kernel
issues proc mount records, the path calculations are quite expensive
for example, so the difference isn't clear cut.

> 
> > I've been looking at libmount but I'm not sure I was focusing on
> > libmnt_fs so I'm not sure yet.
> > 
> > A large part of doing this early is to find out what's missing
> > and see if it's possible to update fsinfo().
> 
> Yes, it would be really nice if we can get all info from fsinfo(). It
> opens a new possibilities for us to make things like umount, remount,
> and systemd more effective.

I think we will be able to but probably not for a while, there's
quite a bit still to do for fsinfo() by the look of it.

Excessive resource usage of systemd is one of the main motivations
for me doing this so improving that is at the top of the priority
list for me.

> 
> > For example, the devanme in mountinfo which can be different to
> > the devname returned by fsinfo(), David has said it's not straight
> > forward to change but at least he's aware of it and thinking about
> > it.
> 
> Do you mean "source" field (9th column in mountinfo)? The device is
> defined by maj:min (3rd column) in the file (well, whatever the devno
> means for things like btrfs;-).

I do.

> 
> The "source" should be unmodified string as specified in userspace for
> mount(2) syscall, otherwise things like "mount -a" can not compare the
> kernel mount table with fstab.

This string isn't always a string value that comes from the mount
kernel structure, the the proc file system needs to call upon the
file system to get it in some cases.

For example when you see an NFS <server>:<path> in the proc file system
output.

To get this string the proc file system checks if the file system provides
a super block operation ->show_devname() and calls it to get the name
otherwise it copies the string from the mount structure.

As David says, to deal with this it isn't as simple as adding an fsinfo()
request because there are cases where it can have multiple values.

A similar thing is done for field 4 where, if the file system defines
a super block operation ->show_path() it will be called to get the
path, otherwise it's calculated using mount's root. Interestingly NFS
appears to always return "/" for this from its ->show_path() function.

And, as I mentioned above, there's the needed ->fsinfo() super operation
to cover the use of the existing ->show_options() operation (provided
by pretty much all file systems) to get the file system specific options.

So there's quite a bit of detail to be worked out for fsinfo() to be
able to correctly provide all mount information.

But, hey, that was the point of doing this now.

Ian

