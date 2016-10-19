Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40600 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S943361AbcJSO4t (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
        Wed, 19 Oct 2016 10:56:49 -0400
Date: Wed, 19 Oct 2016 12:09:52 +0200
From: Karel Zak <kzak@redhat.com>
To: Jan Schaumann <jschauma@netmeister.org>
Cc: util-linux-ng@vger.kernel.org, Sami Kerola <kerolasa@iki.fi>
Subject: Re: more(1) may attempt to tcsetattr(3) despite lacking controlling
 terminal
Message-ID: <20161019100952.cd3a3qt6xni26xcv@ws.net.home>
References: <20161013143932.GA29451@netmeister.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161013143932.GA29451@netmeister.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Oct 13, 2016 at 10:39:32AM -0400, Jan Schaumann wrote:
> more(1) may attempt to call tsetattr(3) on stderr even if its process is
> not in a process group with a controlling terminal.  As a result,
> SIGTTOU will be generated, suspending the process.

Frankly, all the code:

      tcgetattr(fileno(stderr), &otty);
      savetty0 = otty;          
      slow_tty = cfgetispeed(&otty) < B1200;
      hardtabs = (otty.c_oflag & TABDLY) != XTABS;

seems strange, it does not care if the tcgetattr() has been successful
on stderr, etc.

     ls | more 2> /dev/null

behaves differently than without stderr redirection.

All the code is pretty mess (e.g. slow_tty is nowhere used, etc.).
Sami has tried to cleanup the code, but not sure about status of this
project (https://github.com/kerolasa/lelux-utiliteetit/commits/more3).

    Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
