Return-Path: <SRS0=4DCz=TP=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50305C04E87
	for <util-linux@archiver.kernel.org>; Wed, 15 May 2019 11:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7E32053B
	for <util-linux@archiver.kernel.org>; Wed, 15 May 2019 11:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732296AbfEOLpm (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 15 May 2019 07:45:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46040 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728413AbfEOLpm (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 15 May 2019 07:45:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D899F58E5C;
        Wed, 15 May 2019 11:45:41 +0000 (UTC)
Received: from ws.net.home (ovpn-204-64.brq.redhat.com [10.40.204.64])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 18A7C60BE5;
        Wed, 15 May 2019 11:45:40 +0000 (UTC)
Date:   Wed, 15 May 2019 13:45:38 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Ian Kent <raven@themaw.net>
Cc:     util-linux@vger.kernel.org
Subject: Re: Using the upcoming fsinfo()
Message-ID: <20190515114538.bgtfh6rudcyvrmn2@ws.net.home>
References: <6f811f1739162f229e25ed0755e2eb45a76f4c41.camel@themaw.net>
 <20190513090823.2qys6sv4tspbr3b2@ws.net.home>
 <466a727a4f4a51c3ad953d2151c9ef19a2259d69.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <466a727a4f4a51c3ad953d2151c9ef19a2259d69.camel@themaw.net>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 15 May 2019 11:45:41 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, May 14, 2019 at 08:23:02AM +0800, Ian Kent wrote:
> On Mon, 2019-05-13 at 11:08 +0200, Karel Zak wrote:
> > The nice place where is ugly overhead with the current mountinfo is
> > context_umount.c code, see lookup_umount_fs() and
> > mnt_context_find_umount_fs(). In this code we have mountpoint and we
> > need more information about it (due to redirection to umount.<type>
> > helpers, userspace mount options, etc.). It sounds like ideal to use
> > mnt_fsinfo_fill_fs() if possible.
> 
> That sounds like an ideal opportunity for improvement by using
> fsinfo(). I'll look there too.

Yes.

> > The most visible change will be to use mnt_fsinfo_fill_table() with in
> > mnt_table_parse_file() if the file name is "/proc/self/mountinfo".
> > This will be huge improvement as we use this function in systemd on
> > each mount table change...
> > 
> > The question is how easily will be to replace mountinfo with fsinfo().

Now when I think about it I'm not sure if create complete mount table
by fsinfo() is the right way. Maybe many fsinfo() calls will be more
slow than generate mountinfo file in kernel and read() in userspace.
Not sure.

> I've been looking at libmount but I'm not sure I was focusing on
> libmnt_fs so I'm not sure yet.
>
> A large part of doing this early is to find out what's missing
> and see if it's possible to update fsinfo().

Yes, it would be really nice if we can get all info from fsinfo(). It
opens a new possibilities for us to make things like umount, remount,
and systemd more effective.

> For example, the devanme in mountinfo which can be different to
> the devname returned by fsinfo(), David has said it's not straight
> forward to change but at least he's aware of it and thinking about
> it.

Do you mean "source" field (9th column in mountinfo)? The device is
defined by maj:min (3rd column) in the file (well, whatever the devno
means for things like btrfs;-).

The "source" should be unmodified string as specified in userspace for
mount(2) syscall, otherwise things like "mount -a" can not compare the
kernel mount table with fstab.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
