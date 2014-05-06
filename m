Return-Path: luto@amacapital.net
MIME-Version: 1.0
In-Reply-To: <201405061350.s46DoVxC008646@hobgoblin.ariadne.com>
References: <CALCETrUbaFwpdiLBv7G8GbkgUuiEgyyBWn0dr8R57NzCdSL9gg@mail.gmail.com>
	<201405022221.s42MLpT4015462@hobgoblin.ariadne.com>
	<CALCETrUU6ziKYA3RSb_6nEW4HyeR5BLGQ_3SgcnnnLnBX1us0g@mail.gmail.com>
	<201405052250.s45Monxm008110@hobgoblin.ariadne.com>
	<CALCETrXTJpkA-EqzS=kvSfS4QEO5Gc3TV42+FFrUbQN3ALfuCw@mail.gmail.com>
	<20140506094631.GG5962@x2.net.home>
	<201405061350.s46DoVxC008646@hobgoblin.ariadne.com>
Date: Tue, 6 May 2014 08:38:02 -0700
Message-ID: <CALCETrUBTf=Wyz76Y3T=2CXqtKNhgK1YVgmBv1mEh85mNt4MKA@mail.gmail.com>
Subject: Re: getting rid of "mount: only root can ..."
From: Andy Lutomirski <luto@amacapital.net>
To: "Dale R. Worley" <worley@alum.mit.edu>
Cc: util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Content-Type: multipart/alternative; boundary=bcaec51b9a8d8ec12f04f8bd0898
List-ID: <util-linux.vger.kernel.org>

--bcaec51b9a8d8ec12f04f8bd0898
Content-Type: text/plain; charset=UTF-8

On May 6, 2014 6:50 AM, "Dale R. Worley" <worley@alum.mit.edu> wrote:
>
> > From: Karel Zak <kzak@redhat.com>
>
> > I'll try to improve it to make it more usable with user namespaces.
> > The problem is that mount(8) is not just about mount(2) call only. If
> > we drop privileges then mount(8) will report problems with things like
> > FS detection, loopdevs setups, etc. It's necessary to review the code
> > and make errors/warnings somehow usable. ... added to my TODO for the
> > next week ;-)
>
> Yeah, that's the only thing that will work well:  Have mount(8) and
> the kernel both know what the rules are and enforce them
> consistently.  And ideally, mount(8) should tell the user exactly what
> the rule is that's being violated.
>

A kind of hackish solution would be for mount --nopriv or whatever to drop
privileges immediately and stop enforcing any policy at all.

--Andy

--bcaec51b9a8d8ec12f04f8bd0898
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On May 6, 2014 6:50 AM, &quot;Dale R. Worley&quot; &lt;<a href=3D"mailto:wo=
rley@alum.mit.edu">worley@alum.mit.edu</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; From: Karel Zak &lt;<a href=3D"mailto:kzak@redhat.com">kzak@redha=
t.com</a>&gt;<br>
&gt;<br>
&gt; &gt; I&#39;ll try to improve it to make it more usable with user names=
paces.<br>
&gt; &gt; The problem is that mount(8) is not just about mount(2) call only=
. If<br>
&gt; &gt; we drop privileges then mount(8) will report problems with things=
 like<br>
&gt; &gt; FS detection, loopdevs setups, etc. It&#39;s necessary to review =
the code<br>
&gt; &gt; and make errors/warnings somehow usable. ... added to my TODO for=
 the<br>
&gt; &gt; next week ;-)<br>
&gt;<br>
&gt; Yeah, that&#39;s the only thing that will work well: =C2=A0Have mount(=
8) and<br>
&gt; the kernel both know what the rules are and enforce them<br>
&gt; consistently. =C2=A0And ideally, mount(8) should tell the user exactly=
 what<br>
&gt; the rule is that&#39;s being violated.<br>
&gt;</p>
<p dir=3D"ltr">A kind of hackish solution would be for mount --nopriv or wh=
atever to drop privileges immediately and stop enforcing any policy at all.=
</p>
<p dir=3D"ltr">--Andy<br>
</p>

--bcaec51b9a8d8ec12f04f8bd0898--
