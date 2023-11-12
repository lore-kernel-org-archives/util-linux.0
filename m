Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CA7C4167D
	for <util-linux@archiver.kernel.org>; Sun, 12 Nov 2023 19:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjKLTEV convert rfc822-to-8bit (ORCPT
        <rfc822;util-linux@archiver.kernel.org>);
        Sun, 12 Nov 2023 14:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjKLTEV (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 12 Nov 2023 14:04:21 -0500
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B6E136
        for <util-linux@vger.kernel.org>; Sun, 12 Nov 2023 11:04:16 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1r2Fkj-002WRs-Bg; Sun, 12 Nov 2023 20:04:13 +0100
Received: from dynamic-077-183-066-182.77.183.pool.telefonica.de ([77.183.66.182] helo=[192.168.1.11])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1r2Fkj-0047MS-4u; Sun, 12 Nov 2023 20:04:13 +0100
Message-ID: <b8cafd0d89878949705782312dfe800ec2779035.camel@physik.fu-berlin.de>
Subject: Re: RFH: fincore/count lsfd/column-xmode failing on sparc64
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Masatake YAMATO <yamato@redhat.com>
Cc:     util-linux@vger.kernel.org
Date:   Sun, 12 Nov 2023 20:04:12 +0100
In-Reply-To: <20231113.025447.1424703398754597049.yamato@redhat.com>
References: <2eedea423b789396d263ff4aef05736ea48d4f46.camel@physik.fu-berlin.de>
         <20231113.025447.1424703398754597049.yamato@redhat.com>
Autocrypt: addr=glaubitz@physik.fu-berlin.de; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.50.1 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 77.183.66.182
X-ZEDAT-Hint: PO
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi Masatake!

On Mon, 2023-11-13 at 02:54 +0900, Masatake YAMATO wrote:
> Could you show the outout of "pmap $$" on the target platform?

Here you go:

glaubitz@stadler:~$ pmap $$
1490335:   -bash
0000010000000000   1248K r-x-- bash
00000100002fa000     24K r---- bash
0000010000300000     48K rwx-- bash
000001000030c000     40K rwx--   [ anon ]
0000010000316000    520K rwx--   [ anon ]
000007feffa22000    136K rw---   [ stack ]
fff8000100000000    160K r-x-- ld-linux.so.2
fff8000100028000     16K rw---   [ anon ]
fff800010002c000     32K r--s- gconv-modules.cache
fff80001001fe000      8K r---- ld-linux.so.2
fff8000100200000      8K rw--- ld-linux.so.2
fff8000100426000      8K r----   [ anon ]
fff8000100428000      8K r-x--   [ anon ]
fff8000100500000    184K r-x-- libtinfo.so.6.4
fff800010052e000   1848K ----- libtinfo.so.6.4
fff80001006fc000     16K r---- libtinfo.so.6.4
fff8000100700000      8K rwx-- libtinfo.so.6.4
fff8000100800000   1584K r-x-- libc.so.6
fff800010098c000   1472K ----- libc.so.6
fff8000100afc000     16K r---- libc.so.6
fff8000100b00000     16K rwx-- libc.so.6
fff8000100b04000     48K rwx--   [ anon ]
fff8000100b10000   2984K r---- locale-archive
fff8000100e00000     32K r-x-- libnss_compat.so.2
fff8000100e08000   2008K ----- libnss_compat.so.2
fff8000100ffe000      8K r---- libnss_compat.so.2
fff8000101000000      8K rwx-- libnss_compat.so.2
fff8000101100000     24K r-x-- libnss_db-2.2.3.so
fff8000101106000   2016K ----- libnss_db-2.2.3.so
fff80001012fe000      8K r---- libnss_db-2.2.3.so
fff8000101300000      8K rwx-- libnss_db-2.2.3.so
fff8000101400000   1624K r-x-- libdb-5.3.so
fff8000101596000   1424K ----- libdb-5.3.so
fff80001016fa000     24K r---- libdb-5.3.so
fff8000101700000     56K rwx-- libdb-5.3.so
 total            17672K
glaubitz@stadler:~$

and for zsh:

stadler% pmap $$
1490470:   zsh
0000010000000000    792K r-x-- zsh
00000100001fe000      8K r---- zsh
0000010000200000     32K rwx-- zsh
0000010000208000     80K rwx--   [ anon ]
000001000021c000    408K rwx--   [ anon ]
000007feff92a000    136K rw---   [ stack ]
fff8000100000000    160K r-x-- ld-linux.so.2
fff8000100028000     32K rw---   [ anon ]
fff8000100032000     16K rw---   [ anon ]
fff8000100038000     32K r--s- gconv-modules.cache
fff8000100066000      8K r--s- Newuser.zwc
fff8000100082000      8K r--s- Completion.zwc
fff80001001fe000      8K r---- ld-linux.so.2
fff8000100200000      8K rw--- ld-linux.so.2
fff800010032c000      8K r----   [ anon ]
fff800010032e000      8K r-x--   [ anon ]
fff8000100400000    392K r-x-- libpcre2-8.so.0.11.2
fff8000100462000   1648K ----- libpcre2-8.so.0.11.2
fff80001005fe000      8K r---- libpcre2-8.so.0.11.2
fff8000100600000      8K rwx-- libpcre2-8.so.0.11.2
fff8000100700000     56K r-x-- libgdbm.so.6.0.0
fff800010070e000   1984K ----- libgdbm.so.6.0.0
fff80001008fe000      8K r---- libgdbm.so.6.0.0
fff8000100900000      8K rwx-- libgdbm.so.6.0.0
fff8000100a00000     40K r-x-- libcap.so.2.66
fff8000100a0a000   2000K ----- libcap.so.2.66
fff8000100bfe000      8K r---- libcap.so.2.66
fff8000100c00000      8K rwx-- libcap.so.2.66
fff8000100d00000    208K r-x-- libncursesw.so.6.4
fff8000100d34000   1832K ----- libncursesw.so.6.4
fff8000100efe000      8K r---- libncursesw.so.6.4
fff8000100f00000     16K rwx-- libncursesw.so.6.4
fff8000101000000    184K r-x-- libtinfo.so.6.4
fff800010102e000   1848K ----- libtinfo.so.6.4
fff80001011fc000     16K r---- libtinfo.so.6.4
fff8000101200000      8K rwx-- libtinfo.so.6.4
fff8000101300000    736K r-x-- libm.so.6
fff80001013b8000   1304K ----- libm.so.6
fff80001014fe000      8K r---- libm.so.6
fff8000101500000      8K rwx-- libm.so.6
fff8000101600000   1584K r-x-- libc.so.6
fff800010178c000   1472K ----- libc.so.6
fff80001018fc000     16K r---- libc.so.6
fff8000101900000     16K rwx-- libc.so.6
fff8000101904000     48K rwx--   [ anon ]
fff8000101910000   2984K r---- locale-archive
fff8000101c00000     32K r-x-- libnss_compat.so.2
fff8000101c08000   2008K ----- libnss_compat.so.2
fff8000101dfe000      8K r---- libnss_compat.so.2
fff8000101e00000      8K rwx-- libnss_compat.so.2
fff8000101f00000     24K r-x-- libnss_db-2.2.3.so
fff8000101f06000   2016K ----- libnss_db-2.2.3.so
fff80001020fe000      8K r---- libnss_db-2.2.3.so
fff8000102100000      8K rwx-- libnss_db-2.2.3.so
fff8000102200000   1624K r-x-- libdb-5.3.so
fff8000102396000   1424K ----- libdb-5.3.so
fff80001024fa000     24K r---- libdb-5.3.so
fff8000102500000     56K rwx-- libdb-5.3.so
fff8000102600000      8K r-x-- terminfo.so
fff8000102602000   2032K ----- terminfo.so
fff80001027fe000      8K r---- terminfo.so
fff8000102800000      8K rwx-- terminfo.so
fff8000102900000    296K r-x-- zle.so
fff800010294a000   1744K ----- zle.so
fff8000102afe000      8K r---- zle.so
fff8000102b00000     40K rwx-- zle.so
fff8000102b0a000      8K rwx--   [ anon ]
fff8000102c00000    144K r-x-- complete.so
fff8000102c24000   1896K ----- complete.so
fff8000102dfe000      8K r---- complete.so
fff8000102e00000     16K rwx-- complete.so
fff8000102f00000     32K r-x-- zutil.so
fff8000102f08000   2008K ----- zutil.so
fff80001030fe000      8K r---- zutil.so
fff8000103100000      8K rwx-- zutil.so
fff8000103200000     16K r-x-- files.so
fff8000103204000   2024K ----- files.so
fff80001033fe000      8K r---- files.so
fff8000103400000      8K rwx-- files.so
fff8000103500000     40K r-x-- parameter.so
fff800010350a000   2000K ----- parameter.so
fff80001036fe000      8K r---- parameter.so
fff8000103700000      8K rwx-- parameter.so
 total            39832K
stadler%

> On my PC (Fedora 38 running on x86_64):
> 
>     929547:   zsh
>     000055e86f2d7000     92K r---- zsh
>     000055e86f2ee000    716K r-x-- zsh
>     000055e86f3a1000     88K r---- zsh
>     ...
> 
> The failed test case is highly depends on "r-x--" iin
> the line "000055e86f2ee000    716K r-x-- zsh".
> 
> I guess, on your environment, the field is "rwx--".

It currently looks like this for bash:

1490335:   -bash
0000010000000000   1248K r-x-- bash
00000100002fa000     24K r---- bash
0000010000300000     48K rwx-- bash

and for zsh:

1490470:   zsh
0000010000000000    792K r-x-- zsh
00000100001fe000      8K r---- zsh
0000010000200000     32K rwx-- zsh

> If, my guessing is correct, I must fix the test case.

That would be great. Thank you!

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
