Return-Path: util-linux-owner@vger.kernel.org
Received: from mondschein.lichtvoll.de ([194.150.191.11]:53725 "EHLO
	mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204AbaJ1I4s convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 28 Oct 2014 04:56:48 -0400
Received: from merkaba.localnet (blackhole.teamix.net [194.150.191.251])
	by mail.lichtvoll.de (Postfix) with ESMTPSA id 87E10421
	for <util-linux@vger.kernel.org>; Tue, 28 Oct 2014 09:48:29 +0100 (CET)
From: Martin Steigerwald <Martin@lichtvoll.de>
To: util-linux@vger.kernel.org
Subject: Re: fdisk and 2048 sectors obsession.
Date: Tue, 28 Oct 2014 09:48:29 +0100
Message-ID: <2888990.X84BcKRn2u@merkaba>
In-Reply-To: <544F4A6C.808@earthlink.net>
References: <544E923E.6050406@gmail.com> <20141028073208.GH10134@x2.net.home> <544F4A6C.808@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Am Dienstag, 28. Oktober 2014, 03:49:00 schrieb Felix Miata:
> Karel Zak composed on 2014-10-28 08:32 (UTC+0100):
> >> The man page does fail to explain what dos mode actually means.
> >> 
> >  - start at sector 63
> >  - care about CHS in partition table
> >  - extra checks for alignment to be compatible with CHS addressing
> 
> Why isn't that in the man page? People trying to use a program aren't always
> able to Google an explanation of its man page minimalism.

You are free to contribute…

-- 
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7
