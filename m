Return-Path: sos22@archy.org.uk
Date: Wed, 22 Nov 2017 08:15:38 -0800
From: Steven Smith <sos22@archy.org.uk>
To: Karel Zak <kzak@redhat.com>
Cc: Steven Smith <sos22@archy.org.uk>, util-linux@vger.kernel.org,
	sos22@srcf.ucam.org
Subject: Re: [PATCH] Fix a use of uninitialised memory in an agetty error
 path.
Message-ID: <20171122161538.v2m74umknmbkggtz@adrian>
References: <20171117164433.xtsgma2vdppjpio4@adrian>
 <20171120110223.3moy333zy7bedpby@ws.net.home>
 <20171120190623.GA26226@archy.org.uk>
 <20171121102314.272hdgjuw7glu2ru@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171121102314.272hdgjuw7glu2ru@ws.net.home>
List-ID: <util-linux.vger.kernel.org>

> > @@ -2000,12 +2003,15 @@ static char *get_logname(struct options *op, struct termios *tp, struct chardata
> >                                 case ESRCH:
> >                                 case EINVAL:
> >                                 case ENOENT:
> > -                                       break;
> > +                                       exit_slowly(EXIT_SUCCESS);
> >                                 default:
> >                                         log_err(_("%s: read: %m"), op->tty);
> >                                 }
> >                         }
> > 
> > +                       if (readres == 0)
> > +                               c = 0;
> > +
> >                         /* Do parity bit handling. */
> >                         if (eightbit)
> >                                 ascval = c;
> > @@ -2030,6 +2036,8 @@ static char *get_logname(struct options *op, struct termios *tp, struct chardata
> >                         switch (key) {
> >                         case 0:
> >                                 *bp = 0;
> > +                               if (op->flags & F_VCONSOLE)
> > +                                       exit_slowly(EXIT_SUCCESS);
> >                                 if (op->numspeed > 1)
> >                                         return NULL;
> 
> Yes, that's what I've though about. I have committed a little bit modified
> version:
> 
> -                               if (op->numspeed > 1)
> +                               if (op->numspeed > 1 && !(op->flags & F_VCONSOLE))
>                                         return NULL;
> +                               if (readres == 0)
> +                                       exit_slowly(EXIT_SUCCESS);
>                                 break;
> 
> the speed configuration should be accepted only for !F_VCONSOLE.

That's great, thank you.

Steven.
