Return-Path: rgerhards@hq.adiscon.com
MIME-Version: 1.0
In-Reply-To: <20150316104954.GE28925@ws.net.home>
References: <1426424094-25451-1-git-send-email-kerolasa@iki.fi>
	<1426424094-25451-6-git-send-email-kerolasa@iki.fi>
	<20150316104954.GE28925@ws.net.home>
Date: Mon, 16 Mar 2015 11:55:36 +0100
Message-ID: <CADk+mPA+R1PGGpA6=Aj0JB6RZSzS4NG-s9oSKEN35ff4SFZChA@mail.gmail.com>
Subject: Re: [PATCH 5/8] logger: fix rfc5424 format crash
From: Rainer Gerhards <rgerhards@hq.adiscon.com>
To: Karel Zak <kzak@redhat.com>
Cc: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org,
        Rainer Gerhards <rgerhards@adiscon.com>
Content-Type: multipart/alternative; boundary=f46d043c7ccca0a581051165b0f3
List-ID: <util-linux.vger.kernel.org>

--f46d043c7ccca0a581051165b0f3
Content-Type: text/plain; charset=UTF-8

2015-03-16 11:49 GMT+01:00 Karel Zak <kzak@redhat.com>:

> On Sun, Mar 15, 2015 at 12:54:51PM +0000, Sami Kerola wrote:
> > $ logger --rfc5424=notq message
> > Segmentation fault (core dumped)
>
> Not sure if Rainer is subscribed to the list, so please keep him in CC.
>

I am since a couple of day (but via a gmail alias for easier filtering).


>
> > Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> > ---
> >  misc-utils/logger.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/misc-utils/logger.c b/misc-utils/logger.c
> > index 838d225..b007377 100644
> > --- a/misc-utils/logger.c
> > +++ b/misc-utils/logger.c
> > @@ -476,7 +476,8 @@ static void syslog_rfc5424_header(struct logger_ctl
> *const ctl)
> >  #endif
> >                       xasprintf(&structured_data,
> >                                "[timeQuality tzKnown=\"1\"
> isSynced=\"0\"]");
> > -     }
> > +     } else
> > +             structured_data = xstrdup("");
>
> RFC5424:
>
>     STRUCTURED-DATA = NILVALUE / 1*SD-ELEMENT
>
>     NILVALUE        = "-"
>
>
> ... so I guess "" is bad idea. I'll fix it before commit.
>

yeah, I overlooked that case. I should really find time to work on "make
check"...

The best thing to do is use

= xstrdup(NILVALUE)

I defined NILVALUE exactly for those cases (see rest of code).

Rainer

PS: I've been silent for a couple of days because my main projects demand
attention. Will soon post more again here.

>
>     Karel
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
>

--f46d043c7ccca0a581051165b0f3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">2015=
-03-16 11:49 GMT+01:00 Karel Zak <span dir=3D"ltr">&lt;<a href=3D"mailto:kz=
ak@redhat.com" target=3D"_blank">kzak@redhat.com</a>&gt;</span>:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">On Sun, Mar 15, 2015 at 12:54:51PM +0000, Sami Kero=
la wrote:<br>
&gt; $ logger --rfc5424=3Dnotq message<br>
&gt; Segmentation fault (core dumped)<br>
<br>
Not sure if Rainer is subscribed to the list, so please keep him in CC.<br>=
</blockquote><div><br></div><div>I am since a couple of day (but via a gmai=
l alias for easier filtering).</div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">
<br>
&gt; Signed-off-by: Sami Kerola &lt;<a href=3D"mailto:kerolasa@iki.fi">kero=
lasa@iki.fi</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 misc-utils/logger.c | 3 ++-<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/misc-utils/logger.c b/misc-utils/logger.c<br>
&gt; index 838d225..b007377 100644<br>
&gt; --- a/misc-utils/logger.c<br>
&gt; +++ b/misc-utils/logger.c<br>
&gt; @@ -476,7 +476,8 @@ static void syslog_rfc5424_header(struct logger_ct=
l *const ctl)<br>
&gt;=C2=A0 #endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0xasprintf(&amp;structured_data,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;[timeQuality tzKnown=3D\&qu=
ot;1\&quot; isSynced=3D\&quot;0\&quot;]&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0} else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0structured_data =3D x=
strdup(&quot;&quot;);<br>
<br>
RFC5424:<br>
<br>
=C2=A0 =C2=A0 STRUCTURED-DATA =3D NILVALUE / 1*SD-ELEMENT<br>
<br>
=C2=A0 =C2=A0 NILVALUE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;-&quot;<br>
<br>
<br>
... so I guess &quot;&quot; is bad idea. I&#39;ll fix it before commit.<br>=
</blockquote><div><br></div><div>yeah, I overlooked that case. I should rea=
lly find time to work on &quot;make check&quot;...</div><div><br></div><div=
>The best thing to do is use</div><div><br></div><div>=3D xstrdup(NILVALUE)=
</div><div><br></div><div>I defined NILVALUE exactly for those cases (see r=
est of code).</div><div><br></div><div>Rainer</div><div><br></div><div>PS: =
I&#39;ve been silent for a couple of days because my main projects demand a=
ttention. Will soon post more again here.</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
=C2=A0 =C2=A0 Karel<br>
<br>
--<br>
=C2=A0Karel Zak=C2=A0 &lt;<a href=3D"mailto:kzak@redhat.com">kzak@redhat.co=
m</a>&gt;<br>
=C2=A0<a href=3D"http://karelzak.blogspot.com" target=3D"_blank">http://kar=
elzak.blogspot.com</a><br>
</font></span></blockquote></div><br></div></div>

--f46d043c7ccca0a581051165b0f3--
