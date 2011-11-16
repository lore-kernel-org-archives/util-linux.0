Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:12291 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752653Ab1KPMlU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Nov 2011 07:41:20 -0500
Date: Wed, 16 Nov 2011 13:41:15 +0100
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 03/15] prlimit: fix diagnostic when setting current
	PIDs resources fails
Message-ID: <20111116124115.GC7916@nb.net.home>
References: <4EC07357.1030002@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EC07357.1030002@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 14, 2011 at 02:48:07AM +0100, Bernhard Voelker wrote:
> [PATCH 03/15] prlimit: fix diagnostic when setting current PIDs  
> resources fails

 Not applied, but I have improved the error messages according to your
 5-8 patches.

> -			err(EXIT_FAILURE, _("failed to get resource limits for PID %d"), pid);
> +		if (prlimit(pid, lims[i].desc->resource, new, &lims[i].rlim) == -1) {
> +			if (pid)
> +				err(EXIT_FAILURE, _("failed to get resource limits for PID %d"), pid);
> +			else
> +				err(EXIT_FAILURE, _("failed to get resource limits of the current  
> process"));

 I think we don't have to care about the PID in the error message at
 all. The util works always with one PID only.

    "failed to set the %s resource limit"
 or
    "failed to get the %s resource limit"

 seems enough :-)

   Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
