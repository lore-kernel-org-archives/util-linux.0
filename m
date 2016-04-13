Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41648 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965432AbcDMK2S (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 13 Apr 2016 06:28:18 -0400
Date: Wed, 13 Apr 2016 12:28:13 +0200
From: Karel Zak <kzak@redhat.com>
To: Robby Workman <rworkman@slackware.com>
Cc: util-linux@vger.kernel.org
Subject: Re: v2.29 plan: kill mtab
Message-ID: <20160413102813.hpmekfhelugpubt4@ws.net.home>
References: <alpine.LNX.2.02.1604071350320.22605@connie.slackware.com>
 <20160411205934.blmh2xx3bgxw4vwm@ws.net.home>
 <alpine.LNX.2.02.1604121931070.16273@connie.slackware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.02.1604121931070.16273@connie.slackware.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 12, 2016 at 07:33:08PM -0700, Robby Workman wrote:
> > This discussion is really not about init, but about mtab that is
> > broken by design.
> 
> Okay, then how about this? Our current use of /etc/mtab works well

btw, mount(8) supports /etc/mtab -> /proc/mounts symlink for 20
years...

> for us, and as far as I'm aware, we've experienced absolutely
> none of this "[breakage] by design" - as such, we'd be grealy
> appreciative if the option remains to continue using it.

We're trying to be friendly to all Linux users ...so we're going to
#ifdef mtab stuff and keep --enable-libmount-support-mtab there for
the next years to keep you happy.

Maybe one day you will enter wonderful 21 century where we have 
Linux namespaces, containers, bind mounts, mount move operation,
chroots, btrfs, NFS and another cool stuff... and then you will see
that there is a fundamental difference between "what kernel thinks
about VFS" and "how users call mount(8)".

Fair enough?
    
   Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
