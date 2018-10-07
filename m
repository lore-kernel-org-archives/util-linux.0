Return-Path: <SRS0=nETV=MT=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAE2C65C1B
	for <util-linux@archiver.kernel.org>; Sun,  7 Oct 2018 16:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819BD20834
	for <util-linux@archiver.kernel.org>; Sun,  7 Oct 2018 16:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819BD20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tlinx.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbeJHAGl (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 7 Oct 2018 20:06:41 -0400
Received: from ishtar.tlinx.org ([173.164.175.65]:39480 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbeJHAGl (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 7 Oct 2018 20:06:41 -0400
Received: from [192.168.3.12] (Athenae [192.168.3.12])
        by Ishtar.sc.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id w97GwZ97084156;
        Sun, 7 Oct 2018 09:58:38 -0700
Message-ID: <5BBA3B3C.9030601@tlinx.org>
Date:   Sun, 07 Oct 2018 09:58:36 -0700
From:   L A Walsh <lkml@tlinx.org>
User-Agent: Thunderbird
MIME-Version: 1.0
To:     Bernhard Voelker <mail@bernhard-voelker.de>
CC:     Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.33-rc1
References: <20180925104701.y2gwtwe2bquynap2@ws.net.home> <5BB15D3A.8040507@tlinx.org> <20181002101454.qm5gzasb5naamnbg@ws.net.home> <5BB90C30.1080005@tlinx.org> <a8f5fac6-b7a3-ee92-3f5b-b6459cdc3b5f@bernhard-voelker.de>
In-Reply-To: <a8f5fac6-b7a3-ee92-3f5b-b6459cdc3b5f@bernhard-voelker.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 10/7/2018 7:57 AM, Bernhard Voelker wrote:
>
> $ zypper install glibc-devel-static
>   
----
Already had 2.27-4.1 installed, which I just bumped to 2.27-6.1.

Same problem, unfortunately.
*sigh*

>  make V=1 mount.static
/bin/sh ./libtool  --tag=CC   --mode=link /usr/bin/gcc  -fsigned-char 
-fno-common -Wall -Werror=sequence-point -Wextra -Wmissing-declarations 
-Wmissing-parameter-type -Wmissing-prototypes 
-Wno-missing-field-initializers -Wredundant-decls -Wsign-compare 
-Wtype-limits -Wuninitialized -Wunused-but-set-parameter 
-Wunused-but-set-variable -Wunused-parameter -Wunused-result 
-Wunused-variable -Wnested-externs -Wpointer-arith -Wstrict-prototypes 
-Wimplicit-function-declaration -Wdiscarded-qualifiers -I./libmount/src 
-fpic -march=native -pipe -O2   -all-static -fpic -march=native -pipe 
-O2 -Wl,--stats  -o mount.static sys-utils/mount_static-mount.o  
libcommon.la libmount.la   
libtool: warning: complete static linking is impossible in this 
configuration
libtool: link: /usr/bin/gcc -fsigned-char -fno-common -Wall 
-Werror=sequence-point -Wextra -Wmissing-declarations 
-Wmissing-parameter-type -Wmissing-prototypes 
-Wno-missing-field-initializers -Wredundant-decls -Wsign-compare 
-Wtype-limits -Wuninitialized -Wunused-but-set-parameter 
-Wunused-but-set-variable -Wunused-parameter -Wunused-result 
-Wunused-variable -Wnested-externs -Wpointer-arith -Wstrict-prototypes 
-Wimplicit-function-declaration -Wdiscarded-qualifiers -I./libmount/src 
-fpic -march=native -pipe -O2 -fpic -march=native -pipe -O2 -Wl,--stats 
-o mount.static sys-utils/mount_static-mount.o  ./.libs/libcommon.a 
./.libs/libmount.a 
/home/tools/util-linux/util-linux-2.33-rc1/.libs/libblkid.a 
/home/tools/util-linux/util-linux-2.33-rc1/.libs/libuuid.a -lrt
/usr/bin/ld: total time in link: 0.038702
