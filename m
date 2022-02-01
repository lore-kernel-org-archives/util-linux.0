Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC7CC433F5
	for <util-linux@archiver.kernel.org>; Tue,  1 Feb 2022 14:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239100AbiBAORn (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 1 Feb 2022 09:17:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31672 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239002AbiBAORn (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 1 Feb 2022 09:17:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643725063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z+QJNysJdYO4wedjeNR5isppSqrvxz+pLBa5axRIKWI=;
        b=DXZLgP4JJV15FIdNvju/Ms7/uPrxMf90CvKCSWIXgvcMfpfqRh9YyhgRZcGNSyrzVmttJu
        TuKvixm8y6dLBLusbLnAGiG0fOhbIQWFqbhHAya+5WaA67peM+DFkP0HOOwyYXZFn15jYz
        iWEBN15EUZ3EhkO/Bev72E4/ln4mpfU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-Ub9wTQKNM5ypzhxH7GsA6w-1; Tue, 01 Feb 2022 09:17:39 -0500
X-MC-Unique: Ub9wTQKNM5ypzhxH7GsA6w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12AB410247A9;
        Tue,  1 Feb 2022 14:17:39 +0000 (UTC)
Received: from ws.net.home (ovpn-112-8.ams2.redhat.com [10.36.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B0184E2CE;
        Tue,  1 Feb 2022 14:17:38 +0000 (UTC)
Date:   Tue, 1 Feb 2022 15:17:35 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Chris Hofstaedtler <zeha@debian.org>
Cc:     util-linux@vger.kernel.org, Masatake YAMATO <yamato@redhat.com>
Subject: Re: [ANNOUNCE] util-linux v2.38-rc1
Message-ID: <20220201141735.oy3qt7iudb5akt7n@ws.net.home>
References: <20220131151432.mfk62bwskotc6w64@ws.net.home>
 <20220131192337.lzpofr4pz3lhgtl3@zeha.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131192337.lzpofr4pz3lhgtl3@zeha.at>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Jan 31, 2022 at 08:23:37PM +0100, Chris Hofstaedtler wrote:
> > The util-linux release v2.38-rc1 is available at
> >      
> >   http://www.kernel.org/pub/linux/utils/util-linux/v2.38/
> >      
> > Feedback and bug reports, as always, are welcomed.
> 
> Thanks.
> 
> Some lsfd tests appear to fail in a Debian sbuild build environment,
> in that they differ in the expected/actual values of DEV[STR] (see
> below). I did not find time to investigate this closer, but thought
> it would be best to report it sooner than later.

Let's add Masatake to CC:

  Karel

> ---snip---
>      script: /<<PKGBUILDDIR>>/tests/ts/lsfd/mkfds-ro-regular-file
>    commands: /<<PKGBUILDDIR>>/
>     helpers: /<<PKGBUILDDIR>>/
>     sub dir: /<<PKGBUILDDIR>>/tests/ts/lsfd
>     top dir: /<<PKGBUILDDIR>>/tests
>        self: /<<PKGBUILDDIR>>/tests/ts/lsfd
>   test name: mkfds-ro-regular-file
>   test desc: read-only regular file
>   component: lsfd
>   namespace: lsfd/mkfds-ro-regular-file
>     verbose: yes
>      output: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-ro-regular-file
>   error log: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-ro-regular-file.err
>   exit code: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-ro-regular-file.exit_code
>    valgrind: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-ro-regular-file.vgdump
>    expected: /<<PKGBUILDDIR>>/tests/expected/lsfd/mkfds-ro-regular-file{.err}
>  mountpoint: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-ro-regular-file-mnt
> 
>          lsfd: read-only regular file         ... FAILED (lsfd/mkfds-ro-regular-file)
> ========= script: /<<PKGBUILDDIR>>/tests/ts/lsfd/mkfds-ro-regular-file =================
> ================= OUTPUT =====================
>      1  ABC         3  r--  REG /etc/passwd   1
>      2  COMMAND,ASSOC,MODE,TYPE,NAME,POS: 0
>      3  PID[RUN]: 0
>      4  PID[STR]: 0
>      5  INODE[RUN]: 0
>      6  INODE[STR]: 0
>      7  UID[RUN]: 0
>      8  UID[STR]: 0
>      9  USER[RUN]: 0
>     10  USER[STR]: 0
>     11  SIZE[RUN]: 0
>     12  SIZE[STR]: 0
>     13  MNTID[RUN]: 0
>     14  DEV[RUN]: 0
>     15  FINDMNT[RUN]: 0
>     16  DEV[STR]: 1
> ================= EXPECTED ===================
>      1  ABC         3  r--  REG /etc/passwd   1
>      2  COMMAND,ASSOC,MODE,TYPE,NAME,POS: 0
>      3  PID[RUN]: 0
>      4  PID[STR]: 0
>      5  INODE[RUN]: 0
>      6  INODE[STR]: 0
>      7  UID[RUN]: 0
>      8  UID[STR]: 0
>      9  USER[RUN]: 0
>     10  USER[STR]: 0
>     11  SIZE[RUN]: 0
>     12  SIZE[STR]: 0
>     13  MNTID[RUN]: 0
>     14  DEV[RUN]: 0
>     15  FINDMNT[RUN]: 0
>     16  DEV[STR]: 0
> ================= O/E diff ===================
> --- /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-ro-regular-file    2022-01-31 19:12:43.802603811 +0000
> +++ /<<PKGBUILDDIR>>/tests/expected/lsfd/mkfds-ro-regular-file  2022-01-31 14:57:47.000000000 +0000
> @@ -13,4 +13,4 @@
>  MNTID[RUN]: 0
>  DEV[RUN]: 0
>  FINDMNT[RUN]: 0
> -DEV[STR]: 1
> +DEV[STR]: 0
> ==============================================
> 
>      script: /<<PKGBUILDDIR>>/tests/ts/lsfd/mkfds-rw-character-device
>    commands: /<<PKGBUILDDIR>>/
>     helpers: /<<PKGBUILDDIR>>/
>     sub dir: /<<PKGBUILDDIR>>/tests/ts/lsfd
>     top dir: /<<PKGBUILDDIR>>/tests
>        self: /<<PKGBUILDDIR>>/tests/ts/lsfd
>   test name: mkfds-rw-character-device
>   test desc: character device with O_RDWR
>   component: lsfd
>   namespace: lsfd/mkfds-rw-character-device
>     verbose: yes
>      output: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-rw-character-device
>   error log: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-rw-character-device.err
>   exit code: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-rw-character-device.exit_code
>    valgrind: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-rw-character-device.vgdump
>    expected: /<<PKGBUILDDIR>>/tests/expected/lsfd/mkfds-rw-character-device{.err}
>  mountpoint: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-rw-character-device-mnt
> 
>          lsfd: character device with O_RDWR   ... FAILED (lsfd/mkfds-rw-character-device)
> ========= script: /<<PKGBUILDDIR>>/tests/ts/lsfd/mkfds-rw-character-device =================
> ================= OUTPUT =====================
>      1      3  rw-  CHR /dev/zero  mem:5   0     1:5    mem    char  1:5
>      2  ASSOC,MODE,TYPE,NAME,SOURCE,POS,MAJ:MIN,CHRDRV,DEVTYPE,RDEV: 0
>      3  MNTID[RUN]: 0
>      4  DEV[RUN]: 0
>      5  FINDMNT[RUN]: 0
>      6  DEV[STR]: 1
> ================= EXPECTED ===================
>      1      3  rw-  CHR /dev/zero  mem:5   0     1:5    mem    char  1:5
>      2  ASSOC,MODE,TYPE,NAME,SOURCE,POS,MAJ:MIN,CHRDRV,DEVTYPE,RDEV: 0
>      3  MNTID[RUN]: 0
>      4  DEV[RUN]: 0
>      5  FINDMNT[RUN]: 0
>      6  DEV[STR]: 0
> ================= O/E diff ===================
> --- /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-rw-character-device        2022-01-31 19:12:44.358597427 +0000
> +++ /<<PKGBUILDDIR>>/tests/expected/lsfd/mkfds-rw-character-device      2022-01-31 14:57:47.000000000 +0000
> @@ -3,4 +3,4 @@
>  MNTID[RUN]: 0
>  DEV[RUN]: 0
>  FINDMNT[RUN]: 0
> -DEV[STR]: 1
> +DEV[STR]: 0
> ==============================================
> 
> ---snip---
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

