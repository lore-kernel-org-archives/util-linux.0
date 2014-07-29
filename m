Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:19984 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752740AbaG2KTY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 29 Jul 2014 06:19:24 -0400
Date: Tue, 29 Jul 2014 12:19:16 +0200
From: Karel Zak <kzak@redhat.com>
To: Andreas Henriksson <andreas@fatal.se>
Cc: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH] tests: allow non-inotify tailf to keep up
Message-ID: <20140729101916.GT8533@x2.net.home>
References: <1406407441-4872-1-git-send-email-andreas@fatal.se>
 <53D4F231.9020906@draigBrady.com>
 <20140728115923.GK8533@x2.net.home>
 <20140728122115.GA17573@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20140728122115.GA17573@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 28, 2014 at 02:21:15PM +0200, Andreas Henriksson wrote:
> Hello!
> 
> On Mon, Jul 28, 2014 at 01:59:23PM +0200, Karel Zak wrote:
> > On Sun, Jul 27, 2014 at 01:36:01PM +0100, Pádraig Brady wrote:
> > > For such tests coreutils uses a helper function
> > > to apply a truncated exponential backoff,
> > > to run quickly in the common case, but also
> > > delay longer if necessary. See retry_delay_() at:
> 
> Thanks for the pointer!
> 
> > > 
> > > http://git.sv.gnu.org/gitweb/?p=coreutils.git;a=blob;f=init.cfg;h=725ee121;hb=HEAD#l608
> > 
> >  Andreas? (hint: send a new patch :-))
> 
> I fail to see how this is useful here. We either need a short delay (using
> inotify) or a longer delay (not using inotify). All other steps seems
> pointless to me, even harmful in non-inotify case!

 OK, merged. Maybe someone will provide a better solution later.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
