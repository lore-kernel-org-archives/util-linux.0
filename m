Return-Path: <SRS0=SH8e=M4=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3B9C04EB9
	for <util-linux@archiver.kernel.org>; Tue, 16 Oct 2018 00:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD33A205C9
	for <util-linux@archiver.kernel.org>; Tue, 16 Oct 2018 00:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD33A205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tlinx.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbeJPIg1 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 16 Oct 2018 04:36:27 -0400
Received: from ishtar.tlinx.org ([173.164.175.65]:44244 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbeJPIg1 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 16 Oct 2018 04:36:27 -0400
Received: from [192.168.3.12] (Athenae [192.168.3.12])
        by Ishtar.sc.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id w9G0maWU030068;
        Mon, 15 Oct 2018 17:48:38 -0700
Message-ID: <5BC53564.80700@tlinx.org>
Date:   Mon, 15 Oct 2018 17:48:36 -0700
From:   L A Walsh <lkml@tlinx.org>
User-Agent: Thunderbird
MIME-Version: 1.0
To:     Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: static linking working w/gnu?  (was Re: [ANNOUNCE] util-linux
 v2.33-rc1)
References: <20180925104701.y2gwtwe2bquynap2@ws.net.home> <5BB15D3A.8040507@tlinx.org> <20181002101454.qm5gzasb5naamnbg@ws.net.home> <5BBB07AA.6010403@tlinx.org> <20181008090956.k6cjvg7ztwt3bnnp@ws.net.home>
In-Reply-To: <20181008090956.k6cjvg7ztwt3bnnp@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 10/8/2018 2:09 AM, Karel Zak wrote:
> I get the warning, but result is still static binary. Don't ask me whyl
> ;-)
>
> $ file ./mount.static 
> ./mount.static: ELF 64-bit LSB executable, x86-64, version 1 (GNU/Linux), statically linked, for GNU/Linux 3.2.0, BuildID[sha1]=b66bae970bf72346cbf6d844e0e48d5dbfd07cc2, with debug_info, not stripped
>
> The problem is the way how glibc uses stuff around NSS. In this case
> glibc needs runtime modules, for more details see...
>   
But not for mount.static, apparently?
> It seems the issue is only getpwnam_r() which is necessary only when
> mount(8) translates gid=<name> to gid=<number>. It's rarely used
> mount(8) feature.
>   
I wonder if this works.

---
Anyway, could you send me your configure line?

FWIW, for mount.static, above, I am getting:
>  file mount.static

mount.static: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), 
dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for 
GNU/Linux 3.2.0, BuildID[sha1]=563cbfb845525273cdb0eb8bb7b0d5bcc5613d80, 
not stripped

^^^--ok, says dynamically linked, but w/what?

If I explicitly disable 'shared', I got what looked like all of util-linux
libs built-in, but still needing all external libs.

FWIW, if I try to test from the build location:
>  ldd .libs/mount
.libs/mount: /usr/lib64/libmount.so.1: version `MOUNT_2.33' not found 
(required by .libs/mount)
.libs/mount: /usr/lib64/libmount.so.1: version `MOUNT_2.30' not found 
(required by .libs/mount)
  linux-vdso.so.1 (0x00007ffc8a77c000)
  libmount.so.1 => /usr/lib64/libmount.so.1 (0x000000305ce00000)
  libblkid.so.1 => //lib64/libblkid.so.1 (0x0000003002c00000)
  libuuid.so.1 => //lib64/libuuid.so.1 (0x0000003002800000)
  librt.so.1 => //lib64/librt.so.1 (0x0000003001c00000)
  libc.so.6 => //lib64/libc.so.6 (0x0000003000800000)
  libselinux.so.1 => /lib64/libselinux.so.1 (0x0000003016e00000)
  /lib64/ld-linux-x86-64.so.2 (0x00007ff504871000)
  libpthread.so.0 => /lib64/libpthread.so.0 (0x0000003000c00000)
  libpcre.so.1 => /lib64/libpcre.so.1 (0x000000300b800000)
  libdl.so.2 => /lib64/libdl.so.2 (0x0000003001000000)

----
Did it used to be the case that dynamic linking would look in the 
"current dir"
for libs?  Seems like the above would break more situations of an in-place
lib being build & tested.

My switches:
>  ../config-233rc1.sh --test
setting basic optimize

Running Config:
./configure -q "CFLAGS=-fpic -march=native -pipe -O2" "LDFLAGS=-fpic 
-march=native -pipe -O2 -Wl,--stats " "--prefix=/ --bindir=/bin 
--sbindir=/sbin --datadir=/usr/share --includedir=/include 
--oldincludedir=/usr/include --libdir=/lib64 
--libexecdir=/lib64/util-linux --localstatedir=/var 
--sharedstatedir=/com --sysconfdir=/etc --enable-chfn-chsh 
--enable-fs-paths-default --enable-last --enable-libmount-support-mtab 
--enable-line --enable-login-chown-vcs --enable-login-stat-mail 
--enable-newgrp --enable-pg --enable-silent-rules 
--enable-static-programs=losetup,mount,umount,fdisk,sfdisk,blkid,nsenter,unshare 
--enable-sulogin-emergency-mount --enable-vipw --enable-write 
--disable-assert --disable-rpath --disable-nls 
--disable-plymouth_support --disable-pylibmount --with-audit 
--with-bashcompletiondir=/usr/share/bash-completion --with-gnu-ld 
--with-ncursesw --with-readline --with-smack --without-python 
--without-systemd --without-systemdsystemunitdir"

using gcc: gcc version 8.2.1 20180817 [gcc-8-branch revision 263612] 
(SUSE Linux)





