Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59964 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S942792AbcJSOlt (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
        Wed, 19 Oct 2016 10:41:49 -0400
Date: Wed, 19 Oct 2016 11:53:51 +0200
From: Karel Zak <kzak@redhat.com>
To: Bruce Dubbs <bruce.dubbs@gmail.com>
Cc: Jakob Unterwurzacher <jakobunt@gmail.com>,
        util-linux-ng@vger.kernel.org
Subject: Re: more(1) may attempt to tcsetattr(3) despite lacking controlling
 terminal
Message-ID: <20161019095351.a2oejkozd23bvwes@ws.net.home>
References: <20161013143932.GA29451@netmeister.org>
 <57FFDCFA.4070407@gmail.com>
 <56b4e9fb-a01d-3578-b739-66b7b933a8c5@gmail.com>
 <57FFF411.10800@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57FFF411.10800@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Oct 13, 2016 at 03:52:33PM -0500, Bruce Dubbs wrote:
> Jakob Unterwurzacher wrote:
> > On 13.10.2016 21:14, Bruce Dubbs wrote:
> > > > 
> > > > The following example illustrates the issue:
> > > > 
> > > > $ /bin/sh -c "timeout 60 /bin/sh -c \"ls | more\""
> > > > 
> > > > This command will now hang until the timeout, since the shell, ls(1) and
> > > > more(1) commands invoked by timeout(1) will be suspended.

I'm not able to reproduce this problem too.

> > > It does not hang for me, but then I don't use systemd.  Perhaps systemd should
> > > be fixed.

I have systemd.

> > Does not hang for me either on Fedora 24, and I am using systemd, but how is
> > this related to the init system
> 
> If systemd was only an init system, I wouldn't object.  It has subsumed much
> more than initialization, e.g udev, dhcp client, managing cgroups, 'seat
> management', etc.  My initial reaction to the original problem is that it is
> cgroups related.

Probably no, the question is where is the problem.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
