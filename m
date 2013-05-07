Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:3309 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757305Ab3EGHQg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 7 May 2013 03:16:36 -0400
Date: Tue, 7 May 2013 09:16:21 +0200
From: Karel Zak <kzak@redhat.com>
To: Kevin Wilson <wkevils@gmail.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, util-linux@vger.kernel.org
Subject: Re: error with util-linux from git
Message-ID: <20130507071621.GB29882@x2.net.home>
References: <CAGXs5wVLX+aq2D5D5SOaSYSjt1i3V_RNy9XXv1ti8vZdBoDCEg@mail.gmail.com>
 <20130505161231.GA7764@type.youpi.perso.aquilenet.fr>
 <CAGXs5wU+m3utoCQapgGfd4fOaTnJTQ+5Bmj0bOZwA8Wx2R8_Kw@mail.gmail.com>
 <CAGXs5wVA54qwmwUQ6aJJ-JWJCLXXfG5F-6EfT9h1_xX8rRW9mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAGXs5wVA54qwmwUQ6aJJ-JWJCLXXfG5F-6EfT9h1_xX8rRW9mQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, May 05, 2013 at 09:15:42PM +0300, Kevin Wilson wrote:
> Making all in po
> make[2]: Entering directory `/work/src/util-linux/po'
> test -z "ca.gmo cs.gmo da.gmo de.gmo es.gmo et.gmo eu.gmo fi.gmo
> fr.gmo gl.gmo hr.gmo hu.gmo id.gmo it.gmo ja.gmo nl.gmo pl.gmo
> pt_BR.gmo ru.gmo sl.gmo sv.gmo tr.gmo uk.gmo vi.gmo zh_CN.gmo
> zh_TW.gmo" || make ca.gmo cs.gmo da.gmo de.gmo es.gmo et.gmo eu.gmo
> fi.gmo fr.gmo gl.gmo hr.gmo hu.gmo id.gmo it.gmo ja.gmo nl.gmo pl.gmo
> pt_BR.gmo ru.gmo sl.gmo sv.gmo tr.gmo uk.gmo vi.gmo zh_CN.gmo
> zh_TW.gmo
> make[3]: Entering directory `/work/src/util-linux/po'
> : --update ca.po util-linux.pot
> rm -f ca.gmo && : -c --statistics -o ca.gmo ca.po
> mv: cannot stat ‘t-ca.gmo’: No such file or directory
> make[3]: *** [ca.gmo] Error 1
> make[3]: Leaving directory `/work/src/util-linux/po'
> make[2]: *** [stamp-po] Error 2
> make[2]: Leaving directory `/work/src/util-linux/po'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/work/src/util-linux'
> make: *** [all] Error 2

 Hmm... never seen that, try

    git clean -xdf
    ./autogen.sh
    ./configure
    make


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
