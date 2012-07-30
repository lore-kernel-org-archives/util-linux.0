Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53875 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754263Ab2G3Qh1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 30 Jul 2012 12:37:27 -0400
Date: Mon, 30 Jul 2012 18:37:20 +0200
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: kerolasa@gmail.com, util-linux@vger.kernel.org
Subject: Re: v2.22-rc2 wish list
Message-ID: <20120730163720.GM5845@x2.net.home>
References: <20120727081033.GA14019@x2.net.home>
 <CAG27Bk1mk08N=0Zbo-Bbd_v93C6cfEcO1chYyiDAtRf1sQOEpw@mail.gmail.com>
 <20120727103132.GA28708@x2.net.home>
 <501271D2.8090708@bernhard-voelker.de>
 <20120727111550.GA29738@x2.net.home>
 <50127F34.70406@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50127F34.70406@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jul 27, 2012 at 01:44:52PM +0200, Bernhard Voelker wrote:
> Building as root is certainly not okay, but prior to packaging UL into a
> distro or applying it on a few servers, I expect every admin and
> distro maintainer to run 'make check'.

I have added tests/run.sh to 'make check' for non-root users. It should
be enough for smart people who do not rebuild their packages as root.

If you want to run all utils-linux tests then you have to

    cd tests && ./run.sh

*manually* as root user.

> With a proper test suite, we give him/her a basic test to check whether
> the software is running as expected in his/her environment. Otherwise,
> he doesn't have much chance other than waiting for productive problems.

I have no problem to enable all the tests by default for all users,
but we need to *review and make robust* the scripts where is
ts_skip_nonroot.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
