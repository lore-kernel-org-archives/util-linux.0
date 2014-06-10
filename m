Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:53085 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752407AbaFJPZZ convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 10 Jun 2014 11:25:25 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: =?iso-8859-1?q?P=E1draig_Brady?= <P@draigbrady.com>
Subject: Re: [PATCH] build-sys: use gettext 0.18.3 if possible
Date: Tue, 10 Jun 2014 17:25:21 +0200
Cc: util-linux@vger.kernel.org
References: <1402394931-20416-1-git-send-email-sweet_f_a@gmx.de> <1402394931-20416-2-git-send-email-sweet_f_a@gmx.de> <53970EAF.4010801@draigBrady.com>
In-Reply-To: <53970EAF.4010801@draigBrady.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201406101725.22039.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 10 June 2014, Pádraig Brady wrote:
> On 06/10/2014 11:08 AM, Ruediger Meier wrote:
> > autopoint_fun ()
> > +{
> > +	# we have to deal with set -e ...
> > +	rm -f configure.ac.autogenbak
> > +	ret="0"
> > +	GT_VER_MIN="0.18"
> > +	GT_VER_DEF=$(sed -n 's/AM_GNU_GETTEXT_VERSION(\[\(.*\)\])/\1/p'
> > configure.ac) +	GT_VER_HAVE="$(gettext --version | head -n 1 | sed
> > 's/.* //g')" +
> > +	tmp=$(echo -e "$GT_VER_MIN\n$GT_VER_HAVE" | sort -V | tail -n1)
> > +	tmp=$(echo -e "$GT_VER_DEF\n$tmp" | sort -V | head -n1)
>
> You seem to be relying on coreutils here, using sort -V and tail -n

Yes, I've guessed it's hard to do it fully portable. It's IMO already 
not safely possible parse gettext --version.

To not write much more ugly shell code to handle all this I think about 
only touching configure.ac if all of these commands above succeed as 
expected.
In other words: If it's not easily possible to find an older but good 
gettext version then don't do anything - user has to edit configure.ac 
manually or update to 0.18.3.


Another possibility would be just to hardcode these few allowed 
alternative versions:
---
altver=$(gettext --version |\
	sed -n 's/.* \(0\.18\|0\.18\.[1-2]\)$/\1/p')
test -n "$altver" && # sed configure.ac ...
autopoint ...
---
Very short and portable but to be maintained when version is updated in 
configure.ac

BTW does anybody know what kind of version string you get when using 
gettext from git or beta releae?


> Note echo is exceptionally non portable. Better to use printf
> instead.
>
> thanks,
> Pádraig.
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


