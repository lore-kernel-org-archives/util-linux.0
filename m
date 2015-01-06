Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44399 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755256AbbAFLLq (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 6 Jan 2015 06:11:46 -0500
Date: Tue, 6 Jan 2015 12:11:35 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 22/22] script: use correct input type, move comment, and
 so on
Message-ID: <20150106111135.GF18528@x2.net.home>
References: <1419700655-19107-1-git-send-email-kerolasa@iki.fi>
 <1419700655-19107-9-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1419700655-19107-9-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Dec 27, 2014 at 05:17:35PM +0000, Sami Kerola wrote:
> +	/*
> +	 * script -t prints time delays as floating point numbers.  The example
> +	 * program (scriptreplay) that we provide to handle this timing output

..pretty obsolete information, scriptreplay is in C since 2008:-)

I'll merge the script(1) changes later this week, I need to play with
that little bit more.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
