Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53916 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964992AbcAZKmH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 26 Jan 2016 05:42:07 -0500
Date: Tue, 26 Jan 2016 11:42:04 +0100
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Sarah Newman <srn@prgmr.com>, Tilman Schmidt <tilman@imap.cc>,
        "Wayne R. Roth" <wayneroth42@gmail.com>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] mkswap: Add warnings for insecure device
 permissions/owners
Message-ID: <20160126104204.sls4bbcxocoscbcc@ws.net.home>
References: <1453228626-18667-1-git-send-email-wayneroth42@gmail.com>
 <20160120103042.clphjleuiesjrl52@ws.net.home>
 <56A1596C.3060507@prgmr.com>
 <56A25241.8050000@imap.cc>
 <56A27F92.6020309@prgmr.com>
 <CAG27Bk1xN6RccvCKwurdftkHkvS86Mi5VnA-8UiP7Y0peuh02A@mail.gmail.com>
 <20160123162241.pwvqxyfm4qv2apgo@ws.net.home>
 <CAG27Bk26z9GmKnMyE-dffa13F1nRKPMPvdWzpASpJo8ONF_=YQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk26z9GmKnMyE-dffa13F1nRKPMPvdWzpASpJo8ONF_=YQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jan 24, 2016 at 11:09:47AM +0000, Sami Kerola wrote:
> On 23 January 2016 at 16:22, Karel Zak <kzak@redhat.com> wrote:
> > On Fri, Jan 22, 2016 at 10:03:47PM +0000, Sami Kerola wrote:
> >> Alternatively one could make swapon to get rid of all permission bits
> >> and set ownership to UID 0 by default when ever it activates a
> >> swapfile. How about that.
> >
> > Not sure if want to change any permissions on the fly, it would be
> > better to reject files (by swapon) with insecure permissions and
> > require something like --force for crazy users who wants to ignore
> > this problem.
> 
> Why not completely optional?
> 
> $ swapon --path-permissions [ignore|complain|stop|fix]

I don't think we want to merge another functionality to swapon. The
warnings are enough. For the rest we have ch{own,mod}. 

Let's Keep It Simple and Stupid. We all love kisses, right? :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
