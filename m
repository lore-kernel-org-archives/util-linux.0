Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:23415 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753446AbaHFIU3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 6 Aug 2014 04:20:29 -0400
Date: Wed, 6 Aug 2014 10:20:26 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH 8/8] zramctl: allow use of --algorithm and --streams alone
Message-ID: <20140806082026.GH19820@x2.net.home>
References: <1407107290-5806-1-git-send-email-kerolasa@iki.fi>
 <20140804115556.GA6923@x2.net.home>
 <CAG27Bk29oWnsjQDHJJmvENsr9ghcnq0soOFCx3fzEJ1SYMmfFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk29oWnsjQDHJJmvENsr9ghcnq0soOFCx3fzEJ1SYMmfFQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 05, 2014 at 11:36:59PM +0100, Sami Kerola wrote:
> On 4 August 2014 12:55, Karel Zak <kzak@redhat.com> wrote:
> > On Mon, Aug 04, 2014 at 12:08:10AM +0100, Sami Kerola wrote:
> >> Earlier the --algorithm and --streams had to be combined with --size.  To
> >> user requirement to combine with --size was indirectly told using
> >> following message.
> >
> > And is it really supported by kernel? I see in
> > Documentation/blockdev/zram.txt:
> >
> >  In order to enable compression backend's multi stream support
> >  max_comp_streams must be initially set to desired concurrency
> >  level before ZRAM device initialisation.
> >
> > I guess that when you set disksize the zram device is "locked" for
> > setting changes. It means that modify already initialized (created)
> > zram devices is impossible. You have to reset the device to "unlock"
> > the device setting.
> 
> After playing with zramctl I found out --algorithm must be set before
> --size. The --streams can be set after --size, but not if device is in use.
> When device is in use none of the settings are allowed.

 I'd like to keep the command line semantic simple and stupid and
 support --streams and --algorithm for device initialization (it means
 with --size) only. We don't have to export to command line all the
 crazy kernel implementation details.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
