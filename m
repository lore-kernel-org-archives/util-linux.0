Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qw0-f53.google.com ([209.85.216.53]:65147 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000Ab1KVKFF convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Nov 2011 05:05:05 -0500
Received: by qadb14 with SMTP id b14so10836qad.19
        for <util-linux@vger.kernel.org>; Tue, 22 Nov 2011 02:05:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAMtsiiDrWGKthY52+HT5r19g9EFRG2NHKMD3vni-SeaMNfuGDg@mail.gmail.com>
References: <CAMtsiiDWF3xCiFtENTaYS36zKOJjRHML0x2nk1P0d0zeU3qi0A@mail.gmail.com>
	<1321913175.3253.8.camel@offbook>
	<CAMtsiiDrWGKthY52+HT5r19g9EFRG2NHKMD3vni-SeaMNfuGDg@mail.gmail.com>
Date: Tue, 22 Nov 2011 11:05:04 +0100
Message-ID: <CAMtsiiDNPk4+m7JoWRp0JQWdL229OMCMYjZZsg-E2Ej0Rkv4OA@mail.gmail.com>
Subject: Re: mkfs.minix V3 is broken
From: Maurizio Lombardi <m.lombardi85@gmail.com>
To: dave@gnu.org
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

>    if (BLOCKS > MINIX_MAX_INODES)
>       BLOCKS = MINIX_MAX_INODES;

Please note that this piece of code is horrible too, comparing the
number of blocks to the max number of inodes is like comparing apples
and oranges, no? :)

In general I think that the mkfs.minix is full of weird things and
needs a serious cleanup.

Regards,
-- 
--------------------
Maurizio Lombardi
