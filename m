Return-Path: bernhard.voelker@siemens-enterprise.com
From: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
To: Karel Zak <kzak@redhat.com>
CC: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Date: Wed, 9 Nov 2011 12:16:32 +0100
Subject: RE: prlimit: SYS_prlimit undeclared on OpenSuSE 11.4
Message-ID: <7856072A9D04C24B82DFE2B1112FE38A0D86B2EC4C@MCHP058A.global-ad.net>
References: <7856072A9D04C24B82DFE2B1112FE38A0D86B2EBA0@MCHP058A.global-ad.net>
 <20111109105526.GK16397@nb.net.home>
In-Reply-To: <20111109105526.GK16397@nb.net.home>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

Karel Zak: wrote:=20
> On Wed, Nov 09, 2011 at 10:32:06AM +0100, Voelker, Bernhard wrote:
> > Compiling the new prlimit (from latest git pull)
> > fails here on "openSUSE 11.4 (x86_64)":
> >=20
> >   CC     prlimit.o
> > prlimit.c: In function 'prlimit':
> > prlimit.c:139:17: error: 'SYS_prlimit' undeclared (first use in this fu=
nction)
>
>  Should be SYS_prlimit64. Fixed, git pull and try it again.

thanks, it works.

Have a nice day,
Berny
