Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:24221 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752487Ab3FGKUh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 7 Jun 2013 06:20:37 -0400
Date: Fri, 7 Jun 2013 12:20:28 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 04/19] sfdisk: use libc error printing function, and
 symbolic exit values
Message-ID: <20130607102028.GA9955@x2.net.home>
References: <1370195485-27907-1-git-send-email-kerolasa@iki.fi>
 <1370195485-27907-5-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1370195485-27907-5-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 02, 2013 at 06:51:10PM +0100, Sami Kerola wrote:
>      if ((out = lseek(fd, in, SEEK_SET)) != in) {
>  	perror("lseek");
> -	error(_("seek error on %s - cannot seek to %lu\n"), dev, s);
> +	warnx(_("seek error on %s - cannot seek to %lu"), dev, s);
>  	return 0;

 I don't think that perror() + warnx() is elegant solution, just use
 warn() only.

 warn(_("seek failed %s" - cannot seek to %lu"), dev, s);

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
