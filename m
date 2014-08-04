Return-Path: util-linux-owner@vger.kernel.org
Received: from mondschein.lichtvoll.de ([194.150.191.11]:60885 "EHLO
	mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbaHDLyk (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 4 Aug 2014 07:54:40 -0400
From: Martin Steigerwald <Martin@lichtvoll.de>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: undefined reference to symbol 'blkid_probe_lookup_value@@BLKID_2.15'
Date: Mon, 04 Aug 2014 13:54:38 +0200
Message-ID: <2551498.IAKeh1iGDI@merkaba>
In-Reply-To: <1406200041.6182.145163581.650F0C1A@webmail.messagingengine.com>
References: <1406200041.6182.145163581.650F0C1A@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Am Donnerstag, 24. Juli 2014, 13:07:21 schrieb Benno Schulenberg:
> Compiling current git, I get this:
> 
> [...]
>   CC       sys-utils/swapoff-swapoff.o
>   CC       sys-utils/swapoff-swapon-common.o
>   CCLD     swapoff
> /usr/bin/ld: sys-utils/swapoff-swapon-common.o: undefined reference to
> symbol 'blkid_probe_lookup_value@@BLKID_2.15'
> /home/ben/ULIX/.libs/libblkid.so.1: error adding symbols: DSO missing from
> command line collect2: error: ld returned 1 exit status
> make[2]: *** [swapoff] Fout 1
> make[2]: Map '/home/ben/ULIX' wordt verlaten
> make[1]: *** [all-recursive] Fout 1
> make[1]: Map '/home/ben/ULIX' wordt verlaten
> make: *** [all] Fout 2
> 
> Do I have stale stuff again somewhere?

Work-around is to configure with --disable-libblkid

-- 
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7
