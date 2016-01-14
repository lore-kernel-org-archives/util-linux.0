Return-Path: hzhong@gmail.com
MIME-Version: 1.0
Date: Thu, 14 Jan 2016 15:26:45 -0800
Message-ID: <CAHL05WNh=Tr_c91hpK462bfziiE+MK7zkrRLJ3u-BSvcmQTcig@mail.gmail.com>
Subject: Bad interaction between in.telnetd and login
From: Hua Zhong <hzhong@gmail.com>
To: richard@nod.at, kzak@redhat.com
Cc: util-linux@vger.kernel.org
Content-Type: multipart/alternative; boundary=94eb2c06c9a6b8ff810529539e92
List-ID: <util-linux.vger.kernel.org>

--94eb2c06c9a6b8ff810529539e92
Content-Type: text/plain; charset=UTF-8

Hi,

While working on Fedora 18, we found that sometimes telnetd would close
connections unexpectedly:

Trying 172.24.17.14...
Connected to 172.24.17.14.
Escape character is '^]'.
Connection closed by foreign host.

in.telnetd runs login as its subprocess and communicates with it through
the pty master/slave descriptors. Initially reading the pty master might
return EIO, until the slave is ready. But if it gets EIO after having read
valid data, it breaks out.

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
25645 read(3, 0xf77a91c0, 8192)         = -1 EIO (Input/output error) <--
this is fatal

This used to work at least in fc14, but in fc18 it seems broken. It happens
intermittently.

The following thread caught my eye

https://lkml.org/lkml/2012/6/4/495

After removing the three close() functions before vhangup(), this problem
seems to go away. I suspect that this change caused bad interaction between
in.telnetd and login. The extra closes seem to introduce EIO after
something can be read from the pty master descriptor. Now, you can argue
that the bug should be in in.telnetd, but I am not sure we want to break
all the applications that depend on the old login behavior.

I'd like to raise it to your attention and hear what you think the right
fix is.

Hua Zhong

