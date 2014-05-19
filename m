Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:31384 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751266AbaESJsX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 19 May 2014 05:48:23 -0400
Date: Mon, 19 May 2014 11:48:13 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 06/17] setterm: add option control structure
Message-ID: <20140519094813.GH26357@x2.net.home>
References: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
 <1400421941-14244-7-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1400421941-14244-7-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, May 18, 2014 at 03:05:30PM +0100, Sami Kerola wrote:
> +int main(int argc, char **argv)
> +{
> +	struct setterm_control ctl;
> +	int term_errno;
>  
> +	memset(&ctl, 0, sizeof (ctl));

The memset() call is unnecessary. It's enough to set any struct member
to zeroize whole struct, etc:


  struct setterm_control ctl = { .opt_te_terminal_name = NULL };


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
