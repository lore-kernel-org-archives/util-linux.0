Return-Path: fmayhar@google.com
MIME-Version: 1.0
Date: Wed, 7 Mar 2012 09:26:01 -0800
Message-ID: <CAKp+pw25HZ4siP69WH6OQ_r=XgTGzk0n9BYTg-h4gXsJLs0y2A@mail.gmail.com>
Subject: Re: [PATCH 1/4] fsck: Add a -r option to report memory and runtime statistics.
From: Frank Mayhar <fmayhar@google.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: multipart/alternative; boundary=14dae9340c9f14b7d004baaa744d
List-ID: <util-linux.vger.kernel.org>

--14dae9340c9f14b7d004baaa744d
Content-Type: text/plain; charset=ISO-8859-1

On Mar 6, 2012 4:54 AM, "Karel Zak" <kzak@redhat.com> wrote:
>
> On Tue, Feb 07, 2012 at 01:10:50PM -0800, Frank Mayhar wrote:
> >  fsck/fsck.8 |   12 +++++++++++-
> >  fsck/fsck.c |   38 +++++++++++++++++++++++++++++++++++++-
> >  fsck/fsck.h |    2 ++
> >  3 files changed, 50 insertions(+), 2 deletions(-)
>
>  Finally I have time to work on fsck. I have created temporary branch
>  at github for this task:
>
>    https://github.com/karelzak/util-linux/commits/fsck
>
>  changes:
>
>  - fsck is only one fsck.c file, moved to disk-utils
>  - use libmount to parse fstab and for is_mounted() function
>  - does not use obsolete lib/fsprobe.c
>
> > +\    /dev/hdc1 status 0 maxrss 92828
> > +.br
> > +\    /dev/hdc1 user 2.677592 system 0.861868 elapsed 4
>
>  I have merged all to one line, final format is:
>
> /dev/sda1: status 0, rss 92828, real 4.002804, user 2.677592, sys 0.86186
>
>  The real/user/sys should be more compatible with time(1) now (so the
>  'real' is based on gettimeofday() although it's not so important for
>  fsck).

I'm out on disability (again, sigh) and won't be following this, but I just
wanted to say thanks for the work. Ted T'so will be following up on the
rest, btw.

--14dae9340c9f14b7d004baaa744d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>On Mar 6, 2012 4:54 AM, &quot;Karel Zak&quot; &lt;<a href=3D"mailto:kzak=
@redhat.com">kzak@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Tue, Feb 07, 2012 at 01:10:50PM -0800, Frank Mayhar wrote:<br>
&gt; &gt; =A0fsck/fsck.8 | =A0 12 +++++++++++-<br>
&gt; &gt; =A0fsck/fsck.c | =A0 38 +++++++++++++++++++++++++++++++++++++-<br=
>
&gt; &gt; =A0fsck/fsck.h | =A0 =A02 ++<br>
&gt; &gt; =A03 files changed, 50 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; =A0Finally I have time to work on fsck. I have created temporary branc=
h<br>
&gt; =A0at github for this task:<br>
&gt;<br>
&gt; =A0 =A0<a href=3D"https://github.com/karelzak/util-linux/commits/fsck"=
>https://github.com/karelzak/util-linux/commits/fsck</a><br>
&gt;<br>
&gt; =A0changes:<br>
&gt;<br>
&gt; =A0- fsck is only one fsck.c file, moved to disk-utils<br>
&gt; =A0- use libmount to parse fstab and for is_mounted() function<br>
&gt; =A0- does not use obsolete lib/fsprobe.c<br>
&gt;<br>
&gt; &gt; +\ =A0 =A0/dev/hdc1 status 0 maxrss 92828<br>
&gt; &gt; +.br<br>
&gt; &gt; +\ =A0 =A0/dev/hdc1 user 2.677592 system 0.861868 elapsed 4<br>
&gt;<br>
&gt; =A0I have merged all to one line, final format is:<br>
&gt;<br>
&gt; /dev/sda1: status 0, rss 92828, real 4.002804, user 2.677592, sys 0.86=
186<br>
&gt;<br>
&gt; =A0The real/user/sys should be more compatible with time(1) now (so th=
e<br>
&gt; =A0&#39;real&#39; is based on gettimeofday() although it&#39;s not so =
important for<br>
&gt; =A0fsck).</p>
<p>I&#39;m out on disability (again, sigh) and won&#39;t be following this,=
 but I just wanted to say thanks for the work. Ted T&#39;so will be followi=
ng up on the rest, btw.</p>

--14dae9340c9f14b7d004baaa744d--
