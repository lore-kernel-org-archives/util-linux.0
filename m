Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42560 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750898AbcKGJlE (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 7 Nov 2016 04:41:04 -0500
Date: Mon, 7 Nov 2016 10:41:01 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Bernhard Voelker <mail@bernhard-voelker.de>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH 3/3] tests: always quote $LODEV
Message-ID: <20161107094101.jit57km4ymbdumy6@ws.net.home>
References: <1478358489-18103-1-git-send-email-sweet_f_a@gmx.de>
 <1478358489-18103-3-git-send-email-sweet_f_a@gmx.de>
 <6d62a61c-6dcf-e7a5-bfa3-5df4f93723a4@bernhard-voelker.de>
 <201611070958.25232.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201611070958.25232.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 07, 2016 at 09:58:25AM +0100, Ruediger Meier wrote:
> On Sunday 06 November 2016, Bernhard Voelker wrote:
> > So what happens now when losetup is fed with ""?
> > Wouldn't it be better to handle the error instead?
> 
> Actually the failure is generally handled in terms that the test will 
> fail and exit 1. 

This is the basic idea of the tests; it would be nice to keep it
simple and stupid :-)

> the whole --help output on usage errors. I really hate that auto-help 
> feature. Don't understand why we are doing that instead of just 
> printing "unkown option" or "missing argument".

I'd like to change it for v2.30.

Optionally, it would be also nice to have a way how to suggest the
correct option on typos. I like the way how git react on typos:

        $ git cxmmit
        git: 'cxmmit' is not a git command. See 'git --help'.

        Did you mean this?
            commit



    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
