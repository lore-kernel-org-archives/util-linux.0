Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35232 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752887AbbCPNc4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Mar 2015 09:32:56 -0400
Date: Mon, 16 Mar 2015 14:32:53 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] tailf: deprecated
Message-ID: <20150316133253.GN28925@ws.net.home>
References: <1426259377-15288-1-git-send-email-sweet_f_a@gmx.de>
 <1426259377-15288-2-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426259377-15288-2-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Mar 13, 2015 at 04:09:36PM +0100, Ruediger Meier wrote:
>  Documentation/deprecated.txt |  5 +++++
>  tests/expected/tailf/simple  |  1 +
>  text-utils/tailf.1           |  6 ++++++
>  text-utils/tailf.c           | 16 ++++++++++++----
>  4 files changed, 24 insertions(+), 4 deletions(-)

Boys you're so bad.. I use tailf! Well, both patches applied :-)

>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <unistd.h>
> @@ -246,6 +251,9 @@ int main(int argc, char **argv)
>  	textdomain(PACKAGE);
>  	atexit(close_stdout);
>  
> +	warnx(_("warning: "
> +		"use of 'tailf' is deprecated, use 'tail -f' instead"));

moved to usage() to avoid regression in output.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
