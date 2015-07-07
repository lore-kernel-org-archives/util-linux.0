Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ob0-f169.google.com ([209.85.214.169]:35083 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757779AbbGGO4v (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 7 Jul 2015 10:56:51 -0400
Received: by obbop1 with SMTP id op1so130291608obb.2
        for <util-linux@vger.kernel.org>; Tue, 07 Jul 2015 07:56:51 -0700 (PDT)
Received: from [192.168.0.75] (cpe-70-123-244-133.satx.res.rr.com. [70.123.244.133])
        by mx.google.com with ESMTPSA id y23sm7559245oie.13.2015.07.07.07.56.49
        for <util-linux@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2015 07:56:50 -0700 (PDT)
Message-ID: <559BE8B0.3020403@gmail.com>
Date: Tue, 07 Jul 2015 09:56:48 -0500
From: Bruce Dubbs <bruce.dubbs@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: [PATCH] agetty: Reprompt once the network addresses
 change if address displayed
References: <1435928288-25644-1-git-send-email-stefw@redhat.com> <20150706140711.GF17734@vapier> <559ACFC3.6050303@gmail.com> <20150707042512.GI17734@vapier> <559B5E22.2050902@gmail.com> <20150707070716.GJ17734@vapier>
In-Reply-To: <20150707070716.GJ17734@vapier>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Mike Frysinger wrote:

> the whole point of libmnl is to provide a clean userspace library API that is
> completely standalone & minimal (it's in the name) so people don't have to
> learn the low level netlink APIs nor have to include linux/ headers directly
> (which often lead to clashes with the C libraries).  libmnl itself is <20KiB,
> so i don't buy the bloat argument.
>
> even then, if we do use libmnl in util-linux, it'd have configure checks so that
> if the system doesn't have it, it'd be disabled automatically.  i'm surprised
> you're complaining about libmnl but not the other large external libs that
> util-linux utilizes.
>
> another point of information: the latest iproute2 now requires libmnl, so that
> ship has already sailed.

Yes, you're right.  We do disable tipc in iproute2 for the same reason 
as we are discussing here.  That's not a function that many of our users 
would need.  If libmnl is added to util-linux, then we'll deal with it.

   -- Bruce


