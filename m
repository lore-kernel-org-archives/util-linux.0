Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69739C4332F
	for <util-linux@archiver.kernel.org>; Sat, 11 Nov 2023 18:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjKKSXT convert rfc822-to-8bit (ORCPT
        <rfc822;util-linux@archiver.kernel.org>);
        Sat, 11 Nov 2023 13:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKKSXS (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 11 Nov 2023 13:23:18 -0500
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6A7385C
        for <util-linux@vger.kernel.org>; Sat, 11 Nov 2023 10:23:15 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          for util-linux@vger.kernel.org with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1r1sdV-002q4D-71; Sat, 11 Nov 2023 19:23:13 +0100
Received: from dynamic-078-055-085-160.78.55.pool.telefonica.de ([78.55.85.160] helo=[192.168.1.11])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          for util-linux@vger.kernel.org with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1r1sdU-0019Xf-Vr; Sat, 11 Nov 2023 19:23:13 +0100
Message-ID: <2eedea423b789396d263ff4aef05736ea48d4f46.camel@physik.fu-berlin.de>
Subject: RFH: fincore/count lsfd/column-xmode failing on sparc64
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     util-linux@vger.kernel.org
Date:   Sat, 11 Nov 2023 19:23:12 +0100
Autocrypt: addr=glaubitz@physik.fu-berlin.de; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.50.1 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 78.55.85.160
X-ZEDAT-Hint: PO
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello!

On sparc64 running Linux 6.5.0, the following two tests are failing:

  2 tests of 283 FAILED

      fincore/count
      lsfd/column-xmode

The details are:

--- /dev/null   2023-11-08 19:15:02.955999947 +0000
+++ /home/glaubitz/util-linux/tests/output/fincore/count.err    2023-11-11 18:19:47.242570274 +0000
@@ -0,0 +1,4 @@
+[ NO EXCITING FILE ]
+fincore: failed to open: no_such_file: No such file or directory
+[ MULTIPLE FILES ]
+fincore: failed to open: no_such_file: No such file or directory
}}}-diff

      fincore: count file contents in core                   ... FAILED (fincore/count)
     libmount: options string: [11] set-empty                ... OK
     libfdisk: GPT: [02] all-defaults-with-typo              ... OK
          cal: Year 2147483646: [22] 1sw-year                ... OK
        fdisk: MBR - sort                                    ... OK (all 4 sub-tests PASSED)
          cal: September 1752: [21] 3sj-month                ... OK
        fdisk: sunlabel tests: [03] set-partition-sysid      ... OK
     libmount: utils: [10] ends-with                         ... OK
         lsfd: XMODE.m for classical system calls for multiplexing: [02] select ... OK
        lscpu: lscpu: [03] ppc-qemu                          ... OK
         lsfd: NAME and KNAME column                         ... OK (all 4 sub-tests PASSED)
         lsfd: TYPE and STTYPE column                        ... OK (all 4 sub-tests PASSED)
      findmnt: filter                                        ... OK (all 11 sub-tests PASSED)
        fdisk: MBR - dos mode: [03] set-partition-type       ... OK
     libmount: tab files: [10] find-target                   ... OK
         lsfd: timerfd associating alarm                     ... SKIPPED (no capability: WAKE_ALARM)
      hexdump: highlighting: [17] 2b_dec-3                   ... OK
       getopt: options: [14] quiet_option_short              ... OK
       column: table: [18] empty-column-at-eol2              ... OK
     libmount: options string: [12] set-new                  ... OK
 libsmartcols: fromfile: [10] padding-minout                 ... OK
     libmount: options string: [12] get-flg-linux            ... OK

diff-{{{
--- /home/glaubitz/util-linux/tests/expected/lsfd/column-xmode-MODE-x-bit       2023-11-11 18:12:22.478579711 +0000
+++ /home/glaubitz/util-linux/tests/output/lsfd/column-xmode-MODE-x-bit 2023-11-11 18:19:47.434570270 +0000
@@ -1,2 +1,3 @@
 r-x
+rwx
 MODE(x-bit):  0
}}}-diff

         lsfd: TCP sockets                                   ... OK
         lsfd: TCP6 sockets                                  ... OK
          cal: September 1752: [22] 1m-year                  ... OK
        lsblk: lsblk: [04] simple-lvm-state                  ... OK
       logger: errors: [07] tcp                              ... OK
          cal: Year 2147483646: [23] 1mjw-year               ... OK
     libmount: utils: [11] mountpoint                        ... OK
     libfdisk: GPT: [03] getattr                             ... OK
         lsfd: MODE and XMODE columns: [05] MODE-x-bit       ... FAILED (lsfd/column-xmode-MODE-x-bit)
      hexdump: highlighting: [18] 2b_dec-4                   ... OK
         lsfd: UNIX sockets made in a differenct net namespace ... SKIPPED (no root permissions)
     libmount: tab files: [11] find-target2                  ... OK
         lsfd: --pid option                                  ... SKIPPED (no root permissions)
     libmount: options string: [13] set-new-empty            ... OK
     libmount: options string: [13] get-flg-user             ... OK
          cal: September 1752: [23] 1s-year                  ... OK
        blkid: superblocks probing: [07] bcachefs            ... OK
       getopt: options: [15] quiet_output_option_long        ... OK
     libfdisk: mkpart-full: [04] mbr-err-nospace             ... OK
 libsmartcols: fromfile: [11] strictwidth                    ... OK
       column: table: [19] neg-1                             ... OK
     libmount: utils: [12] mountpoint-subdir                 ... OK
         lsfd: XMODE.m for classical system calls for multiplexing: [03] poll ... OK
      hexdump: highlighting: [19] 2b_dec-5                   ... OK
     libmount: options string                                ... OK (all 13 sub-tests PASSED)
          cal: Year 2147483646: [24] 1sjw-year               ... OK
       cramfs: fsck bad header: [05] pad-64K-be              ... OK
     libmount: tab files: [12] find-target3                  ... OK
          cal: September 1752: [24] 1mj-year                 ... OK
         lsfd: --summary option                              ... SKIPPED (missing in PATH: ps)
     libmount: options string: [14] set-new-end              ... OK
       logger: errors: [08] multi-line                       ... OK
     libmount: utils: [13] mountpoint-root                   ... OK
        lsblk: lsblk: [05] simple-lvm-topo                   ... OK
          cal: Year 2147483646                               ... OK (all 24 sub-tests PASSED)

diff-{{{
--- /home/glaubitz/util-linux/tests/expected/lsfd/column-xmode-XMODE-x-bit      2023-11-11 18:12:22.478579711 +0000
+++ /home/glaubitz/util-linux/tests/output/lsfd/column-xmode-XMODE-x-bit        2023-11-11 18:19:47.826570261 +0000
@@ -1,2 +1,3 @@
 r-x---
+rwx---
 XMODE(x-bit):  0
}}}-diff

Does anyone have a clue how to address these issues? I'm not quite sure what these
tests actually test.

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
