Return-Path: <SRS0=wrJr=TN=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C361C04AB1
	for <util-linux@archiver.kernel.org>; Mon, 13 May 2019 09:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0772920989
	for <util-linux@archiver.kernel.org>; Mon, 13 May 2019 09:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbfEMJI1 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 13 May 2019 05:08:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728544AbfEMJI1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 13 May 2019 05:08:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3A84630832C5;
        Mon, 13 May 2019 09:08:27 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.205.130])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 780F668D74;
        Mon, 13 May 2019 09:08:26 +0000 (UTC)
Date:   Mon, 13 May 2019 11:08:23 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Ian Kent <raven@themaw.net>
Cc:     util-linux@vger.kernel.org
Subject: Re: Using the upcoming fsinfo()
Message-ID: <20190513090823.2qys6sv4tspbr3b2@ws.net.home>
References: <6f811f1739162f229e25ed0755e2eb45a76f4c41.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f811f1739162f229e25ed0755e2eb45a76f4c41.camel@themaw.net>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 13 May 2019 09:08:27 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, May 13, 2019 at 01:33:22PM +0800, Ian Kent wrote:
> Some of you may know that David Howells is working on getting
> a new system call fsinfo() merged into the Linux kernel.
> 
> This system call will provide access to information about mounted
> mounts without having to read and parse file based mount tables
> such as /proc/self/mountinfo, etc.
> 
> Essentially all mounts have an id and one can get the id of a
> mount by it's path and then use that to obtain a large range
> of information about it.
> 
> The information can include a list of mounts within the mount
> which can be used to traverse a tree of mounts or the id used
> to lookup information on an individual mount without the need
> to traverse a file based mount table.
> 
> I'd like to update libmount to use the fsinfo() system call
> because I believe using file based methods to get mount
> information introduces significant overhead that can be
> avoided. 
> 
> Because the fsinfo() system call provides a very different way
> to get information
> about mounts, and having looked at the current
> code, I'm wondering what will be
> the best way to go about it.
> 
> Any suggestions about the way this could best be done, given
> that the existing methods must still work, will be very much
> appreciated.

It would be nice to start with some low-level things to read info
about a target (mountpoint) into libmnt_fs, something like:

    int mnt_fsinfo_fill_fs(chat char *tgt, struct libmnt_fs *fs)

and fill create a complete mount table by fsinfo():

    int mnt_fsinfo_fill_table(struct libmnt_table *tab)

... probably add fsinfo.c to code to keep it all together.

So, after then we can use these functions in our code. 

The nice place where is ugly overhead with the current mountinfo is
context_umount.c code, see lookup_umount_fs() and
mnt_context_find_umount_fs(). In this code we have mountpoint and we
need more information about it (due to redirection to umount.<type>
helpers, userspace mount options, etc.). It sounds like ideal to use
mnt_fsinfo_fill_fs() if possible.

The most visible change will be to use mnt_fsinfo_fill_table() with in
mnt_table_parse_file() if the file name is "/proc/self/mountinfo".
This will be huge improvement as we use this function in systemd on
each mount table change...

The question is how easily will be to replace mountinfo with fsinfo().

Note that we have also #util-linux on freenode IRC.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
