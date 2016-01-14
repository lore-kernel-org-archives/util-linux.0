Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-yk0-f172.google.com ([209.85.160.172]:33473 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbcANX3S (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 14 Jan 2016 18:29:18 -0500
Received: by mail-yk0-f172.google.com with SMTP id k129so502814887yke.0
        for <util-linux@vger.kernel.org>; Thu, 14 Jan 2016 15:29:17 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 14 Jan 2016 15:29:17 -0800
Message-ID: <CAHL05WPD5tfBcHamDn+tUSt7WG=WhfuL126eEkmnXqNn+eO3wQ@mail.gmail.com>
Subject: Bad interaction between in.telnetd and login
From: Hua Zhong <hzhong@gmail.com>
To: richard@nod.at, kzak@redhat.com, util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

[resend as pain text mode]

Hi,

While working on Fedora 18, we found that sometimes telnetd would
close connections unexpectedly:

Trying 172.24.17.14...
Connected to 172.24.17.14.
Escape character is '^]'.
Connection closed by foreign host.

in.telnetd runs login as its subprocess and communicates with it
through the pty master/slave descriptors. Initially reading the pty
master might return EIO, until the slave is ready. But if it gets EIO
after having read valid data, it breaks out.

What I find is that in.telnetd would sometimes get something like this
(25646 is login, and 25645 is telnetd) - getting EIO after reading
something:

25646 ioctl(0, SNDCTL_TMR_START or SNDRV_TIMER_IOCTL_TREAD or TCSETS,
{B9600 opost isig icanon echo ...}) = 0
25646 ioctl(0, SNDCTL_TMR_TIMEBASE or SNDRV_TIMER_IOCTL_NEXT_DEVICE or
TCGETS, {B9600 opost isig icanon echo ...}) = 0
25646 close(0)                          = 0
25646 close(1)                          = 0
25646 close(2)                          = 0
25645 <... select resumed> )            = 1 (in [3])
25646 rt_sigaction(SIGHUP, {SIG_IGN, [HUP], SA_RESTART},  <unfinished ...>
25645 read(3,  <unfinished ...>
25646 <... rt_sigaction resumed> {SIG_IGN, [], 0}, 8) = 0
25645 <... read resumed> 0xf77a91c0, 8192) = -1 EIO (Input/output error)
25646 vhangup( <unfinished ...>
25645 select(4, [0 3], [], [0], NULL)   = 1 (in [3])
25645 read(3, "\3", 8192)               = 1
25645 select(1, [0], [0], [0], NULL)    = 1 (out [0])
25645 send(0, "\377", 1, MSG_OOB)       = 1
25645 select(1, [0], [0], [0], NULL)    = 1 (out [0])
25645 write(0, "\362", 1)               = 1
25645 select(4, [0 3], [], [0], NULL)   = 1 (in [3])
25645 read(3, 0xf77a91c0, 8192)         = -1 EIO (Input/output error)
<-- this is fatal

This used to work at least in fc14, but in fc18 it seems broken. It
happens intermittently.

The following thread caught my eye

https://lkml.org/lkml/2012/6/4/495

After removing the three close() functions before vhangup(), this
problem seems to go away. I suspect that this change caused bad
interaction between in.telnetd and login. The extra closes seem to
introduce EIO after something can be read from the pty master
descriptor. Now, you can argue that the bug should be in in.telnetd,
but I am not sure we want to break all the applications that depend on
the old login behavior.

I'd like to raise it to your attention and hear what you think the right fix is.

Hua Zhong

PS: Attached is the code snippet in login.c:

        tcgetattr(0, &tt);
        ttt = tt;
        ttt.c_cflag &= ~HUPCL;

        if ((fchown(0, 0, 0) || fchmod(0, cxt->tty_mode)) && errno != EROFS) {

                syslog(LOG_ERR, _("FATAL: %s: change permissions failed: %m"),
                                cxt->tty_path);
                sleepexit(EXIT_FAILURE);
        }

        /* Kill processes left on this tty */
        tcsetattr(0, TCSANOW, &ttt);

        /*
         * Let's close file decriptors before vhangup
         * https://lkml.org/lkml/2012/6/5/145
         */
        close(STDIN_FILENO);
        close(STDOUT_FILENO);
        close(STDERR_FILENO);

        signal(SIGHUP, SIG_IGN);        /* so vhangup() wont kill us */
        vhangup();
        signal(SIGHUP, SIG_DFL);

        /* open stdin,stdout,stderr to the tty */
        open_tty(cxt->tty_path);

        /* restore tty modes */
        tcsetattr(0, TCSAFLUSH, &tt);
