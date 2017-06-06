Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:59608 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751281AbdFFOPI (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 6 Jun 2017 10:15:08 -0400
Message-ID: <5936B8E5.8050901@tlinx.org>
Date: Tue, 06 Jun 2017 07:15:01 -0700
From: L A Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: Bug: mount doing bad security check: only root can use -types,
 (effective EUID is 5013)
References: <5935E44B.8000405@tlinx.org> <20170606093607.xrxel4ny4hjoe4iv@ws.net.home>
In-Reply-To: <20170606093607.xrxel4ny4hjoe4iv@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> ruid = getuid();
>     euid = geteuid();
>
>     cxt->restricted = (uid_t) 0 == ruid && ruid == euid ? 0 : 1;
>
> in your case geteuid() returns 5013.
>   
----
    But my EUID isn't 5013 ("LOGINUID" is). That's the complaint/bug. 
I looked at 'id': it doesn't show euid:

Ishtar:/tmp> sudo bash -c 'id; echo "UID=$UID, EUID=$EUID"; /bin/mount 
devpts /tmp/mnt -t devpts'
uid=0(root) gid=0(root) groups=...
UID=0, EUID=0
mount: only root can use "--types" option (effective UID is 5013)

I also mentioned I'm using
'sudo', which also sets both the UID & EUID to the new USER (unless
you go out of your way to configure it not to do so -- in which case
many things don't function normally -- including bash which would
operate in restricted mode (like rbash).



