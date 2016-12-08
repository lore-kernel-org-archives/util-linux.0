Return-Path: halfline@gmail.com
MIME-Version: 1.0
In-Reply-To: <20161208112441.5kckrt7cofh2opbz@ws.net.home>
References: <1477427661-19788-1-git-send-email-halfline@gmail.com>
 <CAA_Uwz+od5AwWosSzb_j59v2LvdZ=ipmHe2s+_kZiccC6v-FnQ@mail.gmail.com>
 <201612072104.37323.sweet_f_a@gmx.de> <20161208112441.5kckrt7cofh2opbz@ws.net.home>
From: Ray Strode <halfline@gmail.com>
Date: Thu, 8 Dec 2016 10:00:43 -0500
Message-ID: <CAA_UwzLaHYUx6po+TJFN7HyHRkBRwBGCeLjO70aoFAPtMS4_iQ@mail.gmail.com>
Subject: Re: [PATCH] login-utils: import environment from user manager on
 systemd systems
To: Karel Zak <kzak@redhat.com>, Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org, Lennart Poettering <lennart@poettering.net>
Content-Type: multipart/alternative; boundary=94eb2c0b321a061bd7054326e823
List-ID: <util-linux.vger.kernel.org>

--94eb2c0b321a061bd7054326e823
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu, Dec 8, 2016 at 6:24 AM Karel Zak <kzak@redhat.com> wrote:

> We had positive feedback about it from Red Hat PAM maintainer, but it
> would be probably better to discuss it with PAM upstream. This change
> will require a new stuff in PAM API.
>
Pretty sure Tomas is one of the upstream maintainers, but you're right,
discussion should take place upstream.

Although I'm not sure why we need systemd as mediator, would be
> possible to read the environment setting directly by login(1)? Or it's
> expected that something (e.g. script) will be executed to get the session
> initialized?
>
The point is, the environment of systemd --user services and processes
started
inside a logind registered session should get the same environment.  It
doesn't
really make sense for them to get out of sync. login(1) could try to read
all the
same environment configuration files as systemd, but systemd gets its
environment
from a variety of places (user.conf / systemd service files /
/etc/environment.d), so
I think getting the environment from the user manager is the best way to go.

--Ray

--94eb2c0b321a061bd7054326e823
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div><br><div class=3D"gmail_quote"><div dir=3D"ltr=
">On Thu, Dec 8, 2016 at 6:24 AM Karel Zak &lt;<a href=3D"mailto:kzak@redha=
t.com" target=3D"_blank">kzak@redhat.com</a>&gt; wrote:<br class=3D"gmail-m=
_-7792605547943226730gmail_msg"></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
We had positive feedback about it from Red Hat PAM maintainer, but it<br cl=
ass=3D"gmail-m_-7792605547943226730gmail_msg">
would be probably better to discuss it with PAM upstream. This change<br cl=
ass=3D"gmail-m_-7792605547943226730gmail_msg">
will require a new stuff in PAM API.=C2=A0<br></blockquote><div>Pretty sure=
 Tomas is one of the upstream maintainers, but you&#39;re right,<br>discuss=
ion should take place upstream.<br><br> </div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">

Although I&#39;m not sure why we need systemd as mediator, would be<br clas=
s=3D"gmail-m_-7792605547943226730gmail_msg">
possible to read the environment setting directly by login(1)? Or it&#39;s<=
br class=3D"gmail-m_-7792605547943226730gmail_msg">
expected that something (e.g. script) will be executed to get the session<b=
r class=3D"gmail-m_-7792605547943226730gmail_msg">
initialized?<br class=3D"gmail-m_-7792605547943226730gmail_msg"></blockquot=
e><div>The point is, the environment of systemd --user services and process=
es started<br></div><div>inside a logind registered session should get the =
same environment.=C2=A0 It doesn&#39;t<br></div><div>really make sense for =
them to get out of sync. login(1) could try to read all the<br></div><div>s=
ame environment configuration files as systemd, but systemd gets its enviro=
nment<br></div><div>from a variety of places (user.conf / systemd service f=
iles / /etc/environment.d), so<br></div><div>I think getting the environmen=
t from the user manager is the best way to go.<br><br></div><div>--Ray<br><=
/div><div>=C2=A0<br></div></div></div></div>

--94eb2c0b321a061bd7054326e823--
