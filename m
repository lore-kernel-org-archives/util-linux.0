Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:37431 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971AbbKQFZ5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 17 Nov 2015 00:25:57 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1ZyYmB-0005dj-70
	for util-linux@vger.kernel.org; Tue, 17 Nov 2015 06:25:55 +0100
Received: from ip4d14b390.dynamic.kabel-deutschland.de ([77.20.179.144])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Tue, 17 Nov 2015 06:25:55 +0100
Received: from for-gmane by ip4d14b390.dynamic.kabel-deutschland.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Tue, 17 Nov 2015 06:25:55 +0100
To: util-linux@vger.kernel.org
From: "U.Mutlu" <for-gmane@mutluit.com>
Subject: Re: user namespaces: user mapping
Date: Tue, 17 Nov 2015 06:25:42 +0100
Message-ID: <n2edon$mfu$1@ger.gmane.org>
References: <n2besp$j56$1@ger.gmane.org> <20151116041931.GC5949@vapier.lan>
 <n2ctjg$1d0$1@ger.gmane.org> <n2dpk4$p47$1@ger.gmane.org>
 <20151117043229.GH31395@vapier.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
In-Reply-To: <20151117043229.GH31395@vapier.lan>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Mike Frysinger wrote on 11/17/2015 05:32 AM:
> On 17 Nov 2015 00:41, U.Mutlu wrote:
>> I did some research on the net, and the findings are:
>>    - user namespaces have their own security holes
>
> there are no known security issues.  like all new code, there were some edge
> cases in the original implementation, but they've been fixed since.  the only
> thing left is that people don't like the new attack surface and inherently
> distrust it.  but that's not the same thing as there being known security holes.

see below

>>    - a workaround exists, but then a new problem happens: loop devices cannot
>> be accessed
>
> loop devices are merely files which are owned by the root user.  not being able
> to open files owned by the "real" root is to be expected.
>
>> Does the user need to create his own loop device(s)?
>
> you need to have the system/root chown them as the user before doing anything
> else.  sucks, but that's currently how it works.

Come on, what about the other users and the system itself, as they need them 
too...

>  would be nice if someone
> looked into making it more accessible to users.  maybe others on this list are
> aware of ongoing work.
>
>> Hmm. it looks like there is (currently?) a big mess with user namespaces:
>> https://code.google.com/p/chromium/issues/detail?id=457362
>
> no, no there is not

This is an excerpt from a recent posting (Oct-17) in the containers newsgroup 
you posted the link here ( 
http://lists.linuxfoundation.org/pipermail/containers/2015-October/036333.html 
), cite:

|>>> Linux 3.8 saw the introduction of unpriviledged user namespaces,
|>>> allowing unpriviledged users (without CAP_SYS_ADMIN) to be a "fake" root
|>>> inside a separate user namespace. Before that, any namespace creation
|>>> required CAP_SYS_ADMIN (or, in practice, the user had to be root).
|>>> Unfortunately, there have been some security-relevant bugs in the
|>>> meantime. Because of the fairly complex nature of user namespaces, it is
|>>> reasonable to say that future vulnerabilties can not be excluded. Some
|>>> distributions even wholly disable user namespaces because of this.

user namespaces is not mature yet.


