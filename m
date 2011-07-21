Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:62580 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752515Ab1GUTDc (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 21 Jul 2011 15:03:32 -0400
Date: Thu, 21 Jul 2011 21:03:28 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [git pull] schedutils
Message-ID: <20110721190328.GH22568@nb.net.home>
References: <CAG27Bk0XXawQERH19+iUguDame2Pts_+bvrt8Of0+ib9KSW3NA@mail.gmail.com> <20110718221751.GD4354@nb.redhat.com> <CAG27Bk3vs54m7b6y_M_uq4RuyPBn-yhAEt2GhicsyY8F_+jJfw@mail.gmail.com> <20110721154303.GF22568@nb.net.home> <CAG27Bk1R_fG+SkFd1JfoiEyg7z8saJv4V+=K02Cz8_OHL9tz=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAG27Bk1R_fG+SkFd1JfoiEyg7z8saJv4V+=K02Cz8_OHL9tz=w@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jul 21, 2011 at 08:37:52PM +0200, Sami Kerola wrote:
> >  * I think that
> >        -c, --class NUM
> >   is better than
> >        -c, --class=NUM
> 
> With equals sign is FSFism, which seemed like good starting point...

 :-)

 The '=' is required only for optional arguments, the it's probably
 the best to use

    --foo[=NUM]

> >  I have fixed this in ionice man page, but not in usage(). It would be
> >  nice to use in all man pages and usage() functions the same syntax.
> >  Maybe we can create any template or so to have it documented.
> 
> ...but you are absolutely right again. Converting README.devel in
> small chunks to a Documentation directory might be a way to go.

 Good idea!

> Contents of the directory could have help_and_version.txt for what you
> said above, and I can recall recent minix & kernel headers
> conversation which ought also be documented.

 OK.

> BTW what would you think about having a util-linux.h with inline

 Should be enough to use c.h ?

> function to print in usage help & version option descriptions and
> proper version output function. The first would make translation teams
> happier when they do not need to write time after time the same
> translations. Second would simply unify how version is printed, and if

 Well, .po files never contains duplicate strings.

> it ever needs a modification it's easier to do.

 I agree.

> In practice the file would be similar to coreutils system.h.

 Hmm... I don't like 

  #define case_GETOPT_VERSION_CHAR(Program_name, Authors)
          case GETOPT_VERSION_CHAR:


 We don't use the same char everywhere and hide keywords (e.g. case)
 to macros is not nice too.
 
 It would be enough to use 

   case 'V':
        ul_print_version();
        break;
        
 The result should be readable C language, not any gnulib meta-language :-)

   Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
