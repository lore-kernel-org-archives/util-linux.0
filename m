Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37044 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750975Ab3AXSeB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 24 Jan 2013 13:34:01 -0500
Date: Thu, 24 Jan 2013 19:33:50 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 09/22] more: allow non-interactive invocation of the
 command
Message-ID: <20130124183350.GD27413@x2.net.home>
References: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
 <1358554151-25985-10-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1358554151-25985-10-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jan 19, 2013 at 12:08:58AM +0000, Sami Kerola wrote:
> -	no_tty = tcgetattr(fileno(stdout), &otty);
> +	if (non_interactive == 0)
> +		no_tty = tcgetattr(fileno(stdout), &otty);

I have added #ifdef TEST_PROGRAM to enable non-interactive mode, and
in the tests we use "test_more" binary. It seems less invasive than to
add the -n option.

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
