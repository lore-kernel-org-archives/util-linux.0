Return-Path: <SRS0=Bpzm=QL=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EEEC282C4
	for <util-linux@archiver.kernel.org>; Mon,  4 Feb 2019 14:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A006F2082F
	for <util-linux@archiver.kernel.org>; Mon,  4 Feb 2019 14:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfBDODG (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:03:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60635 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbfBDODF (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 4 Feb 2019 09:03:05 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 137EFC0495B8;
        Mon,  4 Feb 2019 14:03:05 +0000 (UTC)
Received: from ws.net.home (ovpn-117-196.ams2.redhat.com [10.36.117.196])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FA5A5BBD2;
        Mon,  4 Feb 2019 14:03:04 +0000 (UTC)
Date:   Mon, 4 Feb 2019 15:03:01 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     util-linux@vger.kernel.org
Subject: Re: [RFC] refactor mnt_fstype_is_pseudofs()?
Message-ID: <20190204140301.6oqezi7p26y2rewe@ws.net.home>
References: <dff8fba8-3a22-dd4a-1b75-6e636d15b2c9@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dff8fba8-3a22-dd4a-1b75-6e636d15b2c9@suse.cz>
User-Agent: NeoMutt/20180716-1023-ca4e12
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 04 Feb 2019 14:03:05 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Feb 01, 2019 at 12:07:12AM +0100, Stanislav Brabec wrote:
> Hi.
> 
> I got a but report about a dumpfs FUSE filesystem reporting bad mount output.
> 
> The same problem affects other pseudo file systems not listed in mnt_fstype_is_pseudofs():
> # mount | grep encfs
> encfs on /Encrypted type fuse.encfs (rw,nosuid,nodev,relatime,user_id=10027,group_id=100,default_permissions)
> # mkdir encfs
> # mount | grep encfs
> /root/encfs on /Encrypted type fuse.encfs (rw,nosuid,nodev,relatime,user_id=10027,group_id=100,default_permissions)
> ^^^^^^^^^^^
> 
> Debugging shows two reasons why it happens:
> 1) encfs is not listed in mnt_fstype_is_pseudofs()
> 2) mnt_resolve_path() calls canonicalize_path_and_cache() on the kernel output, which makes only a little sense

Where? It should be easy to check by mnt_fs_is_kernel().

> Currently I am aware of three file systems affected at least (i. e. not listed): gvfs (subtype was renamed from gvfs-fuse-daemon to gvfsd-fuse), encfs, dumpfs.
> 
> Easy fix would be adding all of them to the list. But probably much more exists.

It would be nice to have such easy bugfix, so we can backport it to
old version etc. :-)

> More complex would allow to add fuse.*. But it is not correct, because FUSE can be a regular file system based on block device (e. g. fuse ntfs). Yes, such reports "fuseblk" as a default. But still, it can be changed.
> 
> That is why I started thinking about the better fix than adding these three to the list:
> 
> If the column 10 (mount source) of a particular line of /proc/<pid>/mountinfo does not start by "/", then it is a pseudofs. Actually, it could be generalized:

I'm not sure if we always use mnt_fs_is_pseudofs() in situation when
mount source path is available. The libmnt_fs is also able to hold
info about LABEL=foo, etc.

It seems we need to keep mnt_fstype_is_pseudofs() and change
mnt_fs_is_pseudofs() to your suggestion with fallback to
mnt_fstype_is_pseudofs().

> - If it does not contain "/" (or maybe another character) at all, it is a pseudofs.
> - If it contains "/" (or maybe another character), but it does not start by it, it is a network file system.
> - If it starts by "/", it is a regular file system.
> 
> Before implementing, I want to make a wider discussion, whether it could work.
> 
> I talked with a kernel developers, and he told that there is no
> solution "correct by principle". Filesystem developer can provide
> virtually anything as a source. But it could work in most cases.
> 
> What do you think about such change?

If we will keep the fstype lists in the code than we can use it as
the first attempt, if the name is not in the list than use your
heuristic.

> And additionally: Does canonicalization of the kernel output make
> any sense? If not, it could be skipped for commands like a bare
> "mount". (But I am not sure how complicated it would be.)

It depends, kernel canonicalizes mountpoint, but if I good remember it
does not touch source, so if the source is for example symlink and
it's not mounted by mount(8) than whatever is in the kernel output:

 # ln -s /dev/sdc /dev/foo
 # simple_mount /dev/foo /mnt/test ext4 1

 # grep foo /proc/self/mountinfo 
 624 94 8:32 / /mnt/test ro,relatime shared:323 - ext4 /dev/foo ro,stripe=512
                                                       ^^^^^^^^
mount(8) always canonicalizes everything, but in case you use use
something else to call mount(2) syscall...

For mount, findmnt, etc. we make sure (for years) that all is canonical as
it is only way how to keep things consistent. Not sure if we want to
change it and introduce regression in scripts where people use "mount |
grep <devname>".

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
