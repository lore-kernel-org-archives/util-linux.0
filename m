Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38530 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750855AbdDCI4F (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 3 Apr 2017 04:56:05 -0400
Date: Mon, 3 Apr 2017 10:56:01 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/3] agetty: make --remote to forward --nohostname as -H
 to login
Message-ID: <20170403085601.g6vpstx7mf3nhyc5@ws.net.home>
References: <20170402081436.861-1-kerolasa@iki.fi>
 <20170402081436.861-3-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170402081436.861-3-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Apr 02, 2017 at 09:14:36AM +0100, Sami Kerola wrote:
> +.IP
> +If an \fB\-\-nohost\fR option is given, then an \fB\-H\fP option
                ^^^^^^
 The name of the option is --nohostname

>  	} else {
> -		if (fakehost && (options.flags & F_REMOTE)) {
> -			login_argv[login_argc++] = "-h";
> -			login_argv[login_argc++] = fakehost;
> +		if (options.flags & F_REMOTE) {
> +			if (fakehost) {
> +				login_argv[login_argc++] = "-h";
> +				login_argv[login_argc++] = fakehost;
> +			} else if (options.flags & F_NOHOSTNAME)
> +				login_argv[login_argc++] = "-H";

 Seems good.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
