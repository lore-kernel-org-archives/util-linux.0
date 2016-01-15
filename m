Return-Path: hzhong@gmail.com
MIME-Version: 1.0
In-Reply-To: <20160115174829.5yayeuk57ksgms4q@ws.net.home>
References: <CAHL05WNh=Tr_c91hpK462bfziiE+MK7zkrRLJ3u-BSvcmQTcig@mail.gmail.com>
	<20160115174829.5yayeuk57ksgms4q@ws.net.home>
Date: Fri, 15 Jan 2016 09:57:53 -0800
Message-ID: <CAHL05WPUV7TcWnnE9wCVT4cCLhT7WgPRPjLVjYo=R+OCifREGA@mail.gmail.com>
Subject: Re: Bad interaction between in.telnetd and login
From: Hua Zhong <hzhong@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: "richard@nod.at" <richard@nod.at>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Content-Type: multipart/alternative; boundary=001a114f0f047a889505296324a8
List-ID: <util-linux.vger.kernel.org>

--001a114f0f047a889505296324a8
Content-Type: text/plain; charset=UTF-8

Hi Karel,

I don't think it's the same issue, as I already have the TCSANOW fix
applied (you can see it in the code snippet I attached). This is something
different.

On Friday, January 15, 2016, Karel Zak <kzak@redhat.com> wrote:

> On Thu, Jan 14, 2016 at 03:26:45PM -0800, Hua Zhong wrote:
> > While working on Fedora 18, we found that sometimes telnetd would close
> > connections unexpectedly:
>
> Sounds like:
> https://bugzilla.redhat.com/show_bug.cgi?id=962145
>
> maybe it's time to update... try util-linux >= 2.24, the current
> upstream stable version is v2.27.1.
>
>     Karel
>
> --
>  Karel Zak  <kzak@redhat.com <javascript:;>>
>  http://karelzak.blogspot.com
>

--001a114f0f047a889505296324a8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Karel,<div><br></div><div>I don&#39;t think it&#39;s the same issue, as =
I already have the TCSANOW fix applied (you can see it in the code snippet =
I attached). This is something different.<span></span><br><br>On Friday, Ja=
nuary 15, 2016, Karel Zak &lt;<a href=3D"mailto:kzak@redhat.com">kzak@redha=
t.com</a>&gt; wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Thu, Jan 14, 2016=
 at 03:26:45PM -0800, Hua Zhong wrote:<br>
&gt; While working on Fedora 18, we found that sometimes telnetd would clos=
e<br>
&gt; connections unexpectedly:<br>
<br>
Sounds like:<br>
<a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D962145" target=3D"=
_blank">https://bugzilla.redhat.com/show_bug.cgi?id=3D962145</a><br>
<br>
maybe it&#39;s time to update... try util-linux &gt;=3D 2.24, the current<b=
r>
upstream stable version is v2.27.1.<br>
<br>
=C2=A0 =C2=A0 Karel<br>
<br>
--<br>
=C2=A0Karel Zak=C2=A0 &lt;<a href=3D"javascript:;" onclick=3D"_e(event, &#3=
9;cvml&#39;, &#39;kzak@redhat.com&#39;)">kzak@redhat.com</a>&gt;<br>
=C2=A0<a href=3D"http://karelzak.blogspot.com" target=3D"_blank">http://kar=
elzak.blogspot.com</a><br>
</blockquote></div>

--001a114f0f047a889505296324a8--
