Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:7178 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755331Ab1KPMpn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Nov 2011 07:45:43 -0500
Date: Wed, 16 Nov 2011 13:45:37 +0100
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 04/15] prlimit: add warning diagnostic when attempting
	to change prlimit's limits
Message-ID: <20111116124537.GD7916@nb.net.home>
References: <4EC0735B.2010504@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EC0735B.2010504@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 14, 2011 at 02:48:11AM +0100, Bernhard Voelker wrote:
> +		if (lims[i].modify) {
> +			if (!pid)
> +				warnx(_("setting limits of the prlimit process is pointless"));

 Well, I don't think that we want such warnings in our utils :-) Let's
 inform users about errors, the rest should be described in man pages.

 Anyway, it would be nice to have something like:

    prlimit --nofile=1000 /bin/program

 so somewhere after show_limits() should be exec().
    
        Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
