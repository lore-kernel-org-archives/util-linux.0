Return-Path: peter@cordes.ca
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Date: Sat, 16 May 2015 14:50:38 -0300
To: Karel Zak <kzak@redhat.com>
Cc: Isaac Dunham <ibid.ag@gmail.com>,
        =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>,
        Mike Frysinger <vapier@gentoo.org>, util-linux@vger.kernel.org
Subject: Re: [PATCH] build-sys: fix parallel builds w/setarch links
Message-id: <20150516175038.GG3933@cordes.ca>
References: <1430711464-4943-1-git-send-email-vapier@gentoo.org>
 <55489D6D.9010303@draigBrady.com> <20150510203807.GA1832@newbook>
 <20150511080528.GK27969@ws.net.home>
In-reply-to: <20150511080528.GK27969@ws.net.home>
From: Peter Cordes <peter@cordes.ca>
List-ID: <util-linux.vger.kernel.org>

On Mon, May 11, 2015 at 10:05:28AM +0200, Karel Zak wrote:
> On Sun, May 10, 2015 at 01:38:08PM -0700, Isaac Dunham wrote:
> > On Tue, May 05, 2015 at 11:37:33AM +0100, Pádraig Brady wrote:
> > > On 04/05/15 04:51, Mike Frysinger wrote:
> > > > From: Mike Frysinger <vapier@chromium.org>
> > > > 
> > > > The symlink generation tries to write to the sys-utils/ subdir but does
> > > > not make sure that dir exists.  This can sometimes lead to parallel build
> > > > failures when building out-of-tree
> > > 
> > > >  $(SETARCH_MAN_LINKS):
> > > > +	$(AM_V_at) test -d $(dir $@) || mkdir -p $(dir $@)
> > > >  	$(AM_V_GEN)echo ".so man8/setarch.8" > $@
> > > >  
> > > >  install-exec-hook-setarch:
> > > 
> > > The `test -d ... ||` bit is racy and redundant I think
> > 
> > Racy, yes, but no more so than "mkdir -p $DIR && install $FILE $DIR":
> > it's an inherent limitation of shell scripts.

 You mean racy as in multiple mkdir -p invocations could happen?  A C
implementation could shorten the window for the race (because mkdir(2)
would directly follow stat(2), rather than delayed by
fork/exec/dynamic linker startup).  Or handle EEXISTS specially and
test again for existance.  You could do most of that in shell, but it
would make the code a mess.

> > Redundant, certainly: mkdir -p $DIR is required to succeed if $DIR is
> > a preexisting directory (though it will fail if part of the path is a
> > regular file).
>
>  It seems that 'test || mkdir' is nothing unusual in makefiles. The
>  problem is "mkdir -p" portability (at least from autotools point of
>  view :-), it seems that the proper way is to use 
> 
>     @$(MKDIR_P) $(dir $@)
> 
>  rather than directly call mkdir.


 The test || mkdir idiom also has a performance benefit: test is a
shell builtin in most/all shells.  stat(2) is a lot faster than
fork / exec / process startup.  (For portable build systems, this is a
huge deal on cygwin compared to anything else, because the overhead
of running a binary is huge there.)

 Anyway, if checking for existence is going to happen often, then it's
worth doing test || mkdir, rather than relying on GNU mkdir -p.

-- 
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@cor , des.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC
