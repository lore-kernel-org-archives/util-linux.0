Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51530 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751528AbdKUKXR (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 21 Nov 2017 05:23:17 -0500
Date: Tue, 21 Nov 2017 11:23:14 +0100
From: Karel Zak <kzak@redhat.com>
To: Steven Smith <sos22@archy.org.uk>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Fix a use of uninitialised memory in an agetty error
 path.
Message-ID: <20171121102314.272hdgjuw7glu2ru@ws.net.home>
References: <20171117164433.xtsgma2vdppjpio4@adrian>
 <20171120110223.3moy333zy7bedpby@ws.net.home>
 <20171120190623.GA26226@archy.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171120190623.GA26226@archy.org.uk>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 20, 2017 at 02:06:23PM -0500, Steven Smith wrote:
> > > +			if (readres == 0)
> > > +				exit_slowly(EXIT_SUCCESS);
> > 
> > I'm not sure about it. Maybe it would be better to assume that readres == 0
> > and no error is the same as c = 0. In this case functions returns NULL
> > and we try another speed setting (if defined) for the terminal.
> 
> Hmm, maybe. The problem with that would be what happens if there isn't
> another speed configured (which would match the system I was looking at when
> I started looking at this). In that case, get_logname() will immediately retry
> the read, without doing anything to clear the end of file condition, which
> would be an infinite loop. Even if I configured multiple bauds, the test
> environment which originally saw the issue is a VCONSOLE, so the loop in main()
> which calls get_logname() would immediately retry without actually doing
> anything with the configured speed, which I don't think would have helped
> very much.
> 
> Perhaps changing the baud on a real serial port would have cleared the end of
> file condition (or perhaps that's just showing my ignorance of how serial ports
> work)? That might make something like this more reasonable:
> 
> @@ -2000,12 +2003,15 @@ static char *get_logname(struct options *op, struct termios *tp, struct chardata
>                                 case ESRCH:
>                                 case EINVAL:
>                                 case ENOENT:
> -                                       break;
> +                                       exit_slowly(EXIT_SUCCESS);
>                                 default:
>                                         log_err(_("%s: read: %m"), op->tty);
>                                 }
>                         }
> 
> +                       if (readres == 0)
> +                               c = 0;
> +
>                         /* Do parity bit handling. */
>                         if (eightbit)
>                                 ascval = c;
> @@ -2030,6 +2036,8 @@ static char *get_logname(struct options *op, struct termios *tp, struct chardata
>                         switch (key) {
>                         case 0:
>                                 *bp = 0;
> +                               if (op->flags & F_VCONSOLE)
> +                                       exit_slowly(EXIT_SUCCESS);
>                                 if (op->numspeed > 1)
>                                         return NULL;

Yes, that's what I've though about. I have committed a little bit modified
version:

-                               if (op->numspeed > 1)
+                               if (op->numspeed > 1 && !(op->flags & F_VCONSOLE))
                                        return NULL;
+                               if (readres == 0)
+                                       exit_slowly(EXIT_SUCCESS);
                                break;

the speed configuration should be accepted only for !F_VCONSOLE. IMHO
the current code is weak (independently on your read() issue:-)


The another weak thing is that agetty don't care if all speeds has
been already tested. The next_speed() increments baud_index again and
again... maybe we need another exit_slow() here too.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
