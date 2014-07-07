Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:64760 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752563AbaGGMvQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 7 Jul 2014 08:51:16 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Subject: Re: fdisk -b segfaults
Date: Mon, 7 Jul 2014 14:51:14 +0200
Cc: "Util-Linux" <util-linux@vger.kernel.org>
References: <53BA8537.2090504@bernhard-voelker.de>
In-Reply-To: <53BA8537.2090504@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201407071451.14305.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Monday 07 July 2014, Bernhard Voelker wrote:
> Easy reproducer:
>
>    $ dd if=/dev/zero of=xxx bs=1M count=20
>    20+0 records in
>    20+0 records out
>    20971520 bytes (21 MB) copied, 0.0275507 s, 761 MB/s
>
>    $ ~/util-linux/fdisk -b 4096 xxx
>
>    Welcome to fdisk (util-linux 2.25-rc2).
>    Changes will remain in memory only, until you decide to write
> them. Be careful before using the write command.
>
>    Device does not contain a recognized partition table.
>    Segmentation fault
>
> I can't have a look myself right now, because UL's autogen.sh
> doesn't work here on openSUSE-13.1 anymore.

What is the problem with autogen.sh on openSUSE-13.1?

cu,
Rudi
