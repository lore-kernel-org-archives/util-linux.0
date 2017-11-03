Return-Path: jpewhacker@gmail.com
MIME-Version: 1.0
In-Reply-To: <20171103110045.ubmpbq2jjnmznjqg@ws.net.home>
References: <1509399672.6057.30.camel@gmail.com> <20171103110045.ubmpbq2jjnmznjqg@ws.net.home>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Fri, 3 Nov 2017 09:17:38 -0500
Message-ID: <CAJdd5GbN2ZYi11fZ+dp=XK18Aq14eFNxNsOL7VbUUpq+A5PC3w@mail.gmail.com>
Subject: Re: History of Lazy and Force unmouting
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: multipart/alternative; boundary="001a1145cc9c6057ab055d14c4a3"
List-ID: <util-linux.vger.kernel.org>

--001a1145cc9c6057ab055d14c4a3
Content-Type: text/plain; charset="UTF-8"

On Nov 3, 2017 06:00, "Karel Zak" <kzak@redhat.com> wrote:

On Mon, Oct 30, 2017 at 04:41:12PM -0500, Joshua Watt wrote:
> I was hoping to get some background on why the util-linux umount
> command doesn't allow lazy unmounting (the -l flag) to be combined with
> force unmounting (the -f flag). If both flags are specified, umount
> only passes MNT_DETACH to the kernel instead of MNT_DETACH | MNT_FORCE.

The current libmount code follows the original mount(*) behavior. The
flag MNT_DETACH is supported since util-linux 2.11m (year 2001).

>  I looked through the kernel code, and it appears that the two flags
> are orthogonal, so you *should* be able to specify both? I tried
> looking back in the git history of util-linux, but it appears to have
> been that way since support for lazy unmounting was added in 2006.

2006 is time when the code was imported to the git. The important
tarball are older.

Anyway, does it make sense to use the both flags in the same time?

>From kernel code it seems that MNT_FORCE forces FS driver to kill all
resources (by op->umount_begin()) before the umount, so what do you
expect from later MNT_DETACH?


I'm currently in discussion with the kernel nfs team about the MNT_FORCE
behavior, specifically that it doesn't shut everything down. I came across
this oddity in my testing and was curious if it was on purpose.

http://www.spinics.net/lists/linux-nfs/msg66073.html


The problem is that libmount prefers MNT_DETACH, so if you specify
both flags that MNT_FORCE is silently ignored. It would be better
prefer MNT_FORCE or accept both flags and don't try to be more smart
than kernel.


Ok. I'll submit a patch after I get home from vacation.


    Karel

--
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

--001a1145cc9c6057ab055d14c4a3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On Nov 3, 2017 06:00, &quot;Karel Zak&quot; &lt;<a href=3D"mailto=
:kzak@redhat.com">kzak@redhat.com</a>&gt; wrote:<br type=3D"attribution"><b=
lockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex"><div class=3D"quoted-text">On Mon, Oct 30, 2017 at 0=
4:41:12PM -0500, Joshua Watt wrote:<br>
&gt; I was hoping to get some background on why the util-linux umount<br>
&gt; command doesn&#39;t allow lazy unmounting (the -l flag) to be combined=
 with<br>
&gt; force unmounting (the -f flag). If both flags are specified, umount<br=
>
&gt; only passes MNT_DETACH to the kernel instead of MNT_DETACH | MNT_FORCE=
.<br>
<br>
</div>The current libmount code follows the original mount(*) behavior. The=
<br>
flag MNT_DETACH is supported since util-linux 2.11m (year 2001).<br>
<div class=3D"quoted-text"><br>
&gt;=C2=A0 I looked through the kernel code, and it appears that the two fl=
ags<br>
&gt; are orthogonal, so you *should* be able to specify both? I tried<br>
&gt; looking back in the git history of util-linux, but it appears to have<=
br>
&gt; been that way since support for lazy unmounting was added in 2006.<br>
<br>
</div>2006 is time when the code was imported to the git. The important<br>
tarball are older.<br>
<br>
Anyway, does it make sense to use the both flags in the same time?<br>
<br>
>From kernel code it seems that MNT_FORCE forces FS driver to kill all<br>
resources (by op-&gt;umount_begin()) before the umount, so what do you<br>
expect from later MNT_DETACH?<br></blockquote></div></div></div><div dir=3D=
"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_extra"><div class=3D=
"gmail_quote"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex"></blockquote></div></div></div><div =
dir=3D"auto">I&#39;m currently in discussion with the kernel nfs team about=
 the MNT_FORCE behavior, specifically that it doesn&#39;t shut everything d=
own. I came across this oddity in my testing and was curious if it was on p=
urpose.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><a href=3D"http:=
//www.spinics.net/lists/linux-nfs/msg66073.html">http://www.spinics.net/lis=
ts/linux-nfs/msg66073.html</a><br></div><div dir=3D"auto"><br></div><div di=
r=3D"auto"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquot=
e class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">
<br>
The problem is that libmount prefers MNT_DETACH, so if you specify<br>
both flags that MNT_FORCE is silently ignored. It would be better<br>
prefer MNT_FORCE or accept both flags and don&#39;t try to be more smart<br=
>
than kernel.<br></blockquote></div></div></div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">Ok. I&#39;ll submit a patch after I get home from vacatio=
n.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_e=
xtra"><div class=3D"gmail_quote"><blockquote class=3D"quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<font color=3D"#888888"><br>
=C2=A0 =C2=A0 Karel<br>
<br>
--<br>
=C2=A0Karel Zak=C2=A0 &lt;<a href=3D"mailto:kzak@redhat.com">kzak@redhat.co=
m</a>&gt;<br>
=C2=A0<a href=3D"http://karelzak.blogspot.com" rel=3D"noreferrer" target=3D=
"_blank">http://karelzak.blogspot.com</a><br>
</font></blockquote></div><br></div></div></div>

--001a1145cc9c6057ab055d14c4a3--
