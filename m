Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ve0-f175.google.com ([209.85.128.175]:51862 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613Ab3EESPo convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 5 May 2013 14:15:44 -0400
Received: by mail-ve0-f175.google.com with SMTP id m1so2648131ves.6
        for <util-linux@vger.kernel.org>; Sun, 05 May 2013 11:15:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGXs5wU+m3utoCQapgGfd4fOaTnJTQ+5Bmj0bOZwA8Wx2R8_Kw@mail.gmail.com>
References: <CAGXs5wVLX+aq2D5D5SOaSYSjt1i3V_RNy9XXv1ti8vZdBoDCEg@mail.gmail.com>
	<20130505161231.GA7764@type.youpi.perso.aquilenet.fr>
	<CAGXs5wU+m3utoCQapgGfd4fOaTnJTQ+5Bmj0bOZwA8Wx2R8_Kw@mail.gmail.com>
Date: Sun, 5 May 2013 21:15:42 +0300
Message-ID: <CAGXs5wVA54qwmwUQ6aJJ-JWJCLXXfG5F-6EfT9h1_xX8rRW9mQ@mail.gmail.com>
Subject: Re: error with util-linux from git
From: Kevin Wilson <wkevils@gmail.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Kevin Wilson <wkevils@gmail.com>, util-linux@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,
Now..


make[1]: Leaving directory `/work/src/util-linux'
root@amd:/work/src/util-linux# make
make  all-recursive
make[1]: Entering directory `/work/src/util-linux'
Making all in po
make[2]: Entering directory `/work/src/util-linux/po'
test -z "ca.gmo cs.gmo da.gmo de.gmo es.gmo et.gmo eu.gmo fi.gmo
fr.gmo gl.gmo hr.gmo hu.gmo id.gmo it.gmo ja.gmo nl.gmo pl.gmo
pt_BR.gmo ru.gmo sl.gmo sv.gmo tr.gmo uk.gmo vi.gmo zh_CN.gmo
zh_TW.gmo" || make ca.gmo cs.gmo da.gmo de.gmo es.gmo et.gmo eu.gmo
fi.gmo fr.gmo gl.gmo hr.gmo hu.gmo id.gmo it.gmo ja.gmo nl.gmo pl.gmo
pt_BR.gmo ru.gmo sl.gmo sv.gmo tr.gmo uk.gmo vi.gmo zh_CN.gmo
zh_TW.gmo
make[3]: Entering directory `/work/src/util-linux/po'
: --update ca.po util-linux.pot
rm -f ca.gmo && : -c --statistics -o ca.gmo ca.po
mv: cannot stat ‘t-ca.gmo’: No such file or directory
make[3]: *** [ca.gmo] Error 1
make[3]: Leaving directory `/work/src/util-linux/po'
make[2]: *** [stamp-po] Error 2
make[2]: Leaving directory `/work/src/util-linux/po'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/work/src/util-linux'
make: *** [all] Error 2


googled for it, install gettext by apt-get install gettext, but this
did not help

any ideas?
rgs
KW

On Sun, May 5, 2013 at 8:57 PM, Kevin Wilson <wkevils@gmail.com> wrote:
> Hi,
> Thanks, apt-get install pkg-config solved it
> rgs
> Kevin
>
>
> On Sun, May 5, 2013 at 7:12 PM, Samuel Thibault
> <samuel.thibault@ens-lyon.org> wrote:
>> Kevin Wilson, le Sun 05 May 2013 19:08:42 +0300, a écrit :
>>> any ideas?
>>
>> Install pkg-config on your system, or anything which would ship
>> pkg.m4
>>
>> Samuel
