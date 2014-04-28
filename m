Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41850 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755022AbaD1KEE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 28 Apr 2014 06:04:04 -0400
Date: Mon, 28 Apr 2014 12:03:54 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/9] pull: kill tests
Message-ID: <20140428100354.GO2405@x2.net.home>
References: <1397560535-14622-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1397560535-14622-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 15, 2014 at 12:15:26PM +0100, Sami Kerola wrote:
> Sami Kerola (9):
>       kill: make options --pid and --queue mutually exclusive
>       kill: remove unnecessary indirection
>       tests: add signal receiver program
>       tests: check kill is converting signals names correctly
>       tests: check various ways to specify kill signal
>       tests: check kill print pid option
>       tests: check kill all user processes
>       kill: add --verbose option to display what is killed
>       lib/procutils: reset errno before strtol() call

 Merged. I have moved the awk stuff to kill_functions.sh to avoid
 duplicate code in the tests.

 Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
