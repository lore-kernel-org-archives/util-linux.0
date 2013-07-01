Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:1663 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753241Ab3GAJj7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 1 Jul 2013 05:39:59 -0400
Date: Mon, 1 Jul 2013 11:39:49 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/15] pull: sfdisk and dmesg resubmission, plus bits and
 bobs
Message-ID: <20130701093949.GD28709@x2.net.home>
References: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Applied, thanks. Exceptions:

On Sun, Jun 16, 2013 at 07:53:41PM +0100, Sami Kerola wrote:
> Sami Kerola (15):
>       renice: exit with non-zero value when arguments cause warnings
>       sfdisk: use libc error printing function, and symbolic exit values
>       sfdisk: clean up usage() functions
>       sfdisk: use program_invocation_short_name to determine program name
>       docs: correct sfdisk --activate instructions

>       sfdisk: remove --unhide and related functions

 Not applied (--unhide is valid operation, unimplemented was "unhide"
 as command name).

>       sfdisk: replace my_warn() with warnx()
>       dmesg: convert time format bitfield to enum
>       dmesg: add --time-format option
>       dmesg: add iso-8601 time format
>       docs: add --time-format option and ISO-8601 format to manual
>       dmesg: regroup time related options close to each other
>       sd-daemon: update files taken from systemd project
>       hexdump: remove unnecessary global variables

>       hexdump: use simple printing functions when possible

  Not applied (the patch is too aggressive and unportable).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
