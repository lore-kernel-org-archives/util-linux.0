Return-Path: util-linux-owner@vger.kernel.org
Received: from damascus.uab.es ([158.109.168.135]:10127 "EHLO damascus.uab.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751225Ab1KNIyN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Nov 2011 03:54:13 -0500
Received: from damascus.uab.es ([127.0.0.1])
 by damascus.uab.es (Sun Java System Messaging Server 6.1 HotFix 0.10 (built
 Jan  6 2005)) with ESMTP id <0LUN00AY87DMCV40@damascus.uab.es> for
 util-linux@vger.kernel.org; Mon, 14 Nov 2011 09:53:46 +0100 (CET)
Received: from aomail.uab.es ([158.109.65.1])
 by damascus.uab.es (Sun Java	System Messaging Server 6.1 HotFix 0.10 (builtJan
 6 2005)) with ESMTP id	<0LUN00BS57DM3P80@damascus.uab.es>
 forutil-linux@vger.kernel.org; Mon, 14 Nov 2011 09:53:46 +0100 (CET)
Date: Mon, 14 Nov 2011 11:56:27 +0100
From: Davidlohr Bueso <dave@gnu.org>
Subject: Re: [PATCH 00/15] prlimit
In-reply-to: <4EC07330.5050406@bernhard-voelker.de>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux@vger.kernel.org
Message-id: <1321268187.8015.4.camel@offworld>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
References: <4EC07330.5050406@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, 2011-11-14 at 02:47 +0100, Bernhard Voelker wrote:
> prlimit was not very graceful regarding option parsing.
> 
> The central change of this series is done in [PATCH 11/15]
> which changes the way the lims array is used/filled.
> Others prepare the code to have a smaller main patch,
> or fix problems which arouse from the different use
> of the lims array.
> 
> [PATCH 01/15] prlimit: show all limits if called without options
> [PATCH 02/15] prlimit: add opt_id array to match short options to limit ids
> [PATCH 03/15] prlimit: fix diagnostic when setting current PIDs 
> resources fails
> [PATCH 04/15] prlimit: add warning diagnostic when attempting to change 
> prlimit's limits
> [PATCH 05/15] prlimit: fix diagnostic when setting a limit fails
> [PATCH 06/15] prlimit: enhance diagnostic when changing a limit fails: 
> add limit name
> [PATCH 07/15] prlimit: fix case when getting missing limit is needed and 
> PID is given later
> [PATCH 08/15] prlimit: give better diagnostic for illegal hard limit case
> [PATCH 09/15] prlimit: fix typo in man page, option --verbose
> [PATCH 10/15] prlimit: refactor code: separate modify and show clearly
> [PATCH 11/15] prlimit: avoid segfault due to array-out-of-bounds error
> [PATCH 12/15] prlimit: add note to man page that setting limits without 
> --pid is pointless.
> [PATCH 13/15] prlimit: enhance examples section of the man page
> [PATCH 14/15] prlimit: avoid prlimit syscalls for limits unless to 
> modify or to show
> [PATCH 15/15] prlimit: fix displaying of modified limits
> 
> I hope I didn't screw up too much. Please let me know what you think 
> about it.

Thanks for looking into this, this is a very new program that needs as
much testing as possible before the 2.21 release.

> 
> Have a nice day,
> Berny
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


