Return-Path: util-linux-owner@vger.kernel.org
Received: from smtprelay-h21.telenor.se ([195.54.99.196]:33099 "EHLO
	smtprelay-h21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbaHDJtw (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 4 Aug 2014 05:49:52 -0400
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-h21.telenor.se (Postfix) with ESMTP id 86B48C059
	for <util-linux@vger.kernel.org>; Mon,  4 Aug 2014 11:49:50 +0200 (CEST)
Date: Mon, 4 Aug 2014 11:49:48 +0200
From: Andreas Henriksson <andreas@fatal.se>
To: Mike Frysinger <vapier@gentoo.org>
Cc: YunQiang Su <wzssyqa@gmail.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] libmount/buildsys: move SELINUX_LIBS to LDFLAGS
Message-ID: <20140804094948.GA32065@fatal.se>
References: <1407010261-17305-1-git-send-email-andreas@fatal.se>
 <2625005.WTIbfJcupg@vapier>
 <20140803202309.GA26295@fatal.se>
 <7003188.HrNgjPCK9Z@vapier>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7003188.HrNgjPCK9Z@vapier>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Version: 2.25-1

Hello Mike!

Thank you very much for the followup and for identifying the relevant
commit for me!
(BCCing the debian bug tracking system to close the bug report...)

On Mon, Aug 04, 2014 at 03:40:56AM -0400, Mike Frysinger wrote:
[...]
> the problem is that libmount_la_DEPENDENCIES shows up in the Makefile like:
> libmount.la: ... $(libmount_la_DEPENDENCIES) ...
> 
> which means make evaluates it like so:
> libmount.la: ... -lselinux -lsepol ...
> 
> which triggers the builtin library path searching of make itself:
> https://www.gnu.org/software/make/manual/make.html#Libraries_002fSearch
> 
> which means it'll rewrite -lselinux into /usr/lib/libselinux.so (if it can 
> find it) which is bad for multilib and cross-compiling.
> 
> the easy answer is to not add LIBADD to DEPENDENCIES.  which has been done 
> already -- see dbf7043ea1d090d283cfd36280bb14189d8e35b1.
> 
[...]


Regards,
Andreas Henriksson
