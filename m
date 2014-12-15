Return-Path: will.johansson@gmail.com
MIME-Version: 1.0
In-Reply-To: <20141215091931.GW19904@x2.net.home>
References: <1418179231-21326-1-git-send-email-will.johansson@gmail.com>
	<20141215091931.GW19904@x2.net.home>
Date: Mon, 15 Dec 2014 03:45:58 -0800
Message-ID: <CAE83jyx=WxCNb-J99zG4jsrzZMBjomEsXFHNCdY+jofzvNhoVg@mail.gmail.com>
Subject: Re: login-utils: Enable building util-linux against OpenPAM
From: Will Johansson <will.johansson@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: multipart/alternative; boundary=047d7bdc87823d8e96050a3fc934
List-ID: <util-linux.vger.kernel.org>

--047d7bdc87823d8e96050a3fc934
Content-Type: text/plain; charset=UTF-8

Hi Karel,

Thanks for applying. I have a small patch for _HAVE_UT_TV incoming in a few
minutes.

Turns out it was because musl-libc doesn't define _HAVE_UT_TV, even though
musl-libc's utmp struct does have a ut_tv field. There are two options: 1.)
I could patch upstream musl-libc to define _HAVE_UT_TV or 2.) detect
musl-libc somehow. I think I prefer the first option.

Thanks again,

Will

On Mon, Dec 15, 2014 at 1:19 AM, Karel Zak <kzak@redhat.com> wrote:
>
> On Tue, Dec 09, 2014 at 06:40:30PM -0800, Will Johansson wrote:
> > I recently experimented with cross-compiling for embedded devices, and
> > sought to try out util-linux with OpenPAM instead of Linux-PAM because
> > OpenPAM was simpler to cross-compile. Unfortunately for me, it did not
> > work out of the box, so I decided to try to patch util-linux to support
> > compiling against OpenPAM. Turned out to be a fairly simple exercise.
> >
> > This is the fruit of my efforts. There is a caveat, which I will
>
>  Applied, thanks.
>
> > be happy to address if it's a problem. The patch's configuration does
> > not support building if you happen to have both Linux-PAM and OpenPAM
> > in your build paths. I could update it to prefer Linux-PAM by default.
> > I'm not sure how it'd would work if OpenPAM libraries is also in the
> > search path, as -lpam is used by both Linux-PAM and OpenPAM (probably
> > undefined behavior).
> >
> > Either way, it should compile fine against Linux-PAM and OpenPAM.
> > There are some unused variables in login.c, but seems to have to do
> > with _HAVE_UT_TV, which is not the case in my configuration. I'm
> > more than happy to provide a separate patch to wrap the unused
> > variables with an #ifdef _HAVE_UT_TV.
>
>  I don't have OpenPAM, so I'm not able to verify usability, but it
>  would be nice to have build without warnings.
>
>     Karel
>
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
>


-- 
Will Johansson

--047d7bdc87823d8e96050a3fc934
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Karel,<br><br>Thanks for applying. I have a small =
patch for _HAVE_UT_TV incoming in a few minutes.<br><br>Turns out it was be=
cause musl-libc doesn&#39;t define _HAVE_UT_TV, even though musl-libc&#39;s=
 utmp struct does have a ut_tv field. There are two options: 1.) I could pa=
tch upstream musl-libc to define _HAVE_UT_TV or 2.) detect musl-libc someho=
w. I think I prefer the first option.<br><br></div>Thanks again,<br><br>Wil=
l<br></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon=
, Dec 15, 2014 at 1:19 AM, Karel Zak <span dir=3D"ltr">&lt;<a href=3D"mailt=
o:kzak@redhat.com" target=3D"_blank">kzak@redhat.com</a>&gt;</span> wrote:<=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex"><span class=3D"">On Tue, Dec 09, 2014 at 06:4=
0:30PM -0800, Will Johansson wrote:<br>
&gt; I recently experimented with cross-compiling for embedded devices, and=
<br>
&gt; sought to try out util-linux with OpenPAM instead of Linux-PAM because=
<br>
&gt; OpenPAM was simpler to cross-compile. Unfortunately for me, it did not=
<br>
&gt; work out of the box, so I decided to try to patch util-linux to suppor=
t<br>
&gt; compiling against OpenPAM. Turned out to be a fairly simple exercise.<=
br>
&gt;<br>
&gt; This is the fruit of my efforts. There is a caveat, which I will<br>
<br>
</span>=C2=A0Applied, thanks.<br>
<span class=3D""><br>
&gt; be happy to address if it&#39;s a problem. The patch&#39;s configurati=
on does<br>
&gt; not support building if you happen to have both Linux-PAM and OpenPAM<=
br>
&gt; in your build paths. I could update it to prefer Linux-PAM by default.=
<br>
&gt; I&#39;m not sure how it&#39;d would work if OpenPAM libraries is also =
in the<br>
&gt; search path, as -lpam is used by both Linux-PAM and OpenPAM (probably<=
br>
&gt; undefined behavior).<br>
&gt;<br>
&gt; Either way, it should compile fine against Linux-PAM and OpenPAM.<br>
&gt; There are some unused variables in login.c, but seems to have to do<br=
>
&gt; with _HAVE_UT_TV, which is not the case in my configuration. I&#39;m<b=
r>
&gt; more than happy to provide a separate patch to wrap the unused<br>
&gt; variables with an #ifdef _HAVE_UT_TV.<br>
<br>
</span>=C2=A0I don&#39;t have OpenPAM, so I&#39;m not able to verify usabil=
ity, but it<br>
=C2=A0would be nice to have build without warnings.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
=C2=A0 =C2=A0 Karel<br>
<br>
<br>
--<br>
=C2=A0Karel Zak=C2=A0 &lt;<a href=3D"mailto:kzak@redhat.com">kzak@redhat.co=
m</a>&gt;<br>
=C2=A0<a href=3D"http://karelzak.blogspot.com" target=3D"_blank">http://kar=
elzak.blogspot.com</a><br>
</font></span></blockquote></div><br clear=3D"all"><br>-- <br><div class=3D=
"gmail_signature">Will Johansson</div>
</div>

--047d7bdc87823d8e96050a3fc934--
