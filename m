Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59980 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756067AbaBFNcq (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 6 Feb 2014 08:32:46 -0500
Date: Thu, 6 Feb 2014 14:00:11 +0100
From: Karel Zak <kzak@redhat.com>
To: Richard Weinberger <richard@nod.at>
Cc: ebiederm@xmission.com, util-linux@vger.kernel.org, davidlohr.bueso@hp.com
Subject: Re: [PATCH] nsenter: Allow selecting the uid and gid to be used in
 the entered userns
Message-ID: <20140206130011.GA12324@x2.net.home>
References: <1366917100-10581-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366917100-10581-1-git-send-email-richard@nod.at>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Apr 25, 2013 at 09:11:40PM +0200, Richard Weinberger wrote:
> +	if (namespaces & CLONE_NEWUSER) {
> +		if (set_uid)
> +			if (setuid(uid) < 0)
> +				err(EXIT_FAILURE, _("setuid failed"));
> +		if (set_gid)
> +			if (setgid(gid) < 0)
> +				err(EXIT_FAILURE, _("setgid failed"));

 Ah.. we make a bug here, it has to be in reverse order (gid and then uid).

 The another question is what about supplementary groups? Do we care
 about it? If yes, we need initgroups(), otherwise it would be
 probably better to drop all by setgroups(0, NULL).
 
 I guess it's over-engineering to try to reimplement su(1) within nsenter,
 so drop the supplementary group is the right way.
 
    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
