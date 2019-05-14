Return-Path: <SRS0=bVSf=TO=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2A0C04AA7
	for <util-linux@archiver.kernel.org>; Tue, 14 May 2019 00:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B74208C3
	for <util-linux@archiver.kernel.org>; Tue, 14 May 2019 00:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="u1CbAlHh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="retLJBoR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfENAEQ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 13 May 2019 20:04:16 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:57801 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726541AbfENAEQ (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 13 May 2019 20:04:16 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id A1AD024624;
        Mon, 13 May 2019 20:04:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 13 May 2019 20:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        gXmqFccWDhOWFBVmTAi2+ZD8vBdLEoI+KaC4OSNSTFk=; b=u1CbAlHhR9iaWw5B
        7l5wP9Y7lsN5xdgoCZk9ZThTmpcHKPBfZzOC5R4dzkRU9dg3KS8ZL1VSj5OaTMoh
        M4N4iVU5Ar0zFHJPjta/CYUZp7TBf+NWmNbJlvrSOWYTseuzYt+T4pqWQoDzMPta
        l5OLildfdhvYgXdz/Llt80F5v4+emqkdOcMOEfBDrpAfs/JUeE3X8t5AJw7CeQA4
        IPfHnYPQrbnh2Sw9+YSohWsPey9WrGuQKBo3/DaXihPC/PixaOtclN4NQACJTKBP
        gMRZArlhXQdaEgOTubESIxjgS4z5OVkZe/ykCKDRrgLL6B9hqWH9ZtZk5d+TShql
        qIB+9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=gXmqFccWDhOWFBVmTAi2+ZD8vBdLEoI+KaC4OSNST
        Fk=; b=retLJBoR26z2ySQ1FWhXNlmNTKae1pJseE84kZ9eTy3+rsSckaVQSTujX
        XzRo7SESFMsaIAhAQGbv7X6eqp0ABOJSoybz/4PrzjhT1FghdFZop9loIXn2JQON
        eshbzmJSyO02JaymBAsoIRmJ42VYVam8AMQQHyI1OAsFjD1tB8DMUNL8wrgFxWLF
        tiggShiCEct1DATkV9aPZX6+j46+/Ngy6mlKKMzUeTqn9sAUqnDdJMT6hqaMQAzW
        y25fo4wm8apnxujmWpvtN2mMmN6fcvVdJk6ElPUf7pNHc6WNY7tkLNCVD0BBKKDv
        YTe963Yx0JdwpXEZeRqja4+t1gpgg==
X-ME-Sender: <xms:_AXaXLtWJupoX7XHIn8m_9HQW_PCAJH3HeVPV0jvl_ll6Mfug-1AEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrleehgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftgfoggfgsehtjeertdertdejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecukfhppeduudekrddvtdekrd
    ehiedrudduvdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgif
    rdhnvghtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:_AXaXAvlx-NXhISVzZxgoaBWCr_t3XnPi7wkCoWSgO4djHwBZTlVhg>
    <xmx:_AXaXJxUswX_yOZ7R60L-r_v_WLG3b9UukHgfPegt0govzIVhXUZNQ>
    <xmx:_AXaXOg3LuKt1BpA2Pemid6uhXzqUmS1UbyGDH8vGC6t4Kzaqf7Anw>
    <xmx:_AXaXO5we46Sr9cfjLm8D9erR6dI4NOTjKHEyO04qUBEkXUtRV0mfQ>
Received: from pluto.themaw.net (unknown [118.208.56.112])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9F70C103D0;
        Mon, 13 May 2019 20:04:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by pluto.themaw.net (Postfix) with ESMTP id 2D4441C0038;
        Tue, 14 May 2019 08:04:08 +0800 (AWST)
Message-ID: <1ce699a66970da349db70de0438b4b3726d0b652.camel@themaw.net>
Subject: Re: Using the upcoming fsinfo()
From:   Ian Kent <raven@themaw.net>
To:     Bruce Dubbs <bruce.dubbs@gmail.com>, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Date:   Tue, 14 May 2019 08:04:07 +0800
In-Reply-To: <75f27b68-52ff-7f6b-b031-0637ba04df2f@gmail.com>
References: <6f811f1739162f229e25ed0755e2eb45a76f4c41.camel@themaw.net>
         <20190513090823.2qys6sv4tspbr3b2@ws.net.home>
         <75f27b68-52ff-7f6b-b031-0637ba04df2f@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, 2019-05-13 at 11:04 -0500, Bruce Dubbs wrote:
> On 5/13/19 4:08 AM, Karel Zak wrote:
> > On Mon, May 13, 2019 at 01:33:22PM +0800, Ian Kent wrote:
> > > Some of you may know that David Howells is working on getting
> > > a new system call fsinfo() merged into the Linux kernel.
> > > 
> > > This system call will provide access to information about mounted
> > > mounts without having to read and parse file based mount tables
> > > such as /proc/self/mountinfo, etc.
> > > 
> > > Essentially all mounts have an id and one can get the id of a
> > > mount by it's path and then use that to obtain a large range
> > > of information about it.
> > > 
> > > The information can include a list of mounts within the mount
> > > which can be used to traverse a tree of mounts or the id used
> > > to lookup information on an individual mount without the need
> > > to traverse a file based mount table.
> > > 
> > > I'd like to update libmount to use the fsinfo() system call
> > > because I believe using file based methods to get mount
> > > information introduces significant overhead that can be
> > > avoided.
> > > 
> > > Because the fsinfo() system call provides a very different way
> > > to get information
> > > about mounts, and having looked at the current
> > > code, I'm wondering what will be
> > > the best way to go about it.
> > > 
> > > Any suggestions about the way this could best be done, given
> > > that the existing methods must still work, will be very much
> > > appreciated.
> > 
> > It would be nice to start with some low-level things to read info
> > about a target (mountpoint) into libmnt_fs, something like:
> > 
> >      int mnt_fsinfo_fill_fs(chat char *tgt, struct libmnt_fs *fs)
> > 
> > and fill create a complete mount table by fsinfo():
> > 
> >      int mnt_fsinfo_fill_table(struct libmnt_table *tab)
> > 
> > ... probably add fsinfo.c to code to keep it all together.
> > 
> > So, after then we can use these functions in our code.
> > 
> > The nice place where is ugly overhead with the current mountinfo is
> > context_umount.c code, see lookup_umount_fs() and
> > mnt_context_find_umount_fs(). In this code we have mountpoint and we
> > need more information about it (due to redirection to umount.<type>
> > helpers, userspace mount options, etc.). It sounds like ideal to use
> > mnt_fsinfo_fill_fs() if possible.
> > 
> > The most visible change will be to use mnt_fsinfo_fill_table() with in
> > mnt_table_parse_file() if the file name is "/proc/self/mountinfo".
> > This will be huge improvement as we use this function in systemd on
> > each mount table change...
> > 
> > The question is how easily will be to replace mountinfo with fsinfo().
> 
> I may be stating the obvious, but this proposal does not appear to 
> simplify anything because it is kernel version dependent.  From what I 
> understand, the new and old methods will both need to be supported for 
> quite some time.

Yes, it won't really simplify the code base overall because of the
need to support kernel versions that may not have the system call.

But what I didn't talk about is there's a real problem handling
large mount tables with the current method of reading the proc file
system mount tables and these tables can get very large at times.

And this is also about processes being flooded with notifications
due to heavy mount/umount activity and then re-reading the entire
mount table (or at least half on average) on every one because
there's no other way to locate the mount they are looking for.

I think the situation with util-linux isn't so bad in this respect
but I still believe keeping the in-memory mount table up to date
should see improvement. And libmount is used by quite a number of
problematic applications so improving it will translate to
improvement in those applications too.

Ultimately I'll need to look at other applications (perhaps persuade
them to use libmount).

There's also the large number of notifications itself but I'm
still not sure how to improve that. There will be a notifications
implementation to accompany the recent mount-API/fsinfo changes as
well so hopefully we'll be able to improve the situation with the
implementation of that.

> 
> I'm not suggesting that the changes not be made, but I suggest going slow.

The changes will be fairly difficult because the util-linux mount
handling is quite complex.

And the fact that the fsinfo() patch series hasn't been merged yet
means this isn't going to be done quickly (at least not "rushed"
anyway).

But it does need to be done ahead of the merge so we can work out what's
missing in the fsinfo() implementation and try to have things added/fixed
prior to the upstream merge.

Ian

