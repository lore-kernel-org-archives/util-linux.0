Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40577 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752430Ab2HAJsf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 1 Aug 2012 05:48:35 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q719mZmp026389
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Wed, 1 Aug 2012 05:48:35 -0400
Date: Wed, 1 Aug 2012 11:48:33 +0200
From: Karel Zak <kzak@redhat.com>
To: Niels de Vos <ndevos@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [RFC] mount: overwrite options from /etc/fstab when given on the
 commandline
Message-ID: <20120801094833.GC1019@x2.net.home>
References: <1343812301-24896-1-git-send-email-ndevos@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343812301-24896-1-git-send-email-ndevos@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 01, 2012 at 11:11:41AM +0200, Niels de Vos wrote:
> it seems that some of the options given in /etc/fstab are not overloaded by
> options given on the mount-commandline.

Well, all depends on kernel (and FS driver) how mount options are
evaluated. We have no any strict rules for 'source' and 'mount
options' in the mount(2) syscall.

The generic convention (!= rule) is that the option overwrites an
option previously specified in the mount options string:

    aaa=x,bbb,aaa=y     -> aaa should be 'y'

This is reason why mount(8) only appends the options from command line
to the options string from fstab.

Anyway, depends on FS driver how the options string will be
interpreted -- for example btrfs supports duplicate device= mount
option.


> Some options are not allowed to be
> passed multiple times (like the SElinux context options) and mounting will fail
> if options are present in both /etc/fstab and on the commandline.

This is stupid SELinux disadvantage and SELinux should be fixed.

> Is there a reason for not overloading the options from /etc/fstab by the
> options given on the commandline?
> 
> The patch below changes the behaviour of mount so that options on the
> commandline replace options given in /etc/fstab. 

I'd like to avoid that mount(8) tries to understand filesystem specific
options. The command mount(8) has no clue about the options (non-VFS
options). For example:

fstab:
    /dev/sda    /mnt    btrfs   device=/dev/sdb     0   0

command line:

    mount /mnt -o device=/dev/sdc,device=/dev/sdd


so the final mount options string:

    device=/dev/sdb,device=/dev/sdc,device=/dev/sdd

.. and this all is pretty valid for btrfs.


I'd like to implement for the next release 2.23 a new command line
options to specify a way how compose the final options string in the
mount(8). It's already in our Documentation/TODO file, see
--options-mode, probably something like:

    --options-mode={ignore,append,prepend,replace,dedup}

or so.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
