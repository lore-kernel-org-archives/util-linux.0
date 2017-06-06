Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35606 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751333AbdFFJg0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 6 Jun 2017 05:36:26 -0400
Date: Tue, 6 Jun 2017 11:36:07 +0200
From: Karel Zak <kzak@redhat.com>
To: L A Walsh <lkml@tlinx.org>
Cc: util-linux@vger.kernel.org
Subject: Re: Bug: mount doing bad security check: only root can use -types,
 (effective EUID is 5013)
Message-ID: <20170606093607.xrxel4ny4hjoe4iv@ws.net.home>
References: <5935E44B.8000405@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5935E44B.8000405@tlinx.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 05, 2017 at 04:07:55PM -0700, L A Walsh wrote:
> mount is Using util-linux 2.30-rc2 (libmount 2.30.0: smack, btrfs, mtab,
> debug).
> 
> Trying to mount any file system, thinks I have bad UID:
> 
> Ishtar:/mnt# /bin/mount /dev/tmpfs /mnt/tmpfs -t tmpfs
> mount: only root can use "--types" option (effective UID is 5013)

geteuid() returns 5013, so it runs in restricted mode.

> Ishtar:/mnt# echo "$UID $EUID"
> 0 0

Well, it's better to use commands like "id" rather than rely on env
variables.

> Someone else had a problem w/mount doing some bad check
> that wasn't the case.  Think they had the right bits (CAP_SYS_ADMIN),
> but the mount command was ignoring caps and looking for UID==0.

Yes, it's:

    ruid = getuid();
    euid = geteuid();

    cxt->restricted = (uid_t) 0 == ruid && ruid == euid ? 0 : 1;

in your case geteuid() returns 5013.

BTW, there is no change in this libmount code since 2010, and no
change in "only root can use" mount.c code since year 2013.

> But in this case, it "double" shouldn't matter, since I'm
> running as root.

Try to verify that you're really root ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
