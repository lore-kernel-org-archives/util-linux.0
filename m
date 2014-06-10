Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:53276 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440AbaFJRvK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 10 Jun 2014 13:51:10 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: =?iso-8859-1?q?P=E1draig_Brady?= <P@draigbrady.com>
Subject: Re: [PATCH] build-sys: use gettext 0.18.3 if possible
Date: Tue, 10 Jun 2014 19:51:07 +0200
Cc: util-linux@vger.kernel.org
References: <1402394931-20416-1-git-send-email-sweet_f_a@gmx.de> <53970EAF.4010801@draigBrady.com> <201406101725.22039.sweet_f_a@gmx.de>
In-Reply-To: <201406101725.22039.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201406101951.07829.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 10 June 2014, Ruediger Meier wrote:
> On Tuesday 10 June 2014, Pdraig Brady wrote:
> >
> > You seem to be relying on coreutils here, using sort -V and tail -n
>

> Another possibility would be just to hardcode these few allowed
> alternative versions:
> [...]
> Very short and portable but to be maintained when version is updated
> in configure.ac

Ok, now I've choosed this compromise, see the full function below or 
patch here
https://github.com/karelzak/util-linux/pull/97

------------
# provide simple gettext backward compatibility
autopoint_fun ()
{
	# check against this hardcoded set of alternative gettext versions
	gt_ver=`gettext --version |\
		sed -n -e 's/.* \(0\.18\|0\.18\.[1-2]\)$/\1/p'`

	if [ -n "$gt_ver" ]; then
		echo "warning, force autopoint to use old gettext $gt_ver"
		rm -f configure.ac.autogenbak
		sed -i.autogenbak configure.ac \
			-e "s/\(AM_GNU_GETTEXT_VERSION\).*/\1([$gt_ver])/"
	fi

	autopoint "$@" || ret=$?
	ret=$?

	if [ -n "$gt_ver" ]; then
		mv configure.ac.autogenbak configure.ac
	fi

	return $ret
}
---------

Note, sed -i is also not portable but we are using it already at another 
place.

Also note that my first more generic solution with "sort --version-sort" 
was almost useless anyway because autopoint itself can also only deal 
with a few hardcoded versions, and it would not work for rc or beta 
versions, see

$ grep -A12 "Check whether the version" /usr/bin/autopoint
# Check whether the version number is supported.
case "$ver" in
  0.10.35 | 0.10.36 | 0.10.37 | 0.10.38 | 0.10.39 | 0.10.40 | \
  0.11 | 0.11.1 | 0.11.2 | 0.11.3 | 0.11.4 | 0.11.5 | \
  0.12 | 0.12.1 | \
  0.13 | 0.13.1 | \
  0.14 | 0.14.1 | 0.14.2 | 0.14.3 | 0.14.4 | 0.14.5 | 0.14.6 | \
  0.15 | \
  0.16 | 0.16.1 | \
  0.17 | \
  0.18 | 0.18.1 | 0.18.2 | 0.18.3 )
    ;;
  *)

For me this looks really stupid. By design it wouldn't be possible (or 
at least no sense) to release 0.18.4 now since 0.19 is out already...

IMO our autopoint_fun feature should be an option for autpoint if not 
even the default behavior.

cu,
Rudi
