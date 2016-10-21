Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58818 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934425AbcJUOoY (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 21 Oct 2016 10:44:24 -0400
Date: Fri, 21 Oct 2016 16:44:22 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.29-rc2
Message-ID: <20161021144422.o26grlgiop32tsep@ws.net.home>
References: <20161019132505.cumn37cmgazlumcu@ws.net.home>
 <201610201828.05511.sweet_f_a@gmx.de>
 <20161020164016.olhnllmvwixbvzc4@ws.net.home>
 <201610201908.58407.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201610201908.58407.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Oct 20, 2016 at 07:08:58PM +0200, Ruediger Meier wrote:
> Just checked, v6 is even not available on the newer Ubuntu Trusty which 
> we have on travis. But we are using v6 on OSX already :)
> 
> Maybe this would be enough for now
> 
> diff --git a/.travis-functions.sh b/.travis-functions.sh
> index 6fcf019..3766534 100755
> --- a/.travis-functions.sh
> +++ b/.travis-functions.sh
> @@ -95,6 +95,14 @@ function travis_install_script
>  		libsystemd-daemon-dev \
>  		libsystemd-journal-dev \
> +		libncursesw5-dev \
>  		|| true
>  }

Still bad, see

  https://drone.io/github.com/karelzak/util-linux/643:

        /usr/bin/ld: cannot find -lncursesw

but it complains about systemd only:

        W: You may want to run apt-get update to correct these problems
        E: Unable to locate package libsystemd-daemon-dev
        E: Unable to locate package libsystemd-journal-dev
   

and configure:


        checking ncursesw... (v5) yes
        checking ncursesw/ncurses.h usability... no
        checking ncursesw/ncurses.h presence... no
        checking for ncursesw/ncurses.h... no
        checking ncurses.h usability... yes
        checking ncurses.h presence... yes
        checking for ncurses.h... yes
        checking for use_default_colors in -lncursesw... no
        checking for resizeterm in -lncursesw... no

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
