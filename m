Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:12838 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751596Ab3H2KLl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 29 Aug 2013 06:11:41 -0400
Date: Thu, 29 Aug 2013 12:11:27 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 10/17] lib/time-util: copy time parsing functions from
 systemd
Message-ID: <20130829101127.GD24438@x2.net.home>
References: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
 <1377626779-26030-10-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1377626779-26030-10-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 27, 2013 at 07:06:12PM +0100, Sami Kerola wrote:
> +static char *startswith(const char *s, const char *prefix)
> +static char *startswith_no_case(const char *s, const char *prefix)
> +static char *endswith(const char *s, const char *postfix)

 We already have startswith() and endswith() in libmount/src/utils.c.

 What about to move the code to lib/strutils.c (together with
 *_no_case() versions)?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
