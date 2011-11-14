Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.187]:60587 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148Ab1KNBrd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Nov 2011 20:47:33 -0500
Message-ID: <4EC07330.5050406@bernhard-voelker.de>
Date: Mon, 14 Nov 2011 02:47:28 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH 00/15] prlimit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

prlimit was not very graceful regarding option parsing.

The central change of this series is done in [PATCH 11/15]
which changes the way the lims array is used/filled.
Others prepare the code to have a smaller main patch,
or fix problems which arouse from the different use
of the lims array.

[PATCH 01/15] prlimit: show all limits if called without options
[PATCH 02/15] prlimit: add opt_id array to match short options to limit ids
[PATCH 03/15] prlimit: fix diagnostic when setting current PIDs 
resources fails
[PATCH 04/15] prlimit: add warning diagnostic when attempting to change 
prlimit's limits
[PATCH 05/15] prlimit: fix diagnostic when setting a limit fails
[PATCH 06/15] prlimit: enhance diagnostic when changing a limit fails: 
add limit name
[PATCH 07/15] prlimit: fix case when getting missing limit is needed and 
PID is given later
[PATCH 08/15] prlimit: give better diagnostic for illegal hard limit case
[PATCH 09/15] prlimit: fix typo in man page, option --verbose
[PATCH 10/15] prlimit: refactor code: separate modify and show clearly
[PATCH 11/15] prlimit: avoid segfault due to array-out-of-bounds error
[PATCH 12/15] prlimit: add note to man page that setting limits without 
--pid is pointless.
[PATCH 13/15] prlimit: enhance examples section of the man page
[PATCH 14/15] prlimit: avoid prlimit syscalls for limits unless to 
modify or to show
[PATCH 15/15] prlimit: fix displaying of modified limits

I hope I didn't screw up too much. Please let me know what you think 
about it.

Have a nice day,
Berny


