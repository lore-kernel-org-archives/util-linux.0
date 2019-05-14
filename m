Return-Path: <SRS0=bVSf=TO=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A23C04AA7
	for <util-linux@archiver.kernel.org>; Tue, 14 May 2019 00:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18EAC21880
	for <util-linux@archiver.kernel.org>; Tue, 14 May 2019 00:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="OoDvSFWq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cCvWttch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfENAXH (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 13 May 2019 20:23:07 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39865 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726635AbfENAXH (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 13 May 2019 20:23:07 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 681A5245E4;
        Mon, 13 May 2019 20:23:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 13 May 2019 20:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        EZVB1HzziB126mCmKLH3yhn9rb8M8aJaCFFqCoooMM0=; b=OoDvSFWqRIWOzCCo
        6/QMiDyWIPsTj/+xCrFg8VPreeItTispQSgR0nICSDRAfd6Olzkf13rG6bZToyXo
        sEx6NZVxgYXZXND7XxEL2jrj9TwUMuoqlbHZmdw7DAbYKjpye6HgE0jXQdjYtaL/
        CeCEdxamYK8Tb4pLiyJzOVsHVTuySBsbN2OQuxGyQH8jjgOsowarVCh2slFkkvtb
        CzPV5V1/gtS89sAT4/HR81k5WlSicowdsauDlWvsCca7+Iu7qNnlDrrfdIOo/Mgr
        EhnSA3UgvwjFr323e8RRvoQBaFAGL/AEX541A2TwY2W6MGz9WyVzGWTos2NiSAfg
        tGVhzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=EZVB1HzziB126mCmKLH3yhn9rb8M8aJaCFFqCoooM
        M0=; b=cCvWttchvqvZoLiVM3LJUpmWPFt4bPGLQNni6+MuaiUd4mK1B744mdDQC
        16Trf0r12HM0ua1P3QYRtaYgXAKERW6jhu/sop7W3m3myu1B/I30qhvlPQ3Ws5ZJ
        K8JYXUblO/zqJxBPksCIJkgO2Y9B6GkybuIXC9GyaTy1cj4Ai50qnOrU7fOe9TDL
        5WzTAc2WKdTlrfwh9c5OZBfHANRzUnQnHQ6tjbp6raeNeBLOEYsCDn8sf8IwIuIf
        IdV0GSuYPM0t+RC2gwTdYwqq+h1DTky6m2iMcqPpv1D60cpEr5w6IQMFmt6Ke+ar
        eU5iXQBSol2OYRYzg4xdLTc/sxNNw==
X-ME-Sender: <xms:aQraXH6tn2cCv2DDvbD75HQN0ywI2eQ8XVEdTuwqpw3tBzA5uZvFOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrleehgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftgfoggfgsehtjeertdertdejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecukfhppeduudekrddvtdekrd
    ehiedrudduvdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgif
    rdhnvghtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:aQraXEHyvpl7RhIxX0g-dPSff6WcDa2Hm8wOasNOHa8AEW8Ir3q7kA>
    <xmx:aQraXAuPEaFVYsyp9t87U5-FMYYOW1A30Xx-eWvZATO9mqsu1f_N8A>
    <xmx:aQraXA8iCAxlqGetwYAidTM-V9VgSiIzuZ4W8V9anH7mkzGS2fqtBg>
    <xmx:agraXLjTIvpfp5udxvZBPZQcya-pNCq8zPSeLuhY1evimty9YX1HvQ>
Received: from pluto.themaw.net (unknown [118.208.56.112])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6A296103D2;
        Mon, 13 May 2019 20:23:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by pluto.themaw.net (Postfix) with ESMTP id 574281C004D;
        Tue, 14 May 2019 08:23:02 +0800 (AWST)
Message-ID: <466a727a4f4a51c3ad953d2151c9ef19a2259d69.camel@themaw.net>
Subject: Re: Using the upcoming fsinfo()
From:   Ian Kent <raven@themaw.net>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Date:   Tue, 14 May 2019 08:23:02 +0800
In-Reply-To: <20190513090823.2qys6sv4tspbr3b2@ws.net.home>
References: <6f811f1739162f229e25ed0755e2eb45a76f4c41.camel@themaw.net>
         <20190513090823.2qys6sv4tspbr3b2@ws.net.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, 2019-05-13 at 11:08 +0200, Karel Zak wrote:

Hi Karel,

Thanks for giving me some suggestions on where to focus
my efforts.

> On Mon, May 13, 2019 at 01:33:22PM +0800, Ian Kent wrote:
> > Some of you may know that David Howells is working on getting
> > a new system call fsinfo() merged into the Linux kernel.
> > 
> > This system call will provide access to information about mounted
> > mounts without having to read and parse file based mount tables
> > such as /proc/self/mountinfo, etc.
> > 
> > Essentially all mounts have an id and one can get the id of a
> > mount by it's path and then use that to obtain a large range
> > of information about it.
> > 
> > The information can include a list of mounts within the mount
> > which can be used to traverse a tree of mounts or the id used
> > to lookup information on an individual mount without the need
> > to traverse a file based mount table.
> > 
> > I'd like to update libmount to use the fsinfo() system call
> > because I believe using file based methods to get mount
> > information introduces significant overhead that can be
> > avoided. 
> > 
> > Because the fsinfo() system call provides a very different way
> > to get information
> > about mounts, and having looked at the current
> > code, I'm wondering what will be
> > the best way to go about it.
> > 
> > Any suggestions about the way this could best be done, given
> > that the existing methods must still work, will be very much
> > appreciated.
> 
> It would be nice to start with some low-level things to read info
> about a target (mountpoint) into libmnt_fs, something like:
> 
>     int mnt_fsinfo_fill_fs(chat char *tgt, struct libmnt_fs *fs)
> 
> and fill create a complete mount table by fsinfo():
> 
>     int mnt_fsinfo_fill_table(struct libmnt_table *tab)
> 
> ... probably add fsinfo.c to code to keep it all together.
> 
> So, after then we can use these functions in our code. 

Ok, thanks for this,

> 
> The nice place where is ugly overhead with the current mountinfo is
> context_umount.c code, see lookup_umount_fs() and
> mnt_context_find_umount_fs(). In this code we have mountpoint and we
> need more information about it (due to redirection to umount.<type>
> helpers, userspace mount options, etc.). It sounds like ideal to use
> mnt_fsinfo_fill_fs() if possible.

That sounds like an ideal opportunity for improvement by using
fsinfo(). I'll look there too.

> 
> The most visible change will be to use mnt_fsinfo_fill_table() with in
> mnt_table_parse_file() if the file name is "/proc/self/mountinfo".
> This will be huge improvement as we use this function in systemd on
> each mount table change...
> 
> The question is how easily will be to replace mountinfo with fsinfo().

I've been looking at libmount but I'm not sure I was focusing on
libmnt_fs so I'm not sure yet.

A large part of doing this early is to find out what's missing
and see if it's possible to update fsinfo().

For example, the devanme in mountinfo which can be different to
the devname returned by fsinfo(), David has said it's not straight
forward to change but at least he's aware of it and thinking about
it.

Thanks
Ian

