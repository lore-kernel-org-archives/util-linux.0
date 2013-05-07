Return-Path: wkevils@gmail.com
MIME-Version: 1.0
In-Reply-To: <20130507071621.GB29882@x2.net.home>
References: <CAGXs5wVLX+aq2D5D5SOaSYSjt1i3V_RNy9XXv1ti8vZdBoDCEg@mail.gmail.com>
	<20130505161231.GA7764@type.youpi.perso.aquilenet.fr>
	<CAGXs5wU+m3utoCQapgGfd4fOaTnJTQ+5Bmj0bOZwA8Wx2R8_Kw@mail.gmail.com>
	<CAGXs5wVA54qwmwUQ6aJJ-JWJCLXXfG5F-6EfT9h1_xX8rRW9mQ@mail.gmail.com>
	<20130507071621.GB29882@x2.net.home>
Date: Tue, 7 May 2013 10:18:42 +0300
Message-ID: <CAGXs5wV6cBECt_hQ2ve_7BxQj0X=s6HaqG9ueBwPF1FgPvrocQ@mail.gmail.com>
Subject: Re: error with util-linux from git
From: Kevin Wilson <wkevils@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, util-linux@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>

Hi,
Thanks
In the meantime, I deleted the util-linux and cloned it again and it was OK=
,
rgs
Kevin

On Tue, May 7, 2013 at 10:16 AM, Karel Zak <kzak@redhat.com> wrote:
> On Sun, May 05, 2013 at 09:15:42PM +0300, Kevin Wilson wrote:
>> Making all in po
>> make[2]: Entering directory `/work/src/util-linux/po'
>> test -z "ca.gmo cs.gmo da.gmo de.gmo es.gmo et.gmo eu.gmo fi.gmo
>> fr.gmo gl.gmo hr.gmo hu.gmo id.gmo it.gmo ja.gmo nl.gmo pl.gmo
>> pt_BR.gmo ru.gmo sl.gmo sv.gmo tr.gmo uk.gmo vi.gmo zh_CN.gmo
>> zh_TW.gmo" || make ca.gmo cs.gmo da.gmo de.gmo es.gmo et.gmo eu.gmo
>> fi.gmo fr.gmo gl.gmo hr.gmo hu.gmo id.gmo it.gmo ja.gmo nl.gmo pl.gmo
>> pt_BR.gmo ru.gmo sl.gmo sv.gmo tr.gmo uk.gmo vi.gmo zh_CN.gmo
>> zh_TW.gmo
>> make[3]: Entering directory `/work/src/util-linux/po'
>> : --update ca.po util-linux.pot
>> rm -f ca.gmo && : -c --statistics -o ca.gmo ca.po
>> mv: cannot stat =91t-ca.gmo=92: No such file or directory
>> make[3]: *** [ca.gmo] Error 1
>> make[3]: Leaving directory `/work/src/util-linux/po'
>> make[2]: *** [stamp-po] Error 2
>> make[2]: Leaving directory `/work/src/util-linux/po'
>> make[1]: *** [all-recursive] Error 1
>> make[1]: Leaving directory `/work/src/util-linux'
>> make: *** [all] Error 2
>
>  Hmm... never seen that, try
>
>     git clean -xdf
>     ./autogen.sh
>     ./configure
>     make
>
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
