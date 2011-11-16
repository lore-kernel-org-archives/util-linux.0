Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:28534 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752653Ab1KPMs7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Nov 2011 07:48:59 -0500
Date: Wed, 16 Nov 2011 13:48:56 +0100
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 07/15] prlimit: fix case when getting missing limit is
	needed and PID is given later
Message-ID: <20111116124855.GF7916@nb.net.home>
References: <4EC07367.1080607@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EC07367.1080607@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 14, 2011 at 02:48:23AM +0100, Bernhard Voelker wrote:
> [PATCH 07/15] prlimit: fix case when getting missing limit is needed and  
> PID is given later

 Applied with some minor changes, thanks.

>  struct prlimit {
>  	struct rlimit rlim;
> +	int found;
>  	struct prlimit_desc *desc;
>  	int modify;
>  };

 I think 'modify' is good enough for everything ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
