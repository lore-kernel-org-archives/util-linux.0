Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:33577 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752374AbbLDHcf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 4 Dec 2015 02:32:35 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1a4kqq-0002kg-6W
	for util-linux@vger.kernel.org; Fri, 04 Dec 2015 08:32:20 +0100
Received: from ip4d14b373.dynamic.kabel-deutschland.de ([77.20.179.115])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Fri, 04 Dec 2015 08:32:20 +0100
Received: from for-gmane by ip4d14b373.dynamic.kabel-deutschland.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Fri, 04 Dec 2015 08:32:20 +0100
To: util-linux@vger.kernel.org
From: "U.Mutlu" <for-gmane@mutluit.com>
Subject: Re: mount-user.c
Date: Fri, 4 Dec 2015 08:32:08 +0100
Message-ID: <n3rfho$noi$1@ger.gmane.org>
References: <n2ibqp$ui6$1@ger.gmane.org> <564CC253.2080301@gmail.com>
 <n2j6ii$h1r$1@ger.gmane.org> <5660A0AC.40501@intellitree.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
In-Reply-To: <5660A0AC.40501@intellitree.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Michael Conrad wrote on 12/03/2015 09:06 PM:
> Your script is vulnerable to PATH changes.  Also be aware of LD_LIBRARY_PATH
> attacks.  If you write a custom c program it should probably call the mount
> syscall directly.
>
> But, you seem to forget the *most* dangerous mount abilities, which are device
> nodes and set-uid binaries.  Consider forcing nodev, noexec, and nosuid.
>
> Also the "--move" and "--remount" options aren't safe.
>
> And these are just the problems I know about...
>
> -Mike

Thanks Mike for these useful info.

As Karel here posted, mount has also 'non-superuser mounts' (cf. man mount).
I think this one is safer than my wrapper method, I hope at least :-)

-- 
U.Mutlu