PS: Attached is the code snippet in login.c:

        tcgetattr(0, &tt);
        ttt = tt;
        ttt.c_cflag &= ~HUPCL;

        if ((fchown(0, 0, 0) || fchmod(0, cxt->tty_mode)) && errno !=
EROFS) {

                syslog(LOG_ERR, _("FATAL: %s: change permissions failed:
%m"),
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

--94eb2c06c9a6b8ff810529539e92
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>While working on Fedora 18, we found that somet=
imes telnetd would close connections unexpectedly:<br><br>Trying 172.24.17.=
14...<br>Connected to 172.24.17.14.<br>Escape character is &#39;^]&#39;.<br=
>Connection closed by foreign host.<br><br>in.telnetd runs login as its sub=
process and communicates with it through the pty master/slave descriptors. =
Initially reading the pty master might return EIO, until the slave is ready=
. But if it gets EIO after having read valid data, it breaks out.<div><br><=
/div><div>What I find is that in.telnetd would sometimes get something like=
 this (25646 is login, and 25645 is telnetd) - getting EIO after reading so=
mething:</div><div><br></div><div><div>25646 ioctl(0, SNDCTL_TMR_START or S=
NDRV_TIMER_IOCTL_TREAD or TCSETS, {B9600 opost isig icanon echo ...}) =3D 0=
<br></div><div>25646 ioctl(0, SNDCTL_TMR_TIMEBASE or SNDRV_TIMER_IOCTL_NEXT=
_DEVICE or TCGETS, {B9600 opost isig icanon echo ...}) =3D 0</div><div>2564=
6 close(0) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0</div><div>25646 close(1) =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D 0</div><div>25646 close(2) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0</div><div>25645 &lt;.=
.. select resumed&gt; ) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 1 (in =
[3])</div><div>25646 rt_sigaction(SIGHUP, {SIG_IGN, [HUP], SA_RESTART}, =C2=
=A0&lt;unfinished ...&gt;</div><div>25645 read(3, =C2=A0&lt;unfinished ...&=
gt;</div><div>25646 &lt;... rt_sigaction resumed&gt; {SIG_IGN, [], 0}, 8) =
=3D 0</div><div>25645 &lt;... read resumed&gt; 0xf77a91c0, 8192) =3D -1 EIO=
 (Input/output error)</div><div>25646 vhangup( &lt;unfinished ...&gt;</div>=
<div>25645 select(4, [0 3], [], [0], NULL) =C2=A0 =3D 1 (in [3])</div><div>=
25645 read(3, &quot;\3&quot;, 8192) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =3D 1</div><div>25645 select(1, [0], [0], [0], NULL) =C2=A0 =C2=
=A0=3D 1 (out [0])</div><div>25645 send(0, &quot;\377&quot;, 1, MSG_OOB) =
=C2=A0 =C2=A0 =C2=A0 =3D 1</div><div>25645 select(1, [0], [0], [0], NULL) =
=C2=A0 =C2=A0=3D 1 (out [0])</div><div>25645 write(0, &quot;\362&quot;, 1) =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 1</div><div>25645 sele=
ct(4, [0 3], [], [0], NULL) =C2=A0 =3D 1 (in [3])</div><div>25645 read(3, 0=
xf77a91c0, 8192) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D -1 EIO (Input/output error=
) &lt;-- this is fatal</div><div><br></div><div>This used to work at least =
in fc14, but in fc18 it seems broken. It happens intermittently.</div><div>=
<br></div><div>The following thread caught my eye</div><br><a href=3D"https=
://lkml.org/lkml/2012/6/4/495">https://lkml.org/lkml/2012/6/4/495</a></div>=
<div><br></div><div>After removing the three close() functions before vhang=
up(), this problem seems to go away. I suspect that this change caused bad =
interaction between in.telnetd and login. The extra closes seem to introduc=
e EIO after something can be read from the pty master descriptor. Now, you =
can argue that the bug should be in in.telnetd, but I am not sure we want t=
o break all the applications that depend on the old login behavior.</div><d=
iv><br></div><div>I&#39;d like to raise it to your attention and hear what =
you think the right fix is.</div><div><br></div><div>Hua Zhong<br></div><di=
v><br></div><div>PS: Attached is the code snippet in login.c:</div><div><br=
></div><div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcgetattr(0, &amp;tt);</div><d=
iv>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ttt =3D tt;</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ttt.c_cflag &amp;=3D ~HUPCL;</div><div><br></div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if ((fchown(0, 0, 0) || fchmod(0, cxt-&gt;tty_mode)) &amp;&am=
p; errno !=3D EROFS) {</div><div><br></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 syslog(LOG_ERR, _(&quot;FATAL: %s: change perm=
issions failed: %m&quot;),</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c=
xt-&gt;tty_path);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 sleepexit(EXIT_FAILURE);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }=
</div><div><br></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Kill processes lef=
t on this tty */</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcsetattr(0, TCSANOW=
, &amp;ttt);</div><div><br></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*</div><=
div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Let&#39;s close file decriptors bef=
ore vhangup</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* <a href=3D"https:=
//lkml.org/lkml/2012/6/5/145">https://lkml.org/lkml/2012/6/5/145</a></div><=
div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 close(STDIN_FILENO);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(STDOUT=
_FILENO);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(STDERR_FILENO);</div>=
<div><br></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 signal(SIGHUP, SIG_IGN); =
=C2=A0 =C2=A0 =C2=A0 =C2=A0/* so vhangup() wont kill us */</div><div>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 vhangup();</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 sign=
al(SIGHUP, SIG_DFL);</div><div><br></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 /=
* open stdin,stdout,stderr to the tty */</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 open_tty(cxt-&gt;tty_path);</div><div><br></div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* restore tty modes */</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 tc=
setattr(0, TCSAFLUSH, &amp;tt);</div></div><div><br></div><div><br></div></=
div>

--94eb2c06c9a6b8ff810529539e92--
