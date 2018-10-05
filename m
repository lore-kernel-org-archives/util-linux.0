Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51974 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727179AbeJEQfZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 5 Oct 2018 12:35:25 -0400
Date: Fri, 5 Oct 2018 11:37:27 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.33-rc1
Message-ID: <20181005093727.hiw27c7p6mksd4iu@ws.net.home>
References: <20180925104701.y2gwtwe2bquynap2@ws.net.home>
 <201810050011.14673.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201810050011.14673.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Oct 05, 2018 at 12:11:14AM +0200, Ruediger Meier wrote:
> On Tuesday 25 September 2018, Karel Zak wrote:
> > The util-linux release v2.33-rc1 is available at
> >
> >   http://www.kernel.org/pub/linux/utils/util-linux/v2.33/
> >
> > Feedback and bug reports, as always, are welcomed.
> >
> >   Karel
> 
> There is one build issue with setns() usage in libmount/src/context.c in case
> we don't have it neither in libc nor the syscall 
> 
> [...]
> checking for syscall setns... no
> configure: WARNING: Unable to detect syscall setns.
> configure: WARNING: setns syscall not found; not building nsenter
> checking for setns... no
> [...]
> ./.libs/libmount.so: undefined reference to `setns'

Oh, ... fixed now. 

Thanks for your report and all the tests!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
