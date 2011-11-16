Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:24514 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752839Ab1KPM47 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Nov 2011 07:56:59 -0500
Date: Wed, 16 Nov 2011 13:56:55 +0100
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 11/15] prlimit: avoid segfault due to
	array-out-of-bounds error
Message-ID: <20111116125655.GI7916@nb.net.home>
References: <4EC07379.8090102@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EC07379.8090102@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 14, 2011 at 02:48:41AM +0100, Bernhard Voelker wrote:
> [PATCH 11/15] prlimit: avoid segfault due to array-out-of-bounds error
>
> prlimit used 1 element of the lims array per limit given on the command
> line argument, not being aware that a user would pass the value of the
> soft and the hard limit in different options - leading to a segfault
> when the user passes more than MAX_RESOURCES limit options.
> As a side effect, a limit was retrieved and printed several times if
> the corresponding option appeared multiple times.
>
> Example:
> $ prlimit -l -l -l -l -l -l -l -l -l -l -l -l -l -l -l -l -l -l -l
> RESOURCE DESCRIPTION                         SOFT   HARD UNITS
> MEMLOCK  max locked-in-memory address space 65536 262144 bytes
> MEMLOCK  max locked-in-memory address space 65536 262144 bytes
> ...
> Segmentation fault

 Ah.. stupid bug.

> Use the lims array in a more direct way, i.e. the index is limit id.
> Initialize lims array and adapt option parsing in main() accordingly.
> do_prlimits() and show_limits(): loop over all MAX_RESOURCES in the
> lims array.

 It means that users cannot control order of the printed and modified
 resources. We prefer in all our new utils that output is fully
 controlled by users -- only this is a way how you can create stable
 and robust scripts.

 I have replaced the array with list (see include/list.h). This
 solution makes the code more readable and robust.

 # ./prlimit --data --nofile
 RESOURCE DESCRIPTION                   SOFT      HARD UNITS
 DATA     max data size            unlimited unlimited bytes
 NOFILE   max amount of open files      1001      3000 

 # ./prlimit --nofile --data
 RESOURCE DESCRIPTION                   SOFT      HARD UNITS
 NOFILE   max amount of open files      1001      3000 
 DATA     max data size            unlimited unlimited bytes

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
