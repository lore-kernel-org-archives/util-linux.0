Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:46601 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752832AbbKOCKy (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 14 Nov 2015 21:10:54 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1ZxmmH-0003cF-5D
	for util-linux@vger.kernel.org; Sun, 15 Nov 2015 03:10:49 +0100
Received: from ip4d14b390.dynamic.kabel-deutschland.de ([77.20.179.144])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Sun, 15 Nov 2015 03:10:49 +0100
Received: from for-gmane by ip4d14b390.dynamic.kabel-deutschland.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Sun, 15 Nov 2015 03:10:49 +0100
To: util-linux@vger.kernel.org
From: "U.Mutlu" <for-gmane@mutluit.com>
Subject: Re: unshare -m for non-root user
Date: Sun, 15 Nov 2015 03:10:36 +0100
Message-ID: <n28pis$6uv$1@ger.gmane.org>
References: <n0ujgc$tll$1@ger.gmane.org> <20151030102247.GF19508@ws.net.home>
 <n2674p$ulm$1@ger.gmane.org> <87si49p771.fsf@x220.int.ebiederm.org>
 <n26nkm$13l$1@ger.gmane.org> <20151114181716.GA3839@newbook>
 <n287q4$efd$1@ger.gmane.org> <n28krj$8i0$1@ger.gmane.org>
 <20151115012418.GC31395@vapier.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
In-Reply-To: <20151115012418.GC31395@vapier.lan>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Mike Frysinger wrote on 11/15/2015 02:24 AM:
> On 15 Nov 2015 01:49, U.Mutlu wrote:
>> So, then the question remains: how to give non-root user a secure mount
>
> no, it doesn't.  at least two people have already told you how to do it:
> use the usernamespace (-U) option that unshare already supports.

It's not yet clear for me how to use that. Can you give an example?
unshare -U /bin/bash
?


