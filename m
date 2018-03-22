Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753053AbeCVKY6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 22 Mar 2018 06:24:58 -0400
Date: Thu, 22 Mar 2018 11:24:55 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.32
Message-ID: <20180322102455.wqowcj4iphqstgya@ws.net.home>
References: <20180321145323.l6ulgds4zfycfttp@ws.net.home>
 <201803221047.14002.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201803221047.14002.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Mar 22, 2018 at 10:47:13AM +0100, Ruediger Meier wrote:
> FYI regarding "Release Notes". I guess it's always a pain to write

 yes ;-)

> that and to remember all relevant new features and options. ;)
> Just to remind you, we have have a nice tool on board which may be
> helpful.
> 
> $ CU_DUMP=1 make checkusage
> $ mv /tmp/checkusage--help /tmp/checkusage--help-2.32
> 
> ## ... and diff all changed --help output too see what may be
> ## worth to mention, for example:
> $ diff -uw  /tmp/checkusage--help-2.31.2 /tmp/checkusage--help-2.32

Cool. Added to my release check list. Thanks.

And thanks for contribution to util-linux!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
