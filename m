Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48924 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727610AbeJEQwo (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 5 Oct 2018 12:52:44 -0400
Date: Fri, 5 Oct 2018 11:54:41 +0200
From: Karel Zak <kzak@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] unshare: allow to set a new root
Message-ID: <20181005095441.feybdayxrom62qz3@ws.net.home>
References: <20180928124512.13979-1-laurent@vivier.eu>
 <20180928124512.13979-2-laurent@vivier.eu>
 <20181004101112.2542qy4di4sykelp@ws.net.home>
 <fd5c5d6d-8e65-ddfd-f07f-832c9baab53f@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <fd5c5d6d-8e65-ddfd-f07f-832c9baab53f@vivier.eu>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Oct 04, 2018 at 12:15:15PM +0200, Laurent Vivier wrote:
> Le 04/10/2018 à 12:11, Karel Zak a écrit :
> > On Fri, Sep 28, 2018 at 02:45:11PM +0200, Laurent Vivier wrote:
> >> +	if (newroot) {
> >> +		if (chroot(newroot) != 0)
> >> +			err(EXIT_FAILURE,
> >> +			    _("cannot change root directory to '%s'"), newroot);
> >> +		if (chdir(newdir))
> >> +			err(EXIT_FAILURE, _("cannot chdir to '%s'"), newdir);
> >> +	}
> > 
> > It means that --wd is usable only when --root is specified. Is it
> > expected? Would be better to use
> 
> Yes, the idea was to switch to a working directory in the chroot case.
> 
> But if you think it can be useful to switch to another directory on the
> non-chroot case, I can upgrade the patch as you say.

In the nsenter we use --wd as generic and independent on --root. It
would be probably better to keep the semantic the same (although in
this case it has probably minimal sense for end-users).

So yes, upgrade the patch to call chdir() always when --wd specified.
Thanks.

    Karel

> 
> Thanks,
> Laurent
> >  char *newdir = NULL;
> > 
> >  while ((c = getopt_long(....))) {
> >     ...
> >     case 'w':
> >         newdir = optarg;
> >         break;
> >  }
> >  ...
> > 
> >  if (newroot) {
> >     if (chroot(newroot))
> >         ... error ...
> >     if (chdir(newdir ? newdir : "/"))
> >         ... error ...
> > 
> >  } else if (newdir && chdir(newdir))
> >     ... error ...
> > 
> > 
> >     Karel
> > 
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
