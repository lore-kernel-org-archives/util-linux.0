Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46052 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753949AbdFSJ2R (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 19 Jun 2017 05:28:17 -0400
Date: Mon, 19 Jun 2017 11:28:13 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
Subject: Re: [PATCH] uuidparse: add new command
Message-ID: <20170619092813.evirrk3zy6omv6xi@ws.net.home>
References: <20170618172536.21544-1-kerolasa@iki.fi>
 <201706191122.48481.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201706191122.48481.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 19, 2017 at 11:22:48AM +0200, Ruediger Meier wrote:
> > +static void __attribute__((__noreturn__)) usage(FILE *out)
> 
> Do we really need this FILE argument? You are using only stdout in 
> uuidparse and that's good and should never change ;) I can't imagine 
> any good reason why usage should ever go to stderr and exit(1).
> 
> BTW currently I'm going through the whole project to correct all 
> commands where we spam the whole usage in case of errors.

That's legacy from time we used usage(stderr) for command line parsing
errors. Now we use errtryhelp().

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
