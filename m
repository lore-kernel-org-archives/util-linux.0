Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48596 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752353AbcLHLYn (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 8 Dec 2016 06:24:43 -0500
Date: Thu, 8 Dec 2016 12:24:41 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Ray Strode <halfline@gmail.com>, util-linux@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Ray Strode <rstrode@redhat.com>
Subject: Re: [PATCH] login-utils: import environment from user manager on
 systemd systems
Message-ID: <20161208112441.5kckrt7cofh2opbz@ws.net.home>
References: <1477427661-19788-1-git-send-email-halfline@gmail.com>
 <CAA_Uwz+od5AwWosSzb_j59v2LvdZ=ipmHe2s+_kZiccC6v-FnQ@mail.gmail.com>
 <201612072104.37323.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201612072104.37323.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Dec 07, 2016 at 09:04:35PM +0100, Ruediger Meier wrote:
> On Wednesday 07 December 2016, Ray Strode wrote:
> > Hi Karel,
> >
> > On Tue, Oct 25, 2016 at 4:34 PM, Ray Strode <halfline@gmail.com> 
> wrote:
> > > From: Ray Strode <rstrode@redhat.com>
> > >
> > > If the user is using a systemd system, then its useful to grab the
> > > environment from the systemd user manager process.
> > >
> > > This allows administrators to initialize the environment of the
> > > sessions via systemd configuration.
> >
> > Any news on this?
> 
> I really don't like this as already discussed.

I had discussion about it with Ray on IRC, the conclusion has
been that the ideal solution would be to extend PAM to support 
another stack of modules. This stack will be executed on open PAM
session after switch from root to non-root user (after setuid()).

We had positive feedback about it from Red Hat PAM maintainer, but it
would be probably better to discuss it with PAM upstream. This change
will require a new stuff in PAM API.

The question is what to do *now* before the PAM will be extended. The
most simple solution will be to temporary merge Ray's patch for only
util-linux v2.30 (= for year 2017) to provide guys time to found a better
solution. 

It's important to say that v2.30 is expected in March/April, it's a long 
time to do a change in PAM...


Note, the issue is not about "bad boys from systemd camp". The
motivation for the change is wayland. The systemd has been selected as
a place where is possible to solve the problem.

Although I'm not sure why we need systemd as mediator, would be
possible to read the environment setting directly by login(1)? Or it's
expected that something (e.g. script) will be executed to get the session
initialized?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
