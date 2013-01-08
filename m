Return-Path: firebird347@gmail.com
MIME-Version: 1.0
Sender: firebird347@gmail.com
In-Reply-To: <20130107115103.GD28963@x2.redhat.com>
References: <1357183321-24637-4-git-send-email-cmaloney@theoreticalchaos.com>
 <805019865.52854570.1357230851238.JavaMail.root@redhat.com> <20130107115103.GD28963@x2.redhat.com>
From: Cody Maloney <cmaloney@theoreticalchaos.com>
Date: Mon, 7 Jan 2013 23:15:34 -0700
Message-ID: <CA+K3q6pjbLjc3MkpOywwBdjcr-4YtbN9h-sDA1C44e3T6B1V_w@mail.gmail.com>
Subject: Re: [PATCH 3/3] chsh: Add libuser support
To: Karel Zak <kzak@redhat.com>
Cc: Miloslav Trmac <mitr@redhat.com>, util-linux@vger.kernel.org
Content-Type: multipart/alternative; boundary=e89a8f2354f5d2faef04d2c0e0cc
List-ID: <util-linux.vger.kernel.org>

--e89a8f2354f5d2faef04d2c0e0cc
Content-Type: text/plain; charset=ISO-8859-1

I definitely don't mind depending on the newer version. I'll update the
patch(es) with both your comments, and write up the patch for chfn. I
should have them done and sent to the list in the next couple of days.

Cody


On Mon, Jan 7, 2013 at 4:51 AM, Karel Zak <kzak@redhat.com> wrote:

> On Thu, Jan 03, 2013 at 11:34:11AM -0500, Miloslav Trmac wrote:
> > > +   memset(&val, 0, sizeof(val));
> > > +   g_value_init(&val, G_TYPE_STRING);
> > > +   g_value_set_string(&val, shell);
> > > +
> > > +   lu_ent_clear(ent, LU_LOGINSHELL);
> > > +   lu_ent_add(ent, LU_LOGINSHELL, &val);
> > If you don't mind depending on libuser >= 0.58, all of the above can be
> replaced with
> > > lu_ent_set_string(ent, LU_LOGINSHELL, shell);
> > and you can drop the "g_value_unset" calls as well.
>
>  It would be nice to drop g_* junk :-)
>
>
>     Karel
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
>

--e89a8f2354f5d2faef04d2c0e0cc
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I definitely don&#39;t mind depending on the newer version=
. I&#39;ll update the patch(es) with both your comments, and write up the p=
atch for chfn. I should have them done and sent to the list in the next cou=
ple of days.<div>

<br></div><div>Cody</div></div><div class=3D"gmail_extra"><br><br><div clas=
s=3D"gmail_quote">On Mon, Jan 7, 2013 at 4:51 AM, Karel Zak <span dir=3D"lt=
r">&lt;<a href=3D"mailto:kzak@redhat.com" target=3D"_blank">kzak@redhat.com=
</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Thu, Jan 03, 2013 at 11=
:34:11AM -0500, Miloslav Trmac wrote:<br>
&gt; &gt; + =A0 memset(&amp;val, 0, sizeof(val));<br>
&gt; &gt; + =A0 g_value_init(&amp;val, G_TYPE_STRING);<br>
&gt; &gt; + =A0 g_value_set_string(&amp;val, shell);<br>
&gt; &gt; +<br>
&gt; &gt; + =A0 lu_ent_clear(ent, LU_LOGINSHELL);<br>
&gt; &gt; + =A0 lu_ent_add(ent, LU_LOGINSHELL, &amp;val);<br>
&gt; If you don&#39;t mind depending on libuser &gt;=3D 0.58, all of the ab=
ove can be replaced with<br>
&gt; &gt; lu_ent_set_string(ent, LU_LOGINSHELL, shell);<br>
&gt; and you can drop the &quot;g_value_unset&quot; calls as well.<br>
<br>
</div>=A0It would be nice to drop g_* junk :-)<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
=A0 =A0 Karel<br>
<br>
--<br>
=A0Karel Zak =A0&lt;<a href=3D"mailto:kzak@redhat.com">kzak@redhat.com</a>&=
gt;<br>
=A0<a href=3D"http://karelzak.blogspot.com" target=3D"_blank">http://karelz=
ak.blogspot.com</a><br>
</font></span></blockquote></div><br></div>

--e89a8f2354f5d2faef04d2c0e0cc--
