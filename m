Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:61835 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935024AbcJTRJN (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 20 Oct 2016 13:09:13 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [ANNOUNCE] util-linux v2.29-rc2
Date: Thu, 20 Oct 2016 19:08:58 +0200
Cc: util-linux@vger.kernel.org
References: <20161019132505.cumn37cmgazlumcu@ws.net.home> <201610201828.05511.sweet_f_a@gmx.de> <20161020164016.olhnllmvwixbvzc4@ws.net.home>
In-Reply-To: <20161020164016.olhnllmvwixbvzc4@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201610201908.58407.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 20 October 2016, Karel Zak wrote:
> On Thu, Oct 20, 2016 at 06:28:05PM +0200, Ruediger Meier wrote:
> > We don't need to handle such broken installation. In drone.io
> > script you could try
> >   apt-get install -qq libncursesw5-dev
>
> We call travis-functions.sh from drone.io, something like:
>
> diff --git a/.travis-functions.sh b/.travis-functions.sh
> index 6fcf019..3766534 100755
> --- a/.travis-functions.sh
> +++ b/.travis-functions.sh
> @@ -95,6 +95,14 @@ function travis_install_script
>  		libsystemd-daemon-dev \
>  		libsystemd-journal-dev \
>
>  		|| true
>
> +
> +	# install only if available
> +	sudo apt-get install -qq >/dev/null \
> +		libncursesw6-dev \
> +		|| sudo apt-get install -qq >/dev/null \
> +			libncursesw5-dev \
> +			|| true
> +
>  }
>
>  function osx_install_script
>
>
> .. I guess we prefer ncurses6. Or it's too crazy? :-)

Just checked, v6 is even not available on the newer Ubuntu Trusty which 
we have on travis. But we are using v6 on OSX already :)

Maybe this would be enough for now

diff --git a/.travis-functions.sh b/.travis-functions.sh
index 6fcf019..3766534 100755
--- a/.travis-functions.sh
+++ b/.travis-functions.sh
@@ -95,6 +95,14 @@ function travis_install_script
 		libsystemd-daemon-dev \
 		libsystemd-journal-dev \
+		libncursesw5-dev \
 		|| true
 }


BTW I find the older libs usually more useful on test systems. Because 
the newer ones are tested already on the developer systems and by 
distro packagers ;)

cu,
Rudi
