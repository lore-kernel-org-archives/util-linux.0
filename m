Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="EKHSv4Ha"
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A963C38
	for <util-linux@vger.kernel.org>; Tue,  5 Dec 2023 03:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
	s=protonmail3; t=1701775362; x=1702034562;
	bh=MAe4VlVL7BsGPmp/FSQvYKAPzndnGmcjRRsLbAGQkyM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=EKHSv4HaA8z/dqyF62CGg8XU+GYiEVaEcZ4HvFIsBOh8TvYGRIRxYZAG5hy3lqOLK
	 1XZSCT2S6Ah2A8rQ27GO9GOJnFH4LqE8Frt5k2YpwkaD9nmG3qDQqrysXI8tPqTrei
	 BXFzf1FioG+C2LCWCqS8LBMUkqHKveqNzu8wgxgtA+F7QBE/64gMP2nUjvGljQenIs
	 oq42bhgk1hlTSOrQs4hH4twL2GutKcelr2XutkiQ9TpwNg1xrusgYUS4Mjm/MXupPf
	 EPJ7gKqOBpaAevThsUtJkH67AFEGTrFCroZ88pYUTJHiOlzpmp7fKOwGR1PlS5oBnK
	 5Mh5KMqU82j+Q==
Date: Tue, 05 Dec 2023 11:22:33 +0000
To: Karel Zak <kzak@redhat.com>
From: Remigiusz Leon Suwalski <remigiusz.suwalski@protonmail.ch>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: Piped `column -t` inserts extra newlines since Oct 2023
Message-ID: <jkAf-CA-4rUJ4xpufgGpkm9pHPUneOPwOpKWAyQ7hyFyv7oyn3mAPB0tqc4hkH5n2Q2oavBo8jFvjdbmA-VjJllFsPAoXDC2M0H2V5pzoJQ=@protonmail.ch>
In-Reply-To: <20231205102603.csxm6luqnayetva5@ws.net.home>
References: <StZBjLc2hfwARaOlTwkjpnqrtWLLL_rya0UmGRk5OFwX1Y1KthwQWBz5bcDpEOjcq2hbJ6aY4fcoAMU3pU2spFhGDbGwmd4puAzNrvspFpE=@protonmail.ch> <20231205102603.csxm6luqnayetva5@ws.net.home>
Feedback-ID: 3678023:user:proton
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,
today I also can't reproduce the problem on HEAD of master but found  anoth=
er file that is not terminated with a newline character for which related i=
ssue occurs. (On my machine problem occurs starting from commit 94feb5a2 me=
ntioned earlier but not on its parent). Since input data is larger than pre=
viously (7kB), I have uploaded it to a pastebin service [1].

$ curl -O https://pastebin.com/raw/gm65ephM
$ column -t < gm65ephM | sort
__  _.__%   _____-_  ..__________-______.___  ____=3D_-___-________________=
_
__  _.__%   _____-_  ..__________-______.___  ____=3D_-___-________________=
_
__  _.__%   _____-_  ..__________-______.___  ____=3D_-___-________________=
_
(... 51 lines follow ...)

$ column -t < gm65ephM
__  __.__%  _____-_  ..__________-______.___  ____=3D_-___-________________=
_      ____________________________________________________________________=
_________
__  __.__%  _____-_  ..__________-______.___  ____=3D_-___-________________=
_      ____________________________________________________________________=
_________
__  __.__%  _____-_  ..__________-______.___  ____=3D_-___-________________=
_      ____________________________________________________________________=
_________

$ diff <(tr -s ' ' < gm65ephM | wc) <(column -t < gm65ephM | tr -s ' ' | wc=
)                  =EE=82=B2 1 =E2=9C=98=20
1c1
<      53     324    7236
---
>      54     270    3834

The problem here is that last column is truncated and the output is signifi=
cantly smaller. Could you please try reproducing this one? If it can't be d=
one then perhaps something is wrong with my PC and the bug report can be cl=
osed.

[1] https://pastebin.com/raw/gm65ephM

Regards,
Leon Suwalski

On Tuesday, December 5th, 2023 at 11:26 AM, Karel Zak <kzak@redhat.com> wro=
te:


> On Mon, Dec 04, 2023 at 05:26:05PM +0000, Remigiusz Leon Suwalski wrote:
>=20
> > Hi,
> > I have discovered that `column` utility behaves oddly when piped to ano=
ther command, as shown on examples below. I am not sure whether this is a b=
ug or intended behaviour.
> >=20
> > First `column` built from sources (commit https://git.kernel.org/pub/sc=
m/utils/util-linux/util-linux.git/commit/?id=3D94feb5a20d23904cc15cd857c4e0=
0f35f495116c):
> > $ echo '_ __ ___ ________ __________ _______' | ./column -t | nl # stra=
nge
> > 1 __
> > 2 ___
> > 3 ___
> > 4 _________
> > 5 __________
> > 6 _______
> > $ echo ' __ ___ ________ __________ _______' | ./column -t > file.txt #=
 the same issue as above
> > $ echo ' __ ___ ________ __________ ________' | ./column -t # expected
> > _ __ ___ ________ __________ ________
>=20
>=20
> I cannot reproduce this on the current devel tree and stable/v2.39
> tree, I see:
>=20
> $ echo '_ __ ___ ________ __________ _______' | ./column -t | nl
> 1 _ __ ___ ________ __________ ________
>=20
>=20
> $ echo ' __ ___ ________ __________ ________' | ./column -t > a
>=20
> $ cat a
> _ __ ___ ________ __________ ________
>=20
>=20
> Karel
>=20
> --
> Karel Zak kzak@redhat.com
>=20
> http://karelzak.blogspot.com
