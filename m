Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57490 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752758Ab2IEIpD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 5 Sep 2012 04:45:03 -0400
Date: Wed, 5 Sep 2012 10:44:57 +0200
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: util-linux <util-linux@vger.kernel.org>,
        Ludwig Nussel <ludwig.nussel@suse.de>
Subject: Re: runuser(1) and su(1) -g/-G
Message-ID: <20120905084457.GA32623@x2.net.home>
References: <20120904151843.GA6389@x2.net.home>
 <50465BEE.7070005@draigBrady.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <50465BEE.7070005@draigBrady.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Sep 04, 2012 at 08:52:14PM +0100, Pádraig Brady wrote:
> Thanks for doing all that Karel.
> I've not time to look now,
> but will note that many were looking for
> a lightweight option that didn't need PAM.

I know, it should be the second step.

> Perhaps PAM support could be easily compiled out?

Not yet. The patch will be pretty simple, all we need is to add
something like #ifdef BUILD_LIGHTWEIGHT_RUNUSER to
create_watching_parent() and authenticate(). 

Volunteers? (I'm going to spend this week with coverity scanner...)


Note that we will support PAM-only su(1), maintain alternative
authentication code in utils like su(1), login(1), ... is nonsense.

If you don't like modular PAM then you can rebuild libpam with
statically linked modules (result is still shared library, but without
dlopen()).

The command runuser(1) is different as there is no authentication at
all -- it's just wrapper around setuid/gid, and it uses PAM for
session setup only.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
