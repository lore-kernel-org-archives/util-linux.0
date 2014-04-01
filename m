Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vc0-f182.google.com ([209.85.220.182]:65503 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037AbaDAMDw (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 1 Apr 2014 08:03:52 -0400
Received: by mail-vc0-f182.google.com with SMTP id ks9so9774337vcb.13
        for <util-linux@vger.kernel.org>; Tue, 01 Apr 2014 05:03:51 -0700 (PDT)
MIME-Version: 1.0
From: Paul Barker <paul@paulbarker.me.uk>
Date: Tue, 1 Apr 2014 13:03:10 +0100
Message-ID: <CANyK_8d6L7vL6Mfq4VNdScjoVLb1K1+8hYsDnuQBZLOh5LC3BA@mail.gmail.com>
Subject: Compile failure due to use of qsort_r
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi all,

I'm using util-linux as part of the OpenEmbedded build system and
we've ran into two places where the use of qsort_r in util-linux is
causing a compile failure:

- CentOS 5.10 is using an old version of glibc which doesn't provide qsort_r

- We're experimenting with musl-libc and this also doesn't provide qsort_r

qsort_r is only used in one place in libfdisk/src/sun.c to my knowledge.

Personally I think a good solution would be to add a configure check
on whether qsort_r is provided and to either error out at that stage
or provide a workaround.

I'm pretty starved for time myself so sadly all I can do is report the failure.

Thanks,

-- 
Paul Barker

Email: paul@paulbarker.me.uk
http://www.paulbarker.me.uk
