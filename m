Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41642 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755686Ab3FGK2M (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 7 Jun 2013 06:28:12 -0400
Date: Fri, 7 Jun 2013 12:28:02 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/19] pull: various clean ups and couple bug fixes
Message-ID: <20130607102802.GB9955@x2.net.home>
References: <1370195485-27907-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1370195485-27907-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 02, 2013 at 06:51:06PM +0100, Sami Kerola wrote:
>       lib: remove unused code
>       lscpu: add max MHz value to make cpu governor effects more visible
>       docs: add lscpu max mhz to manual and bash completion

 Applied.

>       sfdisk: use libc error printing function, and symbolic exit values
>       sfdisk: clean up usage() functions
>       sfdisk: use program_invocation_short_name to determine program name
>       docs: correct sfdisk --activate instructions
>       sfdisk: remove --unhide and related functions
>       sfdisk: replace my_warn() with warnx()

 Not applied.

>       rev: stop adding new line at the end when input does not have it
>       rev: simplify new line detection and impossible test
>       rev: reduce stream checking when closing read-only file descriptor

 Applied.

>       dmesg: make time format parsing to use enum bit field
>       dmesg: add --time-format option
>       dmesg: add iso-8601 time format
>       docs: add --time-format option and ISO-8601 format to manual
>       dmesg: make usage() a little bit shorter
>       dmesg: more deterministic boot time detection

 Not applied.

>       cal: fix few type mismatches

 Applied.


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
