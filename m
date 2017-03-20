Return-Path: daniel.stekloff@gmail.com
MIME-Version: 1.0
Sender: daniel.stekloff@gmail.com
In-Reply-To: <000ad5f7-f6cf-a54a-f6c9-405ad4017cda@gmail.com>
References: <6affdcde-0ec0-87ee-45f8-7da32ae1d1a5@gmail.com>
 <CAG27Bk3uXbmBs9cY8gK34YJuUVEY11CdGB0-ibiTQ9feXg_9og@mail.gmail.com> <000ad5f7-f6cf-a54a-f6c9-405ad4017cda@gmail.com>
From: Daniel Stekloff <dan@wendan.org>
Date: Mon, 20 Mar 2017 13:11:47 -0700
Message-ID: <CAO71PiPUKgNDFQpusXaa=DNx+44uN=bB7MqkfdsqFT2Vqogt9Q@mail.gmail.com>
Subject: Re: sysfsutils, aka systool, candidate for inclusion in util-linux-ng
To: Xose Vazquez Perez <xose.vazquez@gmail.com>
Cc: Sami Kerola <kerolasa@iki.fi>, Karel Zak <kzak@redhat.com>,
	Ananth Mavinakayanahalli <ananth@in.ibm.com>, Daniel Stekloff <dan@wendan.org>, Mohan Kumar <mohan@in.ibm.com>,
	Nitin Vashisth <vnitin@in.ibm.com>, util-linux <util-linux@vger.kernel.org>
Content-Type: multipart/alternative; boundary=001a1141d0fa160605054b2f23ec
List-ID: <util-linux.vger.kernel.org>

--001a1141d0fa160605054b2f23ec
Content-Type: text/plain; charset=UTF-8

Thank you for contacting me even though I haven't worked with sysfsutils
for a very long time. I'm honestly a little surprised it is still used.

I think the proposal is good. Please let me know if you need my assistance
with anything.


On Sat, Mar 18, 2017 at 12:58 PM, Xose Vazquez Perez <xose.vazquez@gmail.com
> wrote:

> On 03/18/2017 08:41 PM, Sami Kerola wrote:
>
> > On 17 March 2017 at 17:47, Xose Vazquez Perez <xose.vazquez@gmail.com>
> wrote:
> >> Description: utilities for interfacing with sysfs.
> >>
> >> Background: unmaintained since ten years, included in
> >> enterprise distributions and widely used with plenty of
> >> downloads: https://sourceforge.net/projects/linux-diag/files/
> sysfsutils/stats/timeline?dates=2003-07-01++to+2017-03-17
> >>
> >>
> >> $HOME: https://linux-diag.sf.net/Sysfsutils.html  <--- HTTPS broken!!
> >> $HOME: http://linux-diag.sf.net/Sysfsutils.html
> >> Source code: https://sf.net/projects/linux-diag/files/sysfsutils/
> >
> > Good proposal, and after quick test to migrate sysfsutils to
> > util-linux this seems
> > do-able. But before proceeding any further I want to hear from Karel and
> old
> > sysfsutils maintainer if the project merge what is wanted.
> >
> >   git://github.com/kerolasa/lelux-utiliteetit.git sysfsutils
> >
> > If yes next steps:
> >
> > 1. polish libsysfs, add for example .sym file
> > 2. polish systool, add translations, and other standard util-linux
> > conventions, such as atexit hook, xmalloc usage, and so on
> > 3. figure out what should be done with dlist_test, get_device,
> > get_driver, and get_module
> > 4. add tests, and make _PART_SYS_SYSTEM stuff work
> > 5. without a doubt something other as well
> > 6. send a pull month or two later
>
> Cced the rest of the sysfsutils crew.
>

--001a1141d0fa160605054b2f23ec
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you for contacting me even though I haven&#39;t work=
ed with sysfsutils for a very long time. I&#39;m honestly a little surprise=
d it is still used.<div><br></div><div>I think the proposal is good. Please=
 let me know if you need my assistance with anything.<br><div><br></div></d=
iv></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Sat, =
Mar 18, 2017 at 12:58 PM, Xose Vazquez Perez <span dir=3D"ltr">&lt;<a href=
=3D"mailto:xose.vazquez@gmail.com" target=3D"_blank">xose.vazquez@gmail.com=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 03/18/2017 08:4=
1 PM, Sami Kerola wrote:<br>
<br>
&gt; On 17 March 2017 at 17:47, Xose Vazquez Perez &lt;<a href=3D"mailto:xo=
se.vazquez@gmail.com">xose.vazquez@gmail.com</a>&gt; wrote:<br>
&gt;&gt; Description: utilities for interfacing with sysfs.<br>
&gt;&gt;<br>
&gt;&gt; Background: unmaintained since ten years, included in<br>
&gt;&gt; enterprise distributions and widely used with plenty of<br>
&gt;&gt; downloads: <a href=3D"https://sourceforge.net/projects/linux-diag/=
files/sysfsutils/stats/timeline?dates=3D2003-07-01++to+2017-03-17" rel=3D"n=
oreferrer" target=3D"_blank">https://sourceforge.net/<wbr>projects/linux-di=
ag/files/<wbr>sysfsutils/stats/timeline?<wbr>dates=3D2003-07-01++to+2017-03=
-<wbr>17</a><br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; $HOME: <a href=3D"https://linux-diag.sf.net/Sysfsutils.html" rel=
=3D"noreferrer" target=3D"_blank">https://linux-diag.sf.net/<wbr>Sysfsutils=
.html</a>=C2=A0 &lt;--- HTTPS broken!!<br>
&gt;&gt; $HOME: <a href=3D"http://linux-diag.sf.net/Sysfsutils.html" rel=3D=
"noreferrer" target=3D"_blank">http://linux-diag.sf.net/<wbr>Sysfsutils.htm=
l</a><br>
&gt;&gt; Source code: <a href=3D"https://sf.net/projects/linux-diag/files/s=
ysfsutils/" rel=3D"noreferrer" target=3D"_blank">https://sf.net/projects/li=
nux-<wbr>diag/files/sysfsutils/</a><br>
&gt;<br>
&gt; Good proposal, and after quick test to migrate sysfsutils to<br>
&gt; util-linux this seems<br>
&gt; do-able. But before proceeding any further I want to hear from Karel a=
nd old<br>
&gt; sysfsutils maintainer if the project merge what is wanted.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0git://<a href=3D"http://github.com/kerolasa/lelux-utilitee=
tit.git" rel=3D"noreferrer" target=3D"_blank">github.com/kerolasa/<wbr>lelu=
x-utiliteetit.git</a> sysfsutils<br>
&gt;<br>
&gt; If yes next steps:<br>
&gt;<br>
&gt; 1. polish libsysfs, add for example .sym file<br>
&gt; 2. polish systool, add translations, and other standard util-linux<br>
&gt; conventions, such as atexit hook, xmalloc usage, and so on<br>
&gt; 3. figure out what should be done with dlist_test, get_device,<br>
&gt; get_driver, and get_module<br>
&gt; 4. add tests, and make _PART_SYS_SYSTEM stuff work<br>
&gt; 5. without a doubt something other as well<br>
&gt; 6. send a pull month or two later<br>
<br>
Cced the rest of the sysfsutils crew.<br>
</blockquote></div><br></div>

--001a1141d0fa160605054b2f23ec--
