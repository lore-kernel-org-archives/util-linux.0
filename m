Return-Path: d@falconindy.com
MIME-Version: 1.0
In-Reply-To: <20120426074635.GB28346@x2.net.home>
References: <1335400252-17929-1-git-send-email-dreisner@archlinux.org>
	<1335400252-17929-2-git-send-email-dreisner@archlinux.org>
	<20120426021651.GH938@rampage>
	<20120426074635.GB28346@x2.net.home>
Date: Thu, 26 Apr 2012 06:45:27 -0400
Message-ID: <CA+mSPTgjGzNw0XGSvWt_AbwZ_RRuOrD49cCxzkmq0GV4_T1Vsw@mail.gmail.com>
Subject: Re: [PATCH 2/2] findmnt: add match_by_file to do within-device matching
From: Dave Reisner <d@falconindy.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: multipart/alternative; boundary=e89a8ff1c3a69f192504be92afef
List-ID: <util-linux.vger.kernel.org>

--e89a8ff1c3a69f192504be92afef
Content-Type: text/plain; charset=ISO-8859-1

On Apr 26, 2012 3:47 AM, "Karel Zak" <kzak@redhat.com> wrote:
>
> On Wed, Apr 25, 2012 at 10:16:51PM -0400, Dave Reisner wrote:
> > On Wed, Apr 25, 2012 at 08:30:52PM -0400, Dave Reisner wrote:
> > > Use the newly exported mnt_get_mountpoint to determine the device
that a
> > > given file resides on, in case the supplied source or target is not
> > > explicitly a mount point.
> > >
> > > http://www.spinics.net/lists/util-linux-ng/msg06081.html
> > >
> > > Signed-off-by: Dave Reisner <dreisner@archlinux.org>
> > > ---
> >
> > On second thought, this isn't good -- it'll return results even when
> > you're searching with --fstab (which is completely undesirable, imo).
>
>  I'll fix it, that's easy. Thanks.
>
> > >     m = get_match(COL_TARGET);
> > > -   if (m && !mnt_fs_match_target(fs, m, cache))
> > > +   if (m && !match_by_file(m, fs, mnt_fs_match_target))
> > >             return rc;
> > >
> > >     m = get_match(COL_SOURCE);
> > > -   if (m && !mnt_fs_match_source(fs, m, cache))
> > > +   if (m && !match_by_file(m, fs, mnt_fs_match_source))
>
>  why we need this functionality for SOURCE too?

Ah. Silly of me. We definitely don't need this.

>
>    Karel
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--e89a8ff1c3a69f192504be92afef
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p><br>
On Apr 26, 2012 3:47 AM, &quot;Karel Zak&quot; &lt;<a href=3D"mailto:kzak@r=
edhat.com">kzak@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Wed, Apr 25, 2012 at 10:16:51PM -0400, Dave Reisner wrote:<br>
&gt; &gt; On Wed, Apr 25, 2012 at 08:30:52PM -0400, Dave Reisner wrote:<br>
&gt; &gt; &gt; Use the newly exported mnt_get_mountpoint to determine the d=
evice that a<br>
&gt; &gt; &gt; given file resides on, in case the supplied source or target=
 is not<br>
&gt; &gt; &gt; explicitly a mount point.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; <a href=3D"http://www.spinics.net/lists/util-linux-ng/msg060=
81.html">http://www.spinics.net/lists/util-linux-ng/msg06081.html</a><br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Dave Reisner &lt;<a href=3D"mailto:dreisner@a=
rchlinux.org">dreisner@archlinux.org</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt;<br>
&gt; &gt; On second thought, this isn&#39;t good -- it&#39;ll return result=
s even when<br>
&gt; &gt; you&#39;re searching with --fstab (which is completely undesirabl=
e, imo).<br>
&gt;<br>
&gt; =A0I&#39;ll fix it, that&#39;s easy. Thanks.<br>
&gt;<br>
&gt; &gt; &gt; =A0 =A0 m =3D get_match(COL_TARGET);<br>
&gt; &gt; &gt; - =A0 if (m &amp;&amp; !mnt_fs_match_target(fs, m, cache))<b=
r>
&gt; &gt; &gt; + =A0 if (m &amp;&amp; !match_by_file(m, fs, mnt_fs_match_ta=
rget))<br>
&gt; &gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 return rc;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; =A0 =A0 m =3D get_match(COL_SOURCE);<br>
&gt; &gt; &gt; - =A0 if (m &amp;&amp; !mnt_fs_match_source(fs, m, cache))<b=
r>
&gt; &gt; &gt; + =A0 if (m &amp;&amp; !match_by_file(m, fs, mnt_fs_match_so=
urce))<br>
&gt;<br>
&gt; =A0why we need this functionality for SOURCE too?</p>
<p>Ah. Silly of me. We definitely don&#39;t need this.</p>
<p>&gt;<br>
&gt; =A0 =A0Karel<br>
&gt;<br>
&gt; --<br>
&gt; =A0Karel Zak =A0&lt;<a href=3D"mailto:kzak@redhat.com">kzak@redhat.com=
</a>&gt;<br>
&gt; =A0<a href=3D"http://karelzak.blogspot.com">http://karelzak.blogspot.c=
om</a><br>
&gt; --<br>
&gt; To unsubscribe from this list: send the line &quot;unsubscribe util-li=
nux&quot; in<br>
&gt; the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">=
majordomo@vger.kernel.org</a><br>
&gt; More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-=
info.html">http://vger.kernel.org/majordomo-info.html</a><br>
</p>

--e89a8ff1c3a69f192504be92afef--
