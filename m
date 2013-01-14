Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:6466 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754564Ab3ANI3D (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Jan 2013 03:29:03 -0500
Date: Mon, 14 Jan 2013 09:28:46 +0100
From: Karel Zak <kzak@redhat.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, util-linux@vger.kernel.org,
        Neil Horman <nhorman@tuxdriver.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: [PATCH] nsenter: new command (light wrapper around setns)
Message-ID: <20130114082846.GA16421@x2.net.home>
References: <876234812z.fsf@xmission.com>
 <20130111161320.GA16206@x2.net.home>
 <87fw27jq29.fsf_-_@xmission.com>
 <201301111845.16591.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201301111845.16591.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jan 11, 2013 at 06:45:14PM -0500, Mike Frysinger wrote:
> path should be const
> 
> > +			namespace_target_pid = strtoul(optarg, &end, 10);
> > +			if (!*optarg || (*optarg && *end) || errno != 0) {
> > +				err(EXIT_FAILURE,
> > +				    _("Pid '%s' is not a valid number"),
> > +				    optarg);
> > +			}
> 
> we really should introduce an xstroul() helper

see include/strutils.h

  namespace_target_pid = strtoul_or_err(optarg, _("failed to parse pid"));

    Karel



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
