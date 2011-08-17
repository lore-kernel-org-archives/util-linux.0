Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.8]:59256 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843Ab1HQOM4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 17 Aug 2011 10:12:56 -0400
Message-ID: <4E4BCC65.2060100@bernhard-voelker.de>
Date: Wed, 17 Aug 2011 16:12:53 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: losetup --all --verbose results in usage
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I was surprised that running
	mount/losetup --all --verbose
results in usage().

As -a is the option to list all used loop devices,
one might think that -v adds some more info to the output.

Neither --help nor the man pages nor the info page tells
that -a doesn't accept other options:

mount/lomount.c (line 1133):

         } else if (all) {
                 if (argc > 2)
                         usage(stderr);

Should we work on this?
If it's not possible to output more information with
-v, then it would maybe make sense to ignore it, right?

Have a nice day,
Berny
