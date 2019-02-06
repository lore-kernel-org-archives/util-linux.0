Return-Path: <SRS0=v0ph=QN=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B525C169C4
	for <util-linux@archiver.kernel.org>; Wed,  6 Feb 2019 10:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128FB218A3
	for <util-linux@archiver.kernel.org>; Wed,  6 Feb 2019 10:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfBFKvH (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:51:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:22172 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfBFKvH (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 6 Feb 2019 05:51:07 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E60113C2CF9;
        Wed,  6 Feb 2019 10:51:06 +0000 (UTC)
Received: from ws.net.home (ovpn-204-77.brq.redhat.com [10.40.204.77])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C0B560C1C;
        Wed,  6 Feb 2019 10:51:05 +0000 (UTC)
Date:   Wed, 6 Feb 2019 11:51:03 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     util-linux@vger.kernel.org
Subject: Re: [RFC] refactor mnt_fstype_is_pseudofs()?
Message-ID: <20190206105103.7b2g4hxephmkwz7k@ws.net.home>
References: <dff8fba8-3a22-dd4a-1b75-6e636d15b2c9@suse.cz>
 <20190204140301.6oqezi7p26y2rewe@ws.net.home>
 <fefe499e-cef4-58f0-3620-59a7f5ee7324@suse.cz>
 <20190205090031.llcsfd6b7wp43nu5@ws.net.home>
 <e2c18b39-80d8-a44f-4bac-22925395d228@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2c18b39-80d8-a44f-4bac-22925395d228@suse.cz>
User-Agent: NeoMutt/20180716-1108-40af05
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 06 Feb 2019 10:51:07 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Feb 05, 2019 at 06:09:39PM +0100, Stanislav Brabec wrote:
> Dne 05. 02. 19 v 10:00 Karel Zak napsal(a):
> > On Mon, Feb 04, 2019 at 05:38:56PM +0100, Stanislav Brabec wrote:
> >>> If we will keep the fstype lists in the code than we can use it as
> >>> the first attempt, if the name is not in the list than use your
> >>> heuristic.
> >>
> >> It makes sense.
> > 
> > Note that source path may be a relative path without any '/'. It's
> > very unusual, but possible.
> 
> I am aware of the fact that the driver can provide anything. Do we have any examples, where kernel or FUSE driver provides relative source path?


This is mount(2) syscall feature; for example I have "simple_mount",
just main() with mount(2) call: 

 # cd /dev
 # simple_mount sdc /mnt/test ext4 1

 # grep sdc /proc/self/mountinfo 
 530 94 8:32 / /mnt/test ro,relatime shared:275 - ext4 sdc ro,stripe=512
                                                       ^^^

> I am just working on a list of all pseudo file systems available in
> the basic openSUSE repositories. Currently I have ~20 FUSE file
> systems to inspect.
> 
> We also may have two lists: One list of pseudo file systems, second
> list of obscure pseudo file systems (that don't use relative paths).
> If the source does not start with "/" and file system is not in one
> of these lists, mount will return error. I can imagine that we can
> move this list from code to /etc/libmount/pseudofs.d/.

Some filesystems classification is already in /proc/filesystems. The
problem is that the list is incomplete (contains already loaded
filesystems only).

Maybe we need a generic filesystems classification rather than pseudo-filesystems
specific list. We also keep in the code table to convert magic numbers
to FS name (see mnt_statfs_get_fstype()).

What about /etc/libmount/fs.d/ for arbitrary filesystems and in the files
keep all the hints:

  <name> <type> <magic> 

for example:

  autofs nodev 0x0187
  cifs   netfs 0xff534d42

The another possibility is not call mnt_resolve_path() on mount
output. The problem is that we need mnt_fs_is_pseudofs() on another
places like fstrim.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
