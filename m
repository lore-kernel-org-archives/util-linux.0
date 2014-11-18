Return-Path: d@falconindy.com
MIME-Version: 1.0
Date: Tue, 18 Nov 2014 09:28:51 -0500
Message-ID: <CA+mSPTjwXzTnMeRb+kBF1RGLCCE_LOXDTqPgZXjrdKWbm=y9qg@mail.gmail.com>
Subject: Re: [PATCH] bash-completion: Invoke actual commands to be completed,
 not basenames
From: Dave Reisner <d@falconindy.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org,
        =?UTF-8?Q?Ville_Skytt=C3=A4?= <ville.skytta@iki.fi>
Content-Type: multipart/alternative; boundary=001a1133e7aa08653f050822ea4e
List-ID: <util-linux.vger.kernel.org>

--001a1133e7aa08653f050822ea4e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Nov 18, 2014 8:00 AM, "Karel Zak" <kzak@redhat.com> wrote:
>
> On Sat, Nov 15, 2014 at 10:36:04PM +0200, Ville Skytt=C3=A4 wrote:
> >  bash-completion/chsh    | 2 +-
> >  bash-completion/eject   | 2 +-
> >  bash-completion/findmnt | 8 ++++----
> >  bash-completion/losetup | 4 ++--
> >  bash-completion/lsblk   | 2 +-
> >  bash-completion/setarch | 2 +-
> >  bash-completion/setpriv | 2 +-
> >  7 files changed, 11 insertions(+), 11 deletions(-)
>
>  Applied, thanks!
>
>     Karel
>

I think this patch breaks completions when used with binaries from a build
root containing whitespace in the path. The use is probably rare, but fix
is simple -- quote the $1. The commands inside $() have their own separate
level of quoting, i.e. "$("$1" -X)" is what we want.

> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--001a1133e7aa08653f050822ea4e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Nov 18, 2014 8:00 AM, &quot;Karel Zak&quot; &lt;<a href=3D"mailto:kzak@r=
edhat.com">kzak@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Sat, Nov 15, 2014 at 10:36:04PM +0200, Ville Skytt=C3=A4 wrote:<br>
&gt; &gt;=C2=A0 bash-completion/chsh=C2=A0 =C2=A0 | 2 +-<br>
&gt; &gt;=C2=A0 bash-completion/eject=C2=A0 =C2=A0| 2 +-<br>
&gt; &gt;=C2=A0 bash-completion/findmnt | 8 ++++----<br>
&gt; &gt;=C2=A0 bash-completion/losetup | 4 ++--<br>
&gt; &gt;=C2=A0 bash-completion/lsblk=C2=A0 =C2=A0| 2 +-<br>
&gt; &gt;=C2=A0 bash-completion/setarch | 2 +-<br>
&gt; &gt;=C2=A0 bash-completion/setpriv | 2 +-<br>
&gt; &gt;=C2=A0 7 files changed, 11 insertions(+), 11 deletions(-)<br>
&gt;<br>
&gt; =C2=A0Applied, thanks!<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 Karel<br>
&gt;</p>
<p dir=3D"ltr">I think this patch breaks completions when used with binarie=
s from a build root containing whitespace in the path. The use is probably =
rare, but fix is simple -- quote the $1. The commands inside $() have their=
 own separate level of quoting, i.e. &quot;$(&quot;$1&quot; -X)&quot; is wh=
at we want.<br></p>
<p dir=3D"ltr">&gt; --<br>
&gt; =C2=A0Karel Zak=C2=A0 &lt;<a href=3D"mailto:kzak@redhat.com">kzak@redh=
at.com</a>&gt;<br>
&gt; =C2=A0<a href=3D"http://karelzak.blogspot.com">http://karelzak.blogspo=
t.com</a><br>
&gt; --<br>
&gt; To unsubscribe from this list: send the line &quot;unsubscribe util-li=
nux&quot; in<br>
&gt; the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">=
majordomo@vger.kernel.org</a><br>
&gt; More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordo=
mo-info.html">http://vger.kernel.org/majordomo-info.html</a><br>
</p>

--001a1133e7aa08653f050822ea4e--
