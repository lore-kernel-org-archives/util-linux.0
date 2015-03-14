Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f181.google.com ([209.85.192.181]:34396 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbbCNWCy (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 14 Mar 2015 18:02:54 -0400
Received: by pdbni2 with SMTP id ni2so19397108pdb.1
        for <util-linux@vger.kernel.org>; Sat, 14 Mar 2015 15:02:53 -0700 (PDT)
Received: from Sparta ([50.0.225.244])
        by mx.google.com with ESMTPSA id o17sm9801216pdj.26.2015.03.14.15.02.52
        for <util-linux@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Mar 2015 15:02:53 -0700 (PDT)
Date: Sat, 14 Mar 2015 22:02:50 +0000
From: Isaac Dunham <ibid.ag@gmail.com>
To: util-linux@vger.kernel.org
Subject: Trying to avoid incompatability on a mount enhancement
Message-ID: <20150314220249.GC1808@Sparta>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,
I've been thinking about adding a feature to Busybox mount, but I'd
like to check on options that are already claimed in util-linux so I
don't cause a major incompatability.

The feature I'm thinking about is roughly analogous to "mkdir -p" or
"cpio -d":
it creates the mountpoints if needed.
This could be done by calling mkdir -p, or by calling mkdir() from mount.
The point is to allow one to mount /dev, /sys and all their subsystems
in one pass by using 
mount -T /etc/vfstab -a -d
or something like that where /etc/vfstab contains (for example):
===
# Kernel filesystems to mount for bringing up the system
proc	/proc	proc	noexec,nodev,nosuid	0 0
sysfs	/sys	sysfs	noexec,nodev,nosuid	0 0
devfs	/dev	devtmpfs defaults		0 0
devshm	/dev/shm tmpfs	nodev,nosuid		0 0
devpts	/dev/pts devpts	noexec,nodev,nosuid	0 0
===

I'm thinking that the option should be ignored with -o bind,
because that may take a file or a directory.

Do you have any comments about the concept?

As far as I can see, -d, -m, and -p are all available (at least in
the version of util-linux mount that ships in Jessie).
Are there any plans to use any of these options?

Also, is there any interest in seeing this in util-linux mount?
(I'd assume some of the corresponding code would be added to libmount,
but I haven't really looked at util-linux code before--just Busybox and
Toybox mount(8) implementations.)

Thanks,
Isaac Dunham


