Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:51717 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752080AbaL2MuH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 29 Dec 2014 07:50:07 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1Y5Zlq-00074i-Sq
	for util-linux@vger.kernel.org; Mon, 29 Dec 2014 13:50:02 +0100
Received: from p4fd79918.dip0.t-ipconnect.de ([79.215.153.24])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Mon, 29 Dec 2014 13:50:02 +0100
Received: from j-p-t by p4fd79918.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Mon, 29 Dec 2014 13:50:02 +0100
To: util-linux@vger.kernel.org
From: JPT <j-p-t@gmx.net>
Subject: [BUG] Mount: codepage mapping does not work for msdos fs
Date: Mon, 29 Dec 2014 13:48:23 +0100
Message-ID: <m7riin$iuv$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

I want to mount a DOS 5.0 partition without messing it up with LFNs.

According to man page this only works if I use the MSDOS fs instead of VFAT.

But using MSDOS fails on converting non ASCII chars.

If I mount using VFAT:
mount -t vfat -o check=strict,codepage=850,iocharset=iso8859-1,utf8
everything is fine:
ÄÄÄÄÄÄÄÄÄÄ AßLAR ÄÜÖßÄÜÖ istdaskürzer nochlänger
ABC ÄÜÖÄÜÖ äüößÄÜÖ2 longfilename öööööööööö

If I mount using MSDOS:
mount -t msdos -o check=strict,codepage=850
the chars aren't translated at all:
ls shows garbage:
?????? ????? ??????~1 ??????~1 ?????2 abc a?lar istdas~1 longfi~1 nochl?~1

if piped through less, you can see it delivers cp850 codes:

<8E><9A><99><8E><9A><99>
<8E><9A><99><U+139A><99>
<99><99><99><99><99><99>~1
<8E><8E><8E><8E><8E><8E>~1
<8E><9A><99><U+139A><99>2
abc
a<E1>lar
istdas~1
longfi~1
nochl<8E>~1

write access creates UTF8 codes on the disk (I believe, not verified)

Could you please have a look into it?

Linux TUX 3.16.0-28-generic #38-Ubuntu SMP Fri Dec 12 17:37:40 UTC 2014
x86_64
mount from util-linux 2.25.1 (libmount 2.25.0: selinux, assert, debug)

thanks

Jan

