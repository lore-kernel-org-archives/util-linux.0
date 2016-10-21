Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:50067 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934220AbcJUPDw (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 21 Oct 2016 11:03:52 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [ANNOUNCE] util-linux v2.29-rc2
Date: Fri, 21 Oct 2016 17:03:42 +0200
Cc: util-linux@vger.kernel.org
References: <20161019132505.cumn37cmgazlumcu@ws.net.home> <201610201908.58407.sweet_f_a@gmx.de> <20161021144422.o26grlgiop32tsep@ws.net.home>
In-Reply-To: <20161021144422.o26grlgiop32tsep@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201610211703.42691.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Friday 21 October 2016, Karel Zak wrote:
> On Thu, Oct 20, 2016 at 07:08:58PM +0200, Ruediger Meier wrote:
> > Just checked, v6 is even not available on the newer Ubuntu Trusty
> > which we have on travis. But we are using v6 on OSX already :)
> >
> > Maybe this would be enough for now
> >
> > diff --git a/.travis-functions.sh b/.travis-functions.sh
> > index 6fcf019..3766534 100755
> > --- a/.travis-functions.sh
> > +++ b/.travis-functions.sh
> > @@ -95,6 +95,14 @@ function travis_install_script
> >  		libsystemd-daemon-dev \
> >  		libsystemd-journal-dev \
> > +		libncursesw5-dev \
> >
> >  		|| true
> >
> >  }
>
> Still bad, see
>
>   https://drone.io/github.com/karelzak/util-linux/643:
>
>         /usr/bin/ld: cannot find -lncursesw
>
> but it complains about systemd only:
>
>         W: You may want to run apt-get update to correct these
> problems E: Unable to locate package libsystemd-daemon-dev
>         E: Unable to locate package libsystemd-journal-dev
>

Ah sorry this was my fault because I had just edited your posted 
diff. :)

We need to add libncursesw5-dev to the first apt-get command. Otherwise 
libncursesw5 fails along with the missing systemd stuff.

        sudo apt-get install -qq >/dev/null \
                bc \
                btrfs-tools \
                dnsutils \
                libcap-ng-dev \
 +              libncursesw5-dev \
                libpam-dev \
                libudev-dev \
                gtk-doc-tools \
                mdadm \
                ntp \
                socat \
                || return

        # install only if available (e.g. Ubuntu Trusty)
        sudo apt-get install -qq >/dev/null \
                libsystemd-daemon-dev \
                libsystemd-journal-dev \
                || true



> and configure:
>
>
>         checking ncursesw... (v5) yes
>         checking ncursesw/ncurses.h usability... no
>         checking ncursesw/ncurses.h presence... no
>         checking for ncursesw/ncurses.h... no
>         checking ncurses.h usability... yes
>         checking ncurses.h presence... yes
>         checking for ncurses.h... yes
>         checking for use_default_colors in -lncursesw... no
>         checking for resizeterm in -lncursesw... no
>
>   Karel


