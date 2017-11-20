Return-Path: util-linux-owner@vger.kernel.org
Received: from archy.org.uk ([80.82.115.118]:37198 "EHLO archy.org.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752227AbdKTTG0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 20 Nov 2017 14:06:26 -0500
Date: Mon, 20 Nov 2017 14:06:23 -0500
From: Steven Smith <sos22@archy.org.uk>
To: Karel Zak <kzak@redhat.com>
Cc: Steven Smith <sos22@archy.org.uk>, util-linux@vger.kernel.org
Subject: Re: [PATCH] Fix a use of uninitialised memory in an agetty error
 path.
Message-ID: <20171120190623.GA26226@archy.org.uk>
References: <20171117164433.xtsgma2vdppjpio4@adrian>
 <20171120110223.3moy333zy7bedpby@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171120110223.3moy333zy7bedpby@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> > @@ -2000,12 +2003,15 @@ static char *get_logname(struct options *op, struct termios *tp, struct chardata
> >  				case ESRCH:
> >  				case EINVAL:
> >  				case ENOENT:
> > -					break;
> > +					exit_slowly(EXIT_SUCCESS);
> 
> OK, makes sense.
> 
> >  				default:
> >  					log_err(_("%s: read: %m"), op->tty);
> >  				}
> >  			}
> >  
> > +			if (readres == 0)
> > +				exit_slowly(EXIT_SUCCESS);
> 
> I'm not sure about it. Maybe it would be better to assume that readres == 0
> and no error is the same as c = 0. In this case functions returns NULL
> and we try another speed setting (if defined) for the terminal.

Hmm, maybe. The problem with that would be what happens if there isn't
another speed configured (which would match the system I was looking at when
I started looking at this). In that case, get_logname() will immediately retry
the read, without doing anything to clear the end of file condition, which
would be an infinite loop. Even if I configured multiple bauds, the test
environment which originally saw the issue is a VCONSOLE, so the loop in main()
which calls get_logname() would immediately retry without actually doing
anything with the configured speed, which I don't think would have helped
very much.

Perhaps changing the baud on a real serial port would have cleared the end of
file condition (or perhaps that's just showing my ignorance of how serial ports
work)? That might make something like this more reasonable:

@@ -2000,12 +2003,15 @@ static char *get_logname(struct options *op, struct termios *tp, struct chardata
                                case ESRCH:
                                case EINVAL:
                                case ENOENT:
-                                       break;
+                                       exit_slowly(EXIT_SUCCESS);
                                default:
                                        log_err(_("%s: read: %m"), op->tty);
                                }
                        }

+                       if (readres == 0)
+                               c = 0;
+
                        /* Do parity bit handling. */
                        if (eightbit)
                                ascval = c;
@@ -2030,6 +2036,8 @@ static char *get_logname(struct options *op, struct termios *tp, struct chardata
                        switch (key) {
                        case 0:
                                *bp = 0;
+                               if (op->flags & F_VCONSOLE)
+                                       exit_slowly(EXIT_SUCCESS);
                                if (op->numspeed > 1)
                                        return NULL;
                                break;

(Some side information: a couple of my test environments used to have problems
every couple of weeks because gettys went into infinite loops and contended
with the work the VMs were supposed to be doing. I didn't have debug symbols
then, but strace said that getty was repeatedly calling read(STDIN) and
getting back 0. I don't have a reliable way of reproducing the problem, but I
applied my first patch six months ago and I've not seen the misbehaviour
since then, so I'm reasonably confident it fixed the bug I was seeing.)

Thank you for the review.

Steven.
