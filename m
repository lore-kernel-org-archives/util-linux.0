Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33335 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbbDANim (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 1 Apr 2015 09:38:42 -0400
Received: by pacgg7 with SMTP id gg7so52634109pac.0
        for <util-linux@vger.kernel.org>; Wed, 01 Apr 2015 06:38:42 -0700 (PDT)
Received: from newbook ([50.0.225.244])
        by mx.google.com with ESMTPSA id qm6sm2230378pac.14.2015.04.01.06.38.40
        for <util-linux@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2015 06:38:41 -0700 (PDT)
Date: Wed, 1 Apr 2015 06:38:43 -0700
From: Isaac Dunham <ibid.ag@gmail.com>
To: util-linux@vger.kernel.org
Subject: Re: question about hardcoded binary paths (swapon / mkswap)
Message-ID: <20150401133842.GA1800@newbook>
References: <201504011342.56546.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201504011342.56546.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 01, 2015 at 01:42:56PM +0200, Ruediger Meier wrote:
> Hi,
> 
> I wonder about some hardcoded binary paths.
> 
> Example swapon.c:
> 
> #define PATH_MKSWAP    "/sbin/mkswap"
> 
> There are a two problems.
> 1. It's wrong. We should use $sbindir from configure.
> 2. When called from our test-suite it will use a wrong (or
>    non-existend, broken) binary. This happens in test swapon/fixpgsz.
> 
> The question is how to fix this.
> 
> I would prefer to use "mkwsap" from the same directory like swapon or to 
> simply execvp "mkswap" from PATH. But don't know if we want this. If we 
> really want to keep a hardcoded sbindir then we would need "#ifdef 
> TEST_PROGRAM".
> 
> Any comments?

The approach that seems obvious to me (assuming you want to keep the
hardcoded path) is:
-add -DSBINDIR="$sbindir" to CFLAGS
-in the testsuite, run tests in a private mount namespace, where you can
bind-mount $sbindir.

However, I'm guessing this would have to be done with a union mount, 
and there are probably problems like what to do if sbindir is 
non-existent down to / (eg, sbindir=/util-linux/rootcommmands on a 
standard Linux) -- creating a union mount over / may be a Bad Thing.

Thanks,
Isaac Dunham

