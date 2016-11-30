Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:52374 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753043AbcK3W75 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 30 Nov 2016 17:59:57 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Tilman Schmidt <tilman@imap.cc>
Subject: Re: [PATCH 1/2] misc: spelling, always use "cannot" instead of "can not"
Date: Wed, 30 Nov 2016 23:59:39 +0100
Cc: util-linux@vger.kernel.org
References: <1480515830-1408-1-git-send-email-sweet_f_a@gmx.de> <69f6d109-9399-5b36-73cb-a27c82a30110@imap.cc>
In-Reply-To: <69f6d109-9399-5b36-73cb-a27c82a30110@imap.cc>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201611302359.40231.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wednesday 30 November 2016, Tilman Schmidt wrote:
> Am 30.11.2016 um 15:23 schrieb Ruediger Meier:
> [...]
>
> > diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
> > index 1c4313a..a44216b 100644
> > --- a/login-utils/sulogin.c
> > +++ b/login-utils/sulogin.c
> > @@ -1012,7 +1012,7 @@ int main(int argc, char **argv)
> >  				mask_signal(SIGINT,  SIG_IGN, &saved_sigint);
> >
> >  				if (failed) {
> > -					fprintf(stderr, _("Can not execute su shell\n\n"));
> > +					fprintf(stderr, _("cannot execute su shell\n\n"));
>
> Might be better to preserve capitalization here.

I've changed it on purpose because usually we use small capitals in UL 
and no sentences (not ending with dot). This would be another thing we 
could make consistent for the whole project.

> >  					break;
> >  				}
> >  				fprintf(stderr, _("Login incorrect\n\n"));
> > @@ -1051,7 +1051,7 @@ int main(int argc, char **argv)
> >  				continue;
> >  		}
> >
> > -		errx(EXIT_FAILURE, _("Can not wait on su shell\n\n"));
> > +		errx(EXIT_FAILURE, _("cannot wait on su shell\n\n"));
>
> And here.
>
> >  	} while (1);
>
> [...]
>
> > diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
> > index bd702b0..e3e6ff6 100644
> > --- a/sys-utils/lscpu.c
> > +++ b/sys-utils/lscpu.c
> > @@ -886,12 +886,12 @@ is_vmware_platform(void)
> >  	act.sa_flags = SA_SIGINFO;
> >
> >  	if (sigaction(SIGSEGV, &act, &oact))
> > -		err(EXIT_FAILURE, _("error: can not set signal handler"));
> > +		err(EXIT_FAILURE, _("cannot set signal handler"));
> >
> >  	vmware_bdoor(&eax, &ebx, &ecx, &edx);
> >
> >  	if (sigaction(SIGSEGV, &oact, NULL))
> > -		err(EXIT_FAILURE, _("error: can not restore signal handler"));
> > +		err(EXIT_FAILURE, _("cannot restore signal handler"));
>
> Why drop the prefix "error: " in these two instances?
>
> Thanks,
> Tilman


