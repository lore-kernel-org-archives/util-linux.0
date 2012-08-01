Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:32059 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753427Ab2HAKLC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 1 Aug 2012 06:11:02 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q71AB2Tg009705
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Wed, 1 Aug 2012 06:11:02 -0400
Message-ID: <501900B4.9040604@redhat.com>
Date: Wed, 01 Aug 2012 12:11:00 +0200
From: Niels de Vos <ndevos@redhat.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: [RFC] mount: overwrite options from /etc/fstab when given on
 the commandline
References: <1343812301-24896-1-git-send-email-ndevos@redhat.com> <20120801094833.GC1019@x2.net.home>
In-Reply-To: <20120801094833.GC1019@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 08/01/2012 11:48 AM, Karel Zak wrote:
 > On Wed, Aug 01, 2012 at 11:11:41AM +0200, Niels de Vos wrote:
 >> it seems that some of the options given in /etc/fstab are not overloaded by
 >> options given on the mount-commandline.
 >
 > Well, all depends on kernel (and FS driver) how mount options are
 > evaluated. We have no any strict rules for 'source' and 'mount
 > options' in the mount(2) syscall.
 >
 > The generic convention (!= rule) is that the option overwrites an
 > option previously specified in the mount options string:
 >
 >      aaa=x,bbb,aaa=y     ->  aaa should be 'y'
 >
 > This is reason why mount(8) only appends the options from command line
 > to the options string from fstab.
 >
 > Anyway, depends on FS driver how the options string will be
 > interpreted -- for example btrfs supports duplicate device= mount
 > option.

Ah, okay, if there are valid use-cases for options to be listed multiple
times, it won't be possible to overload the options from /etc/fstab by the
options from the commandline.

 >> Some options are not allowed to be
 >> passed multiple times (like the SElinux context options) and mounting will fail
 >> if options are present in both /etc/fstab and on the commandline.
 >
 > This is stupid SELinux disadvantage and SELinux should be fixed.

Yeah, sounds like it. I may have a look on how the kernel can handle the
SElinux options better.

 >> Is there a reason for not overloading the options from /etc/fstab by the
 >> options given on the commandline?
 >>
 >> The patch below changes the behaviour of mount so that options on the
 >> commandline replace options given in /etc/fstab.
 >
 > I'd like to avoid that mount(8) tries to understand filesystem specific
 > options. The command mount(8) has no clue about the options (non-VFS
 > options). For example:
 >
 > fstab:
 >      /dev/sda    /mnt    btrfs   device=/dev/sdb     0   0
 >
 > command line:
 >
 >      mount /mnt -o device=/dev/sdc,device=/dev/sdd
 >
 >
 > so the final mount options string:
 >
 >      device=/dev/sdb,device=/dev/sdc,device=/dev/sdd
 >
 > .. and this all is pretty valid for btrfs.

Nice example!

 > I'd like to implement for the next release 2.23 a new command line
 > options to specify a way how compose the final options string in the
 > mount(8). It's already in our Documentation/TODO file, see
 > --options-mode, probably something like:
 >
 >      --options-mode={ignore,append,prepend,replace,dedup}
 >
 > or so.

Hmm, that sounds like it'll solve the problem, unless you'r combining
SElinux contexts and btrsf...

Thanks for your detailed response,
Niels
