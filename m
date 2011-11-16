Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:2231 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756550Ab1KPMvv (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Nov 2011 07:51:51 -0500
Date: Wed, 16 Nov 2011 13:51:47 +0100
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 10/15] prlimit: refactor code: separate modify and show
	clearly
Message-ID: <20111116125147.GH7916@nb.net.home>
References: <4EC07375.20005@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EC07375.20005@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 14, 2011 at 02:48:37AM +0100, Bernhard Voelker wrote:
>  struct prlimit {
>  	struct rlimit rlim;
> -	int found;
>  	struct prlimit_desc *desc;
>  	int modify;
> +	int show;
>  };

 I think that 'modify == 0' means 'show'. It's strange to add two
 variables to differentiate between two states.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
