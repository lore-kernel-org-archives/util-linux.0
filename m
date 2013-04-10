Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51915 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936176Ab3DJMiV (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 10 Apr 2013 08:38:21 -0400
Date: Wed, 10 Apr 2013 14:38:13 +0200
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] bash-completion: add swapoff
Message-ID: <20130410123813.GD26442@x2.net.home>
References: <1365586581-30512-1-git-send-email-mail@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365586581-30512-1-git-send-email-mail@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 10, 2013 at 11:36:21AM +0200, Bernhard Voelker wrote:
>  bash-completion/swapoff | 56 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 bash-completion/swapoff

 Applied, thanks.

> +	case $cur in
> +		-*)
> +			OPTS="-a
> +				-L
> +				-U
> +				-v
> +				--all
> +				--verbose
> +				--help
> +				--version"

 We prefer long options (so I have removed -a and -v).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
