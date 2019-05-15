Return-Path: <SRS0=4DCz=TP=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7A3C04E87
	for <util-linux@archiver.kernel.org>; Wed, 15 May 2019 11:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190AB20843
	for <util-linux@archiver.kernel.org>; Wed, 15 May 2019 11:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfEOLnF (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 15 May 2019 07:43:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53494 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732251AbfEOL1i (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 15 May 2019 07:27:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A0D2F19D00C;
        Wed, 15 May 2019 11:27:38 +0000 (UTC)
Received: from ws.net.home (ovpn-204-64.brq.redhat.com [10.40.204.64])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A0D6F608A6;
        Wed, 15 May 2019 11:27:37 +0000 (UTC)
Date:   Wed, 15 May 2019 13:27:34 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Bruce Dubbs <bruce.dubbs@gmail.com>
Cc:     Ian Kent <raven@themaw.net>, util-linux@vger.kernel.org
Subject: Re: Using the upcoming fsinfo()
Message-ID: <20190515112734.vlhloudkpieccdfe@ws.net.home>
References: <6f811f1739162f229e25ed0755e2eb45a76f4c41.camel@themaw.net>
 <20190513090823.2qys6sv4tspbr3b2@ws.net.home>
 <75f27b68-52ff-7f6b-b031-0637ba04df2f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75f27b68-52ff-7f6b-b031-0637ba04df2f@gmail.com>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 15 May 2019 11:27:38 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, May 13, 2019 at 11:04:50AM -0500, Bruce Dubbs wrote:
> On 5/13/19 4:08 AM, Karel Zak wrote:
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
> I may be stating the obvious, but this proposal does not appear to simplify
> anything because it is kernel version dependent.  From what I understand,
> the new and old methods will both need to be supported for quite some time.

Yes, we need to support both versions. 

The new version of the API will significantly improve performance in
situation when you need more information about a mountpoint (for
example fstype, device name, mount options, etc.) -- nice example is
umount or remount.

Now we parse all /proc/self/mountinfo to get one line from the file.
This is problem on systems with huge number of the mountpoints and on
systems where kernel mount table is modified very often and userspace
need to be synchronized with the table (e.g. systemd dependencies,
etc).

All this is about a new syscall fsinfo(). The new mount API (mount(2)
replacement) is another story :-)

> I'm not suggesting that the changes not be made, but I suggest going slow.

For end users all the changes should be invisible. The same libmount
binary should be usable everywhere independently on the new syscalls.

It's possible that we will extend the library API to make it easy for
applications to get info about a mountpoint without mountinfo file
parsing, but it should be also possible to do it with mountinfo as
fallback if there is no fsinfo().

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
