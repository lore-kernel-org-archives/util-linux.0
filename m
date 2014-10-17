Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39154 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750729AbaJQG4G (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 17 Oct 2014 02:56:06 -0400
Date: Fri, 17 Oct 2014 08:56:00 +0200
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Fwd: Bug#764331: mount: "mount --bind -o remount" doesn't
 preserve flags
Message-ID: <20141017065600.GY8057@x2.net.home>
References: <5433bec30004719200003ea0000046dea00002d646a1@amlmta037.auone-net.jp>
 <5433F1AD.6070500@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5433F1AD.6070500@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Oct 07, 2014 at 09:59:09AM -0400, Phillip Susi wrote:
> I thought that it had been established that the kernel did not support
> any other flags with MS_BIND, but this bug report seems to show that
> it did, and the new util-linux silently discards the flags.  Is this a
> bug?

It only happens when you use "--bind" rather than "-o bind".

# strace -e mount ./mount  -o bind,remount,nosuid  /mnt/test
mount("/dev/sdb", "/mnt/test", 0x225ad60, MS_NOSUID|MS_NOEXEC|MS_REMOUNT|MS_RELATIME|MS_BIND, "stripe=32") = 0

# strace -e mount ./mount --bind -o remount,nosuid  /mnt/test 
mount("none", "/mnt/test", 0x6d6240, MS_MGC_VAL|MS_NOSUID|MS_REMOUNT|MS_BIND, NULL) = 0

Fixed in git tree, will be in 2.25.2. Thanks!

    Karel


> 
> 
> - -------- Forwarded Message --------
> Subject: Bug#764331: mount: "mount --bind -o remount" doesn't preserve
> flags
> Resent-Date: Tue, 07 Oct 2014 10:36:01 +0000
> Resent-From: Kusanagi Kouichi <slash@ac.auone-net.jp>
> Resent-To: debian-bugs-dist@lists.debian.org
> Resent-CC: Debian util-linux Maintainers <ah-util-linux@debian.org>
> Date: Tue, 07 Oct 2014 10:21:55 +0000
> From: Kusanagi Kouichi <slash@ac.auone-net.jp>
> Reply-To: Kusanagi Kouichi <slash@ac.auone-net.jp>, 764331@bugs.debian.org
> To: Debian Bug Tracking System <submit@bugs.debian.org>
> 
> Package: mount
> Version: 2.25.1-3
> Severity: normal
> 
> Since I upgraded mount from 2.20.1-5.11 to 2.25.1-3,
> "mount --bind -o remount" doesn't preserve flags anymore.
> 
> # mount -V
> mount from util-linux 2.20.1 (with libblkid and selinux support)
> # grep /tmp /proc/self/mountinfo
> 24 15 0:22 / /tmp rw,nosuid,nodev,relatime - tmpfs /tmp rw
> # strace -e trace=mount mount --bind -o remount,noexec /tmp
> mount("tmp", "/tmp", 0x4104a4,
> MS_MGC_VAL|MS_NOSUID|MS_NODEV|MS_NOEXEC|MS_REMOUNT|MS_BIND, NULL) = 0
> +++ exited with 0 +++
> # grep /tmp /proc/self/mountinfo
> 24 15 0:22 / /tmp rw,nosuid,nodev,noexec,relatime - tmpfs /tmp rw
> 
> # mount -V
> mount from util-linux 2.25.1 (libmount 2.25.0: selinux, assert, debug)
> # grep /tmp /proc/self/mountinfo
> 24 15 0:22 / /tmp rw,nosuid,nodev,relatime - tmpfs /tmp rw
> # strace -e trace=mount mount --bind -o remount,noexec /tmp
> mount("none", "/tmp", 0x125a2f0,
> MS_MGC_VAL|MS_NOEXEC|MS_REMOUNT|MS_BIND, NULL) = 0
> +++ exited with 0 +++
> # grep /tmp /proc/self/mountinfo
> 24 15 0:22 / /tmp rw,noexec,relatime - tmpfs /tmp rw
> 
> - -- System Information:
> Debian Release: jessie/sid
>   APT prefers unstable
>   APT policy: (500, 'unstable'), (1, 'experimental')
> Architecture: amd64 (x86_64)
> 
> Kernel: Linux 3.17.0-rc7 (SMP w/4 CPU cores)
> Locale: LANG=ja_JP.eucJP, LC_CTYPE=ja_JP.eucJP (charmap=EUC-JP)
> Shell: /bin/sh linked to /bin/dash
> 
> Versions of packages mount depends on:
> ii  libc6          2.19-11
> ii  libmount1      2.25.1-3
> ii  libselinux1    2.3-2
> ii  libsmartcols1  2.25.1-3
> 
> mount recommends no packages.
> 
> Versions of packages mount suggests:
> pn  nfs-common  <none>
> 
> - -- no debconf information
> 
> 
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2.0.17 (MingW32)
> 
> iQEcBAEBAgAGBQJUM/GtAAoJEI5FoCIzSKrwMt0IAJXE1nKf1Qul61ZGTp+8PrkP
> jECbRXXOAgzGniZc8M8ZoTLTbnPsbuvHjLNkhgBpha5o6a3lulEX4sOJq4uWp4wD
> zFLMKRIa4QxbKvvGlLUyulbmMju53GCZk2ZGXrP5YMMhlpQFhbbN1TTzpgbTrtSS
> 7939KUTfDUZozm1MbauQqP8/yweOcRN88SHplRT5M+547Fw21/954a8nY2+XwZS4
> mNcUpgnz/X6dMje9w3pkAYq/vxNtdtQ61J1IVXionWzBFjp0kVp2f+QNdADgqt06
> UpFltonLCiAbHfIhCGEeDM48d5r9xEV/AroszeKq3Xlq2Blyk1CP2/nMmF9cqoM=
> =nO6i
> -----END PGP SIGNATURE-----
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
