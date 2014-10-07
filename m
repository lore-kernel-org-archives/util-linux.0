Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qg0-f45.google.com ([209.85.192.45]:36857 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbaJGN7m (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 7 Oct 2014 09:59:42 -0400
Received: by mail-qg0-f45.google.com with SMTP id q107so1835196qgd.18
        for <util-linux@vger.kernel.org>; Tue, 07 Oct 2014 06:59:41 -0700 (PDT)
Received: from [10.1.1.238] (fl-67-77-88-12.sta.embarqhsd.net. [67.77.88.12])
        by mx.google.com with ESMTPSA id y13sm14888948qab.24.2014.10.07.06.59.40
        for <util-linux@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Oct 2014 06:59:41 -0700 (PDT)
Message-ID: <5433F1AD.6070500@ubuntu.com>
Date: Tue, 07 Oct 2014 09:59:09 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Fwd: Bug#764331: mount: "mount --bind -o remount" doesn't preserve
 flags
References: <5433bec30004719200003ea0000046dea00002d646a1@amlmta037.auone-net.jp>
In-Reply-To: <5433bec30004719200003ea0000046dea00002d646a1@amlmta037.auone-net.jp>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I thought that it had been established that the kernel did not support
any other flags with MS_BIND, but this bug report seems to show that
it did, and the new util-linux silently discards the flags.  Is this a
bug?


- -------- Forwarded Message --------
Subject: Bug#764331: mount: "mount --bind -o remount" doesn't preserve
flags
Resent-Date: Tue, 07 Oct 2014 10:36:01 +0000
Resent-From: Kusanagi Kouichi <slash@ac.auone-net.jp>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-CC: Debian util-linux Maintainers <ah-util-linux@debian.org>
Date: Tue, 07 Oct 2014 10:21:55 +0000
From: Kusanagi Kouichi <slash@ac.auone-net.jp>
Reply-To: Kusanagi Kouichi <slash@ac.auone-net.jp>, 764331@bugs.debian.org
To: Debian Bug Tracking System <submit@bugs.debian.org>

Package: mount
Version: 2.25.1-3
Severity: normal

Since I upgraded mount from 2.20.1-5.11 to 2.25.1-3,
"mount --bind -o remount" doesn't preserve flags anymore.

# mount -V
mount from util-linux 2.20.1 (with libblkid and selinux support)
# grep /tmp /proc/self/mountinfo
24 15 0:22 / /tmp rw,nosuid,nodev,relatime - tmpfs /tmp rw
# strace -e trace=mount mount --bind -o remount,noexec /tmp
mount("tmp", "/tmp", 0x4104a4,
MS_MGC_VAL|MS_NOSUID|MS_NODEV|MS_NOEXEC|MS_REMOUNT|MS_BIND, NULL) = 0
+++ exited with 0 +++
# grep /tmp /proc/self/mountinfo
24 15 0:22 / /tmp rw,nosuid,nodev,noexec,relatime - tmpfs /tmp rw

# mount -V
mount from util-linux 2.25.1 (libmount 2.25.0: selinux, assert, debug)
# grep /tmp /proc/self/mountinfo
24 15 0:22 / /tmp rw,nosuid,nodev,relatime - tmpfs /tmp rw
# strace -e trace=mount mount --bind -o remount,noexec /tmp
mount("none", "/tmp", 0x125a2f0,
MS_MGC_VAL|MS_NOEXEC|MS_REMOUNT|MS_BIND, NULL) = 0
+++ exited with 0 +++
# grep /tmp /proc/self/mountinfo
24 15 0:22 / /tmp rw,noexec,relatime - tmpfs /tmp rw

- -- System Information:
Debian Release: jessie/sid
  APT prefers unstable
  APT policy: (500, 'unstable'), (1, 'experimental')
Architecture: amd64 (x86_64)

Kernel: Linux 3.17.0-rc7 (SMP w/4 CPU cores)
Locale: LANG=ja_JP.eucJP, LC_CTYPE=ja_JP.eucJP (charmap=EUC-JP)
Shell: /bin/sh linked to /bin/dash

Versions of packages mount depends on:
ii  libc6          2.19-11
ii  libmount1      2.25.1-3
ii  libselinux1    2.3-2
ii  libsmartcols1  2.25.1-3

mount recommends no packages.

Versions of packages mount suggests:
pn  nfs-common  <none>

- -- no debconf information



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQEcBAEBAgAGBQJUM/GtAAoJEI5FoCIzSKrwMt0IAJXE1nKf1Qul61ZGTp+8PrkP
jECbRXXOAgzGniZc8M8ZoTLTbnPsbuvHjLNkhgBpha5o6a3lulEX4sOJq4uWp4wD
zFLMKRIa4QxbKvvGlLUyulbmMju53GCZk2ZGXrP5YMMhlpQFhbbN1TTzpgbTrtSS
7939KUTfDUZozm1MbauQqP8/yweOcRN88SHplRT5M+547Fw21/954a8nY2+XwZS4
mNcUpgnz/X6dMje9w3pkAYq/vxNtdtQ61J1IVXionWzBFjp0kVp2f+QNdADgqt06
UpFltonLCiAbHfIhCGEeDM48d5r9xEV/AroszeKq3Xlq2Blyk1CP2/nMmF9cqoM=
=nO6i
-----END PGP SIGNATURE-----
